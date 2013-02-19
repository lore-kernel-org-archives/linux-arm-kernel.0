From: gorcunov@openvz.org (Cyrill Gorcunov)
Date: Tue, 19 Feb 2013 11:07:03 +0400
Subject: [patch 2/2] arm: Wire up kcmp syscall
In-Reply-To: <20130219065210.148067470@openvz.org>
References: <20130219064800.719149796@openvz.org>
 <20130219065210.148067470@openvz.org>
Message-ID: <20130219070703.GC20312@moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

quilt eat original header, here is the former, sorry
for incovenience.
---
From: Alexander Kartashov <alekskartashov@parallels.com>
Subject: arm: Wire up kcmp syscall

Signed-off-by: Alexander Kartashov <alekskartashov@parallels.com>
Cc: Russell King <linux@arm.linux.org.uk>
---
 arch/arm/include/uapi/asm/unistd.h |    2 +-
 arch/arm/kernel/calls.S            |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

Index: linux-2.6.git/arch/arm/include/uapi/asm/unistd.h
===================================================================
--- linux-2.6.git.orig/arch/arm/include/uapi/asm/unistd.h
+++ linux-2.6.git/arch/arm/include/uapi/asm/unistd.h
@@ -404,7 +404,7 @@
 #define __NR_setns			(__NR_SYSCALL_BASE+375)
 #define __NR_process_vm_readv		(__NR_SYSCALL_BASE+376)
 #define __NR_process_vm_writev		(__NR_SYSCALL_BASE+377)
-					/* 378 for kcmp */
+#define __NR_kcmp			(__NR_SYSCALL_BASE+378)
 #define __NR_finit_module		(__NR_SYSCALL_BASE+379)
 
 /*
Index: linux-2.6.git/arch/arm/kernel/calls.S
===================================================================
--- linux-2.6.git.orig/arch/arm/kernel/calls.S
+++ linux-2.6.git/arch/arm/kernel/calls.S
@@ -387,7 +387,7 @@
 /* 375 */	CALL(sys_setns)
 		CALL(sys_process_vm_readv)
 		CALL(sys_process_vm_writev)
-		CALL(sys_ni_syscall)	/* reserved for sys_kcmp */
+		CALL(sys_kcmp)
 		CALL(sys_finit_module)
 #ifndef syscalls_counted
 .equ syscalls_padding, ((NR_syscalls + 3) & ~3) - NR_syscalls
