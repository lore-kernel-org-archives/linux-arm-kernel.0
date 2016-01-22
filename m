From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 22 Jan 2016 14:47:36 +0100
Subject: [PATCH] ARM: add copy_file_range system call
Message-ID: <6994292.VtUkPlizQj@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The copy_file_range system call was added in linux-4.5 needs to
be added to the system call tables on all architectures.

This is the change for arch/arm.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/arch/arm/include/uapi/asm/unistd.h b/arch/arm/include/uapi/asm/unistd.h
index ede692ffa32e..5dd2528e9e45 100644
--- a/arch/arm/include/uapi/asm/unistd.h
+++ b/arch/arm/include/uapi/asm/unistd.h
@@ -417,6 +417,7 @@
 #define __NR_userfaultfd		(__NR_SYSCALL_BASE+388)
 #define __NR_membarrier			(__NR_SYSCALL_BASE+389)
 #define __NR_mlock2			(__NR_SYSCALL_BASE+390)
+#define __NR_copy_file_range		(__NR_SYSCALL_BASE+391)
 
 /*
  * The following SWIs are ARM private.
diff --git a/arch/arm/kernel/calls.S b/arch/arm/kernel/calls.S
index ac368bb068d1..8ff325ae6d0e 100644
--- a/arch/arm/kernel/calls.S
+++ b/arch/arm/kernel/calls.S
@@ -399,7 +399,8 @@
 		CALL(sys_execveat)
 		CALL(sys_userfaultfd)
 		CALL(sys_membarrier)
-		CALL(sys_mlock2)
+/* 390 */	CALL(sys_mlock2)
+		CALL(sys_copy_file_range)
 #ifndef syscalls_counted
 .equ syscalls_padding, ((NR_syscalls + 3) & ~3) - NR_syscalls
 #define syscalls_counted
