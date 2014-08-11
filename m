From: will.deacon@arm.com (Will Deacon)
Date: Mon, 11 Aug 2014 14:37:07 +0100
Subject: [PATCH 1/2] arm64: compat: wire up memfd_create and getrandom
 syscalls for aarch32
Message-ID: <1407764228-7904-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

arch/arm/ just grew support for the new memfd_create and getrandom
syscalls, so add them to our compat layer too.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/unistd.h   | 2 +-
 arch/arm64/include/asm/unistd32.h | 5 +++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/unistd.h b/arch/arm64/include/asm/unistd.h
index 4bc95d27e063..6d2bf419431d 100644
--- a/arch/arm64/include/asm/unistd.h
+++ b/arch/arm64/include/asm/unistd.h
@@ -41,7 +41,7 @@
 #define __ARM_NR_compat_cacheflush	(__ARM_NR_COMPAT_BASE+2)
 #define __ARM_NR_compat_set_tls		(__ARM_NR_COMPAT_BASE+5)
 
-#define __NR_compat_syscalls		383
+#define __NR_compat_syscalls		386
 #endif
 
 #define __ARCH_WANT_SYS_CLONE
diff --git a/arch/arm64/include/asm/unistd32.h b/arch/arm64/include/asm/unistd32.h
index e242600c4046..da1f06b535e3 100644
--- a/arch/arm64/include/asm/unistd32.h
+++ b/arch/arm64/include/asm/unistd32.h
@@ -787,3 +787,8 @@ __SYSCALL(__NR_sched_setattr, sys_sched_setattr)
 __SYSCALL(__NR_sched_getattr, sys_sched_getattr)
 #define __NR_renameat2 382
 __SYSCALL(__NR_renameat2, sys_renameat2)
+			/* 383 for seccomp */
+#define __NR_getrandom 384
+__SYSCALL(__NR_getrandom, sys_getrandom)
+#define __NR_memfd_create 385
+__SYSCALL(__NR_memfd_create, sys_memfd_create)
-- 
2.0.1
