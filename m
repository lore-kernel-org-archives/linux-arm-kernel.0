From: ben-linux@fluff.org (Ben Dooks)
Date: Tue, 26 Jan 2010 07:58:06 +0000
Subject: [PATCH] ARM: S3C244X: Merge <plat/s3c2440.h> and <plat/s3c2442.h>
	into <plat/s3c244x.h>
In-Reply-To: <1264492686-16901-1-git-send-email-ben-linux@fluff.org>
References: <1264492686-16901-1-git-send-email-ben-linux@fluff.org>
Message-ID: <1264492686-16901-8-git-send-email-ben-linux@fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Merge these two headers into one.

Note, correct fault in mach-smdk2443.h including the wrong header.

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
---
 arch/arm/mach-s3c2440/dsc.c                  |    2 +-
 arch/arm/mach-s3c2440/mach-nexcoder.c        |    2 +-
 arch/arm/mach-s3c2440/mach-smdk2440.c        |    2 +-
 arch/arm/mach-s3c2440/s3c2440.c              |    2 +-
 arch/arm/mach-s3c2440/s3c244x.c              |    1 -
 arch/arm/mach-s3c2443/mach-smdk2443.c        |    2 +-
 arch/arm/plat-s3c24xx/cpu.c                  |    2 --
 arch/arm/plat-s3c24xx/include/plat/s3c2440.h |   17 -----------------
 arch/arm/plat-s3c24xx/include/plat/s3c2442.h |   17 -----------------
 arch/arm/plat-s3c24xx/include/plat/s3c244x.h |   12 ++++++++++++
 10 files changed, 17 insertions(+), 42 deletions(-)
 delete mode 100644 arch/arm/plat-s3c24xx/include/plat/s3c2440.h
 delete mode 100644 arch/arm/plat-s3c24xx/include/plat/s3c2442.h

diff --git a/arch/arm/mach-s3c2440/dsc.c b/arch/arm/mach-s3c2440/dsc.c
index 5540442..9ea66e3 100644
--- a/arch/arm/mach-s3c2440/dsc.c
+++ b/arch/arm/mach-s3c2440/dsc.c
@@ -28,7 +28,7 @@
 #include <mach/regs-dsc.h>
 
 #include <plat/cpu.h>
