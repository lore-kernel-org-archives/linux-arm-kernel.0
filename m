From: keescook@chromium.org (Kees Cook)
Date: Wed,  4 Mar 2015 17:27:02 -0800
Subject: [PATCH v3 2/8] arm: use asm-generic for seccomp.h
In-Reply-To: <1425518828-16017-1-git-send-email-keescook@chromium.org>
References: <1425518828-16017-1-git-send-email-keescook@chromium.org>
Message-ID: <1425518828-16017-3-git-send-email-keescook@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Switch to using the newly created asm-generic/seccomp.h for the seccomp
strict mode syscall definitions. Definitions were identical.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/arm/include/asm/Kbuild    |  1 +
 arch/arm/include/asm/seccomp.h | 11 -----------
 2 files changed, 1 insertion(+), 11 deletions(-)
 delete mode 100644 arch/arm/include/asm/seccomp.h

diff --git a/arch/arm/include/asm/Kbuild b/arch/arm/include/asm/Kbuild
index fe74c0d1e485..d7be5a9fd171 100644
--- a/arch/arm/include/asm/Kbuild
+++ b/arch/arm/include/asm/Kbuild
@@ -22,6 +22,7 @@ generic-y += preempt.h
 generic-y += resource.h
 generic-y += rwsem.h
 generic-y += scatterlist.h
+generic-y += seccomp.h
 generic-y += sections.h
 generic-y += segment.h
 generic-y += sembuf.h
diff --git a/arch/arm/include/asm/seccomp.h b/arch/arm/include/asm/seccomp.h
deleted file mode 100644
index 52b156b341f5..000000000000
--- a/arch/arm/include/asm/seccomp.h
+++ /dev/null
@@ -1,11 +0,0 @@
-#ifndef _ASM_ARM_SECCOMP_H
-#define _ASM_ARM_SECCOMP_H
-
-#include <linux/unistd.h>
-
-#define __NR_seccomp_read __NR_read
-#define __NR_seccomp_write __NR_write
-#define __NR_seccomp_exit __NR_exit
-#define __NR_seccomp_sigreturn __NR_rt_sigreturn
-
-#endif /* _ASM_ARM_SECCOMP_H */
-- 
1.9.1
