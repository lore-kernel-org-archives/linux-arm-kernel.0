From: will.deacon@arm.com (Will Deacon)
Date: Thu,  2 Jun 2016 16:27:24 +0100
Subject: [PATCH] arm64: unistd32.h: wire up missing syscalls for compat tasks
Message-ID: <1464881244-24513-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We're missing entries for mlock2, copy_file_range, preadv2 and pwritev2
in our compat syscall table, so hook them up. Only the last two need
compat wrappers.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/unistd.h   | 2 +-
 arch/arm64/include/asm/unistd32.h | 8 ++++++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/unistd.h b/arch/arm64/include/asm/unistd.h
index 41e58fe3c041..e78ac26324bd 100644
--- a/arch/arm64/include/asm/unistd.h
+++ b/arch/arm64/include/asm/unistd.h
@@ -44,7 +44,7 @@
 #define __ARM_NR_compat_cacheflush	(__ARM_NR_COMPAT_BASE+2)
 #define __ARM_NR_compat_set_tls		(__ARM_NR_COMPAT_BASE+5)
 
-#define __NR_compat_syscalls		390
+#define __NR_compat_syscalls		394
 #endif
 
 #define __ARCH_WANT_SYS_CLONE
diff --git a/arch/arm64/include/asm/unistd32.h b/arch/arm64/include/asm/unistd32.h
index 5b925b761a2a..b7e8ef16ff0d 100644
--- a/arch/arm64/include/asm/unistd32.h
+++ b/arch/arm64/include/asm/unistd32.h
@@ -801,6 +801,14 @@ __SYSCALL(__NR_execveat, compat_sys_execveat)
 __SYSCALL(__NR_userfaultfd, sys_userfaultfd)
 #define __NR_membarrier 389
 __SYSCALL(__NR_membarrier, sys_membarrier)
+#define __NR_mlock2 390
+__SYSCALL(__NR_mlock2, sys_mlock2)
+#define __NR_copy_file_range 391
+__SYSCALL(__NR_copy_file_range, sys_copy_file_range)
+#define __NR_preadv2 392
+__SYSCALL(__NR_preadv2, compat_sys_preadv2)
+#define __NR_pwritev2 393
+__SYSCALL(__NR_pwritev2, compat_sys_pwritev2)
 
 /*
  * Please add new compat syscalls above this comment and update
-- 
2.1.4
