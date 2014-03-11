From: eparis@redhat.com (Eric Paris)
Date: Tue, 11 Mar 2014 17:32:58 -0400
Subject: [PATCH 2/2] audit: use uapi/linux/audit.h for AUDIT_ARCH declarations
In-Reply-To: <1394573578-2558-1-git-send-email-eparis@redhat.com>
References: <1394573578-2558-1-git-send-email-eparis@redhat.com>
Message-ID: <1394573578-2558-2-git-send-email-eparis@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The syscall.h headers were including linux/audit.h but really only
needed the uapi/linux/audit.h to get the requisite defines.  Switch to
the uapi headers.

Signed-off-by: Eric Paris <eparis@redhat.com>
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-mips at linux-mips.org
Cc: linux-s390 at vger.kernel.org
Cc: x86 at kernel.org
---
 arch/arm/include/asm/syscall.h  | 2 +-
 arch/mips/include/asm/syscall.h | 2 +-
 arch/s390/include/asm/syscall.h | 2 +-
 arch/x86/include/asm/syscall.h  | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/include/asm/syscall.h b/arch/arm/include/asm/syscall.h
index ed805f1..4651f69 100644
--- a/arch/arm/include/asm/syscall.h
+++ b/arch/arm/include/asm/syscall.h
@@ -7,7 +7,7 @@
 #ifndef _ASM_ARM_SYSCALL_H
 #define _ASM_ARM_SYSCALL_H
 
-#include <linux/audit.h> /* for AUDIT_ARCH_* */
+#include <uapi/linux/audit.h> /* for AUDIT_ARCH_* */
 #include <linux/elf.h> /* for ELF_EM */
 #include <linux/err.h>
 #include <linux/sched.h>
diff --git a/arch/mips/include/asm/syscall.h b/arch/mips/include/asm/syscall.h
index 625e709..fc556d8 100644
--- a/arch/mips/include/asm/syscall.h
+++ b/arch/mips/include/asm/syscall.h
@@ -13,7 +13,7 @@
 #ifndef __ASM_MIPS_SYSCALL_H
 #define __ASM_MIPS_SYSCALL_H
 
-#include <linux/audit.h>
+#include <uapi/linux/audit.h>
 #include <linux/elf-em.h>
 #include <linux/kernel.h>
 #include <linux/sched.h>
diff --git a/arch/s390/include/asm/syscall.h b/arch/s390/include/asm/syscall.h
index bebc0bd..7776870 100644
--- a/arch/s390/include/asm/syscall.h
+++ b/arch/s390/include/asm/syscall.h
@@ -12,7 +12,7 @@
 #ifndef _ASM_SYSCALL_H
 #define _ASM_SYSCALL_H	1
 
-#include <linux/audit.h>
+#include <uapi/linux/audit.h>
 #include <linux/sched.h>
 #include <linux/err.h>
 #include <asm/ptrace.h>
diff --git a/arch/x86/include/asm/syscall.h b/arch/x86/include/asm/syscall.h
index 7e6d0c4..d6a756a 100644
--- a/arch/x86/include/asm/syscall.h
+++ b/arch/x86/include/asm/syscall.h
@@ -13,7 +13,7 @@
 #ifndef _ASM_X86_SYSCALL_H
 #define _ASM_X86_SYSCALL_H
 
-#include <linux/audit.h>
+#include <uapi/linux/audit.h>
 #include <linux/sched.h>
 #include <linux/err.h>
 #include <asm/asm-offsets.h>	/* For NR_syscalls */
-- 
1.8.5.3
