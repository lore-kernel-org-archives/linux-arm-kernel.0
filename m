From: broonie@kernel.org (Mark Brown)
Date: Thu, 16 Jul 2015 15:00:26 +0100
Subject: [PATCH] mm: Fix up new locking syscalls
Message-ID: <1437055226-18351-1-git-send-email-broonie@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Extend the arm64 compat syscall table for the new syscalls to fix build
errors introduced by "mm: mlock: add new mlock, munlock, and munlockall
system calls":

 ../arch/arm64/include/asm/unistd32.h:801:1: error: array index in initializer exceeds array bounds
 ../arch/arm64/include/asm/unistd32.h:801:1: error: (near initialization for 'compat_sys_call_table')
 ../arch/arm64/include/asm/unistd32.h:803:1: error: array index in initializer exceeds array bounds
 ../arch/arm64/include/asm/unistd32.h:803:1: error: (near initialization for 'compat_sys_call_table')
 ../arch/arm64/include/asm/unistd32.h:805:1: error: array index in initializer exceeds array bounds
 ../arch/arm64/include/asm/unistd32.h:805:1: error: (near initialization for 'compat_sys_call_table')

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/unistd.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/unistd.h b/arch/arm64/include/asm/unistd.h
index 3bc498c..aa537a4 100644
--- a/arch/arm64/include/asm/unistd.h
+++ b/arch/arm64/include/asm/unistd.h
@@ -44,7 +44,7 @@
 #define __ARM_NR_compat_cacheflush	(__ARM_NR_COMPAT_BASE+2)
 #define __ARM_NR_compat_set_tls		(__ARM_NR_COMPAT_BASE+5)
 
-#define __NR_compat_syscalls		388
+#define __NR_compat_syscalls		391
 #endif
 
 #define __ARCH_WANT_SYS_CLONE
-- 
2.1.4
