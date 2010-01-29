From: ben-linux@fluff.org (Ben Dooks)
Date: Fri, 29 Jan 2010 09:02:20 +0000
Subject: [PATCH] ARM: SAMSUNG: Move include/mach files out of plat-s3c
In-Reply-To: <1264755741-16184-1-git-send-email-ben-linux@fluff.org>
References: <1264755741-16184-1-git-send-email-ben-linux@fluff.org>
Message-ID: <1264755741-16184-10-git-send-email-ben-linux@fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move the include/mach files out of plat-s3c and into the relevant
machine files. This does mean copying the files, but there is nowhere
else to put them.

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
---
 arch/arm/mach-s3c2410/include/mach/timex.h   |   24 ++++++++++++++++++++++++
 arch/arm/mach-s3c2410/include/mach/vmalloc.h |   20 ++++++++++++++++++++
 arch/arm/mach-s3c24a0/include/mach/io.h      |   18 ++++++++++++++++++
 arch/arm/mach-s3c6400/include/mach/io.h      |   18 ++++++++++++++++++
 arch/arm/mach-s3c6400/include/mach/timex.h   |   24 ++++++++++++++++++++++++
 arch/arm/mach-s3c6400/include/mach/vmalloc.h |   20 ++++++++++++++++++++
 6 files changed, 124 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-s3c2410/include/mach/timex.h
 create mode 100644 arch/arm/mach-s3c2410/include/mach/vmalloc.h
 create mode 100644 arch/arm/mach-s3c24a0/include/mach/io.h
 create mode 100644 arch/arm/mach-s3c6400/include/mach/io.h
 create mode 100644 arch/arm/mach-s3c6400/include/mach/timex.h
 create mode 100644 arch/arm/mach-s3c6400/include/mach/vmalloc.h