-#include <plat/s3c2440.h>
+#include <plat/s3c244x.h>
 
 int s3c2440_set_dsc(unsigned int pin, unsigned int value)
 {
diff --git a/arch/arm/mach-s3c2440/mach-nexcoder.c b/arch/arm/mach-s3c2440/mach-nexcoder.c
index 86a243b..3420415 100644
--- a/arch/arm/mach-s3c2440/mach-nexcoder.c
+++ b/arch/arm/mach-s3c2440/mach-nexcoder.c
@@ -41,7 +41,7 @@
 #include <plat/iic.h>
 
 #include <plat/s3c2410.h>
-#include <plat/s3c2440.h>
+#include <plat/s3c244x.h>
 #include <plat/clock.h>
 #include <plat/devs.h>
 #include <plat/cpu.h>
diff --git a/arch/arm/mach-s3c2440/mach-smdk2440.c b/arch/arm/mach-s3c2440/mach-smdk2440.c
index df3e9a3..3ac3d63 100644
--- a/arch/arm/mach-s3c2440/mach-smdk2440.c
+++ b/arch/arm/mach-s3c2440/mach-smdk2440.c
@@ -40,7 +40,7 @@
 #include <plat/iic.h>
 
 #include <plat/s3c2410.h>
-#include <plat/s3c2440.h>
+#include <plat/s3c244x.h>
 #include <plat/clock.h>
 #include <plat/devs.h>
 #include <plat/cpu.h>
diff --git a/arch/arm/mach-s3c2440/s3c2440.c b/arch/arm/mach-s3c2440/s3c2440.c
index ac1f7ea..2b68f7e 100644
--- a/arch/arm/mach-s3c2440/s3c2440.c
+++ b/arch/arm/mach-s3c2440/s3c2440.c
@@ -29,9 +29,9 @@
 #include <mach/hardware.h>
 #include <asm/irq.h>
 
-#include <plat/s3c2440.h>
 #include <plat/devs.h>
 #include <plat/cpu.h>
+#include <plat/s3c244x.h>
 
 static struct sys_device s3c2440_sysdev = {
 	.cls		= &s3c2440_sysclass,
diff --git a/arch/arm/mach-s3c2440/s3c244x.c b/arch/arm/mach-s3c2440/s3c244x.c
index 46e13db..5e4a97e 100644
--- a/arch/arm/mach-s3c2440/s3c244x.c
+++ b/arch/arm/mach-s3c2440/s3c244x.c
@@ -38,7 +38,6 @@
 #include <mach/regs-dsc.h>
 
 #include <plat/s3c2410.h>
-#include <plat/s3c2440.h>
 #include <plat/s3c244x.h>
 #include <plat/clock.h>
 #include <plat/devs.h>
diff --git a/arch/arm/mach-s3c2443/mach-smdk2443.c b/arch/arm/mach-s3c2443/mach-smdk2443.c
index 039a462..d65afde 100644
--- a/arch/arm/mach-s3c2443/mach-smdk2443.c
+++ b/arch/arm/mach-s3c2443/mach-smdk2443.c
@@ -40,7 +40,7 @@
 #include <plat/iic.h>
 
 #include <plat/s3c2410.h>
-#include <plat/s3c2440.h>
+#include <plat/s3c2443.h>
 #include <plat/clock.h>
 #include <plat/devs.h>
 #include <plat/cpu.h>
diff --git a/arch/arm/plat-s3c24xx/cpu.c b/arch/arm/plat-s3c24xx/cpu.c
index 6ecf87a..9ca64df 100644
--- a/arch/arm/plat-s3c24xx/cpu.c
+++ b/arch/arm/plat-s3c24xx/cpu.c
@@ -50,8 +50,6 @@
 #include <plat/s3c2410.h>
 #include <plat/s3c2412.h>
 #include <plat/s3c244x.h>
-#include <plat/s3c2440.h>
-#include <plat/s3c2442.h>
 #include <plat/s3c2443.h>
 
 /* table of supported CPUs */
diff --git a/arch/arm/plat-s3c24xx/include/plat/s3c2440.h b/arch/arm/plat-s3c24xx/include/plat/s3c2440.h
deleted file mode 100644
index 107853b..0000000
--- a/arch/arm/plat-s3c24xx/include/plat/s3c2440.h
+++ /dev/null
@@ -1,17 +0,0 @@
-/* linux/include/asm-arm/plat-s3c24xx/s3c2440.h
- *
- * Copyright (c) 2004-2005 Simtec Electronics
- *	Ben Dooks <ben@simtec.co.uk>
- *
- * Header file for s3c2440 cpu support
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#ifdef CONFIG_CPU_S3C2440
-extern  int s3c2440_init(void);
-#else
-#define s3c2440_init NULL
-#endif
diff --git a/arch/arm/plat-s3c24xx/include/plat/s3c2442.h b/arch/arm/plat-s3c24xx/include/plat/s3c2442.h
deleted file mode 100644
index 451a23a..0000000
--- a/arch/arm/plat-s3c24xx/include/plat/s3c2442.h
+++ /dev/null
@@ -1,17 +0,0 @@
-/* linux/include/asm-arm/plat-s3c24xx/s3c2442.h
- *
- * Copyright (c) 2006 Simtec Electronics
- *	Ben Dooks <ben@simtec.co.uk>
- *
- * Header file for s3c2442 cpu support
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#ifdef CONFIG_CPU_S3C2442
-extern  int s3c2442_init(void);
-#else
-#define s3c2442_init NULL
-#endif
diff --git a/arch/arm/plat-s3c24xx/include/plat/s3c244x.h b/arch/arm/plat-s3c24xx/include/plat/s3c244x.h
index 8da0904..307248d 100644
--- a/arch/arm/plat-s3c24xx/include/plat/s3c244x.h
+++ b/arch/arm/plat-s3c24xx/include/plat/s3c244x.h
@@ -23,3 +23,15 @@ extern void s3c244x_init_clocks(int xtal);
 #define s3c244x_init_uarts NULL
 #define s3c244x_map_io NULL
 #endif
+
+#ifdef CONFIG_CPU_S3C2440
+extern  int s3c2440_init(void);
+#else
+#define s3c2440_init NULL
+#endif
+
+#ifdef CONFIG_CPU_S3C2442
+extern  int s3c2442_init(void);
+#else
+#define s3c2442_init NULL
+#endif
-- 
1.6.0.4
