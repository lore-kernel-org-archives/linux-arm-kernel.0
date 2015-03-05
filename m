From: keescook@chromium.org (Kees Cook)
Date: Wed,  4 Mar 2015 17:27:03 -0800
Subject: [PATCH v3 3/8] microblaze: use asm-generic for seccomp.h
In-Reply-To: <1425518828-16017-1-git-send-email-keescook@chromium.org>
References: <1425518828-16017-1-git-send-email-keescook@chromium.org>
Message-ID: <1425518828-16017-4-git-send-email-keescook@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Switch to using the newly created asm-generic/seccomp.h for the seccomp
strict mode syscall definitions. Since microblaze is 32-bit, the COMPAT
seccomp defines are unused and can be dropped. The obsolete sigreturn
for seccomp strict mode is retained as an override. Remaining definitions
are identical.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/microblaze/include/asm/seccomp.h | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/microblaze/include/asm/seccomp.h b/arch/microblaze/include/asm/seccomp.h
index 0d912758a0d7..204618a2ce84 100644
--- a/arch/microblaze/include/asm/seccomp.h
+++ b/arch/microblaze/include/asm/seccomp.h
@@ -3,14 +3,8 @@
 
 #include <linux/unistd.h>
 
-#define __NR_seccomp_read		__NR_read
-#define __NR_seccomp_write		__NR_write
-#define __NR_seccomp_exit		__NR_exit
 #define __NR_seccomp_sigreturn		__NR_sigreturn
 
-#define __NR_seccomp_read_32		__NR_read
-#define __NR_seccomp_write_32		__NR_write
-#define __NR_seccomp_exit_32		__NR_exit
-#define __NR_seccomp_sigreturn_32	__NR_sigreturn
+#include <asm-generic/seccomp.h>
 
 #endif	/* _ASM_MICROBLAZE_SECCOMP_H */
-- 
1.9.1