diff --git a/arch/arm/mach-s3c2410/include/mach/timex.h b/arch/arm/mach-s3c2410/include/mach/timex.h
new file mode 100644
index 0000000..fe9ca1f
--- /dev/null
+++ b/arch/arm/mach-s3c2410/include/mach/timex.h
@@ -0,0 +1,24 @@
+/* arch/arm/mach-s3c2410/include/mach/timex.h
+ *
+ * Copyright (c) 2003-2005 Simtec Electronics
+ *	Ben Dooks <ben@simtec.co.uk>
+ *
+ * S3C2410 - time parameters
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#ifndef __ASM_ARCH_TIMEX_H
+#define __ASM_ARCH_TIMEX_H
+
+/* CLOCK_TICK_RATE needs to be evaluatable by the cpp, so making it
+ * a variable is useless. It seems as long as we make our timers an
+ * exact multiple of HZ, any value that makes a 1->1 correspondence
+ * for the time conversion functions to/from jiffies is acceptable.
+*/
+
+#define CLOCK_TICK_RATE 12000000
+
+#endif /* __ASM_ARCH_TIMEX_H */
diff --git a/arch/arm/mach-s3c2410/include/mach/vmalloc.h b/arch/arm/mach-s3c2410/include/mach/vmalloc.h
new file mode 100644
index 0000000..315b007
--- /dev/null
+++ b/arch/arm/mach-s3c2410/include/mach/vmalloc.h
@@ -0,0 +1,20 @@
+/* arch/arm/mach-s3c2410/include/mach/vmalloc.h
+ *
+ * from arch/arm/mach-iop3xx/include/mach/vmalloc.h
+ *
+ * Copyright (c) 2003 Simtec Electronics <linux@simtec.co.uk>
+ *		      http://www.simtec.co.uk/products/SWLINUX/
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * S3C2410 vmalloc definition
+*/
+
+#ifndef __ASM_ARCH_VMALLOC_H
+#define __ASM_ARCH_VMALLOC_H
+
+#define VMALLOC_END	  (0xE0000000)
+
+#endif /* __ASM_ARCH_VMALLOC_H */
diff --git a/arch/arm/mach-s3c24a0/include/mach/io.h b/arch/arm/mach-s3c24a0/include/mach/io.h
new file mode 100644
index 0000000..4326c30
--- /dev/null
+++ b/arch/arm/mach-s3c24a0/include/mach/io.h
@@ -0,0 +1,18 @@
+/* arch/arm/mach-s3c24a0/include/mach/io.h
+ *
+ * Copyright 2008 Simtec Electronics
+ *	Ben Dooks <ben-linux@fluff.org>
+ *
+ * Default IO routines for S3C24A0
+ */
+
+#ifndef __ASM_ARM_ARCH_IO_H
+#define __ASM_ARM_ARCH_IO_H
+
+/* No current ISA/PCI bus support. */
+#define __io(a)		__typesafe_io(a)
+#define __mem_pci(a)	(a)
+
+#define IO_SPACE_LIMIT (0xFFFFFFFF)
+
+#endif
diff --git a/arch/arm/mach-s3c6400/include/mach/io.h b/arch/arm/mach-s3c6400/include/mach/io.h
new file mode 100644
index 0000000..c02cc0a
--- /dev/null
+++ b/arch/arm/mach-s3c6400/include/mach/io.h
@@ -0,0 +1,18 @@
+/* arch/arm/mach-s3c6400/include/mach/io.h
+ *
+ * Copyright 2008 Simtec Electronics
+ *	Ben Dooks <ben-linux@fluff.org>
+ *
+ * Default IO routines for S3C64XX based
+ */
+
+#ifndef __ASM_ARM_ARCH_IO_H
+#define __ASM_ARM_ARCH_IO_H
+
+/* No current ISA/PCI bus support. */
+#define __io(a)		__typesafe_io(a)
+#define __mem_pci(a)	(a)
+
+#define IO_SPACE_LIMIT (0xFFFFFFFF)
+
+#endif
diff --git a/arch/arm/mach-s3c6400/include/mach/timex.h b/arch/arm/mach-s3c6400/include/mach/timex.h
new file mode 100644
index 0000000..cf34deb
--- /dev/null
+++ b/arch/arm/mach-s3c6400/include/mach/timex.h
@@ -0,0 +1,24 @@
+/* arch/arm/mach-s3c6400/include/mach/timex.h
+ *
+ * Copyright (c) 2003-2005 Simtec Electronics
+ *	Ben Dooks <ben@simtec.co.uk>
+ *
+ * S3C6400 - time parameters
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#ifndef __ASM_ARCH_TIMEX_H
+#define __ASM_ARCH_TIMEX_H
+
+/* CLOCK_TICK_RATE needs to be evaluatable by the cpp, so making it
+ * a variable is useless. It seems as long as we make our timers an
+ * exact multiple of HZ, any value that makes a 1->1 correspondence
+ * for the time conversion functions to/from jiffies is acceptable.
+*/
+
+#define CLOCK_TICK_RATE 12000000
+
+#endif /* __ASM_ARCH_TIMEX_H */
diff --git a/arch/arm/mach-s3c6400/include/mach/vmalloc.h b/arch/arm/mach-s3c6400/include/mach/vmalloc.h
new file mode 100644
index 0000000..fe54c7e
--- /dev/null
+++ b/arch/arm/mach-s3c6400/include/mach/vmalloc.h
@@ -0,0 +1,20 @@
+/* arch/arm/mach-s3c6400/include/mach/vmalloc.h
+ *
+ * from arch/arm/mach-iop3xx/include/mach/vmalloc.h
+ *
+ * Copyright (c) 2003 Simtec Electronics <linux@simtec.co.uk>
+ *		      http://www.simtec.co.uk/products/SWLINUX/
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * S3C6400 vmalloc definition
+*/
+
+#ifndef __ASM_ARCH_VMALLOC_H
+#define __ASM_ARCH_VMALLOC_H
+
+#define VMALLOC_END	  (0xE0000000)
+
+#endif /* __ASM_ARCH_VMALLOC_H */
-- 
1.6.0.4
