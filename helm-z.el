;;; helm-z.el --- Show z directory list with helm.el support.

;; Copyright (C) 2017 by yynozk

;; Author: yynozk <yynozk@gmail.com>
;; Version: 0.1
;; Package-Requires: ((helm "1.0"))
;; Keywords: helm, dired, z

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Installation:

;; (require 'helm-z)

;;; Code:


(require 'helm)
(require 'dired)


(defun helm-z-cd ()
  (call-process-shell-command (format "cd %s" (dired-current-directory))))
(add-hook 'dired-after-readin-hook 'helm-z-cd)


(defvar helm-source-z
  (helm-build-in-buffer-source "z"
    :init (lambda ()
            (helm-init-candidates-in-buffer 'global
              (shell-command-to-string "z -l | sed 's/[0-9]*[[:space:]]*//'")))
    :action '(("Go" . (lambda (candidate) (dired candidate))))))


;;;###autoload
(defun helm-z ()
  (interactive)
  (helm :sources '(helm-source-z)
        :buffer "*Helm z source*"))


(provide 'helm-z)
