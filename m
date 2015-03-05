From: keescook@chromium.org (Kees Cook)
Date: Wed,  4 Mar 2015 17:27:05 -0800
Subject: [PATCH v3 5/8] parisc: switch to using asm-generic for seccomp.h
In-Reply-To: <1425518828-16017-1-git-send-email-keescook@chromium.org>
References: <1425518828-16017-1-git-send-email-keescook@chromium.org>
Message-ID: <1425518828-16017-6-git-send-email-keescook@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Switch to using the newly created asm-generic/seccomp.h for the seccomp
strict mode syscall definitions. Definitions were identical.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/parisc/include/asm/Kbuild    |  1 +
 arch/parisc/include/asm/seccomp.h | 16 ----------------
 2 files changed, 1 insertion(+), 16 deletions(-)
 delete mode 100644 arch/parisc/include/asm/seccomp.h

diff --git a/arch/parisc/include/asm/Kbuild b/arch/parisc/include/asm/Kbuild
index 8686237a3c3c..12b341d04f88 100644
--- a/arch/parisc/include/asm/Kbuild
+++ b/arch/parisc/include/asm/Kbuild
@@ -20,6 +20,7 @@ generic-y += param.h
 generic-y += percpu.h
 generic-y += poll.h
 generic-y += preempt.h
+generic-y += seccomp.h
 generic-y += segment.h
 generic-y += topology.h
 generic-y += trace_clock.h
diff --git a/arch/parisc/include/asm/seccomp.h b/arch/parisc/include/asm/seccomp.h
deleted file mode 100644
index 015f7887aa29..000000000000
--- a/arch/parisc/include/asm/seccomp.h
+++ /dev/null
@@ -1,16 +0,0 @@
-#ifndef _ASM_PARISC_SECCOMP_H
-#define _ASM_PARISC_SECCOMP_H
-
-#include <linux/unistd.h>
-
-#define __NR_seccomp_read __NR_read
-#define __NR_seccomp_write __NR_write
-#define __NR_seccomp_exit __NR_exit
-#define __NR_seccomp_sigreturn __NR_rt_sigreturn
-
-#define __NR_seccomp_read_32 __NR_read
-#define __NR_seccomp_write_32 __NR_write
-#define __NR_seccomp_exit_32 __NR_exit
-#define __NR_seccomp_sigreturn_32 __NR_rt_sigreturn
-
-#endif	/* _ASM_PARISC_SECCOMP_H */
-- 
1.9.1
