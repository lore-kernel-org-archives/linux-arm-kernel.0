From: keescook@chromium.org (Kees Cook)
Date: Wed,  4 Mar 2015 17:27:00 -0800
Subject: [PATCH v3 0/8] switch to using asm-generic for seccomp.h
Message-ID: <1425518828-16017-1-git-send-email-keescook@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Most architectures don't need to do much special for the strict-mode
seccomp syscall entries. Remove the redundant headers and reduce the
others.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
v3:
- split patch series by architecture
- fix up architectures that need sigreturn overrides (ingo)
v2:
- use Kbuild "generic-y" instead of explicit #include lines (sfr)
