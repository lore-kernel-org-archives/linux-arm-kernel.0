From: alekskartashov@parallels.com (Alexander Kartashov)
Date: Wed, 19 Dec 2012 20:44:30 +0400
Subject: [PATCH 3/3] kcmp: enable the kcmp syscall when C/R is enabled
In-Reply-To: <1355935470-21001-1-git-send-email-alekskartashov@parallels.com>
References: <20689.54803.684081.31731@pilspetsen.it.uu.se>
 <1355935470-21001-1-git-send-email-alekskartashov@parallels.com>
Message-ID: <1355935470-21001-4-git-send-email-alekskartashov@parallels.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Alexander Kartashov <alekskartashov@parallels.com>
---
 arch/arm/include/uapi/asm/unistd.h |    2 +-
 arch/arm/kernel/calls.S            |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/uapi/asm/unistd.h b/arch/arm/include/uapi/asm/unistd.h
index ac03bdb..afe27b5 100644
--- a/arch/arm/include/uapi/asm/unistd.h
+++ b/arch/arm/include/uapi/asm/unistd.h
@@ -404,7 +404,7 @@
 #define __NR_setns			(__NR_SYSCALL_BASE+375)
 #define __NR_process_vm_readv		(__NR_SYSCALL_BASE+376)
 #define __NR_process_vm_writev		(__NR_SYSCALL_BASE+377)
-					/* 378 for kcmp */
+#define __NR_kcmp					(__NR_SYSCALL_BASE+378)
 
 /*
  * This may need to be greater than __NR_last_syscall+1 in order to
diff --git a/arch/arm/kernel/calls.S b/arch/arm/kernel/calls.S
index 831cd38..862ebd4 100644
--- a/arch/arm/kernel/calls.S
+++ b/arch/arm/kernel/calls.S
@@ -387,7 +387,7 @@
 /* 375 */	CALL(sys_setns)
 		CALL(sys_process_vm_readv)
 		CALL(sys_process_vm_writev)
-		CALL(sys_ni_syscall)	/* reserved for sys_kcmp */
+		CALL(sys_kcmp)
 #ifndef syscalls_counted
 .equ syscalls_padding, ((NR_syscalls + 3) & ~3) - NR_syscalls
 #define syscalls_counted
-- 
1.7.9.5
