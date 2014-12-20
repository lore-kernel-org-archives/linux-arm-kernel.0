From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Sat, 20 Dec 2014 13:37:04 +0000
Subject: [PATCH] ARM: wire up execveat syscall
Message-ID: <E1Y2KDQ-0006WZ-8p@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/include/uapi/asm/unistd.h | 1 +
 arch/arm/kernel/calls.S            | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm/include/uapi/asm/unistd.h b/arch/arm/include/uapi/asm/unistd.h
index 705bb7620673..0c3f5a0dafd3 100644
--- a/arch/arm/include/uapi/asm/unistd.h
+++ b/arch/arm/include/uapi/asm/unistd.h
@@ -413,6 +413,7 @@
 #define __NR_getrandom			(__NR_SYSCALL_BASE+384)
 #define __NR_memfd_create		(__NR_SYSCALL_BASE+385)
 #define __NR_bpf			(__NR_SYSCALL_BASE+386)
+#define __NR_execveat			(__NR_SYSCALL_BASE+387)
 
 /*
  * The following SWIs are ARM private.
diff --git a/arch/arm/kernel/calls.S b/arch/arm/kernel/calls.S
index e51833f8cc38..05745eb838c5 100644
--- a/arch/arm/kernel/calls.S
+++ b/arch/arm/kernel/calls.S
@@ -396,6 +396,7 @@
 		CALL(sys_getrandom)
 /* 385 */	CALL(sys_memfd_create)
 		CALL(sys_bpf)
+		CALL(sys_execveat)
 #ifndef syscalls_counted
 .equ syscalls_padding, ((NR_syscalls + 3) & ~3) - NR_syscalls
 #define syscalls_counted
-- 
1.8.3.1
