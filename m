From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 02 Jan 2013 14:23:51 -0800
Subject: [PATCH 14/26] ARM: S3C24XX: make osiris-cpld.h and osiris-map.h local
In-Reply-To: <1357165443-3716-1-git-send-email-kgene.kim@samsung.com>
References: <1357165443-3716-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1357165443-3716-15-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This makes the headers local in mach-s3c24xx/.

Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s3c24xx/include/mach/osiris-cpld.h   |   30 --------------------
 arch/arm/mach-s3c24xx/mach-osiris.c                |   27 ++++++++----------
 arch/arm/mach-s3c24xx/mach-rx1950.c                |    1 -
 .../{include/mach/osiris-map.h => osiris.h}        |   23 +++++++++++----
 4 files changed, 29 insertions(+), 52 deletions(-)
 delete mode 100644 arch/arm/mach-s3c24xx/include/mach/osiris-cpld.h
 rename arch/arm/mach-s3c24xx/{include/mach/osiris-map.h => osiris.h} (69%)

diff --git a/arch/arm/mach-s3c24xx/include/mach/osiris-cpld.h b/arch/arm/mach-s3c24xx/include/mach/osiris-cpld.h
deleted file mode 100644
index e9e36b0..0000000
--- a/arch/arm/mach-s3c24xx/include/mach/osiris-cpld.h
+++ /dev/null
@@ -1,30 +0,0 @@
-/* arch/arm/mach-s3c2410/include/mach/osiris-cpld.h
- *
- * Copyright 2005 Simtec Electronics
- *	http://www.simtec.co.uk/products/
- *	Ben Dooks <ben@simtec.co.uk>
- *
- * OSIRIS - CPLD control constants
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#ifndef __ASM_ARCH_OSIRISCPLD_H
-#define __ASM_ARCH_OSIRISCPLD_H
-
-/* CTRL0 - NAND WP control */
-
-#define OSIRIS_CTRL0_NANDSEL		(0x3)
-#define OSIRIS_CTRL0_BOOT_INT		(1<<3)
-#define OSIRIS_CTRL0_PCMCIA		(1<<4)
-#define OSIRIS_CTRL0_FIX8		(1<<5)
-#define OSIRIS_CTRL0_PCMCIA_nWAIT	(1<<6)
-#define OSIRIS_CTRL0_PCMCIA_nIOIS16	(1<<7)
-
-#define OSIRIS_CTRL1_FIX8		(1<<0)
-
-#define OSIRIS_ID_REVMASK		(0x7)
-
-#endif /* __ASM_ARCH_OSIRISCPLD_H */
diff --git a/arch/arm/mach-s3c24xx/mach-osiris.c b/arch/arm/mach-s3c24xx/mach-osiris.c
index bb36d83..1eeeee4 100644
--- a/arch/arm/mach-s3c24xx/mach-osiris.c
+++ b/arch/arm/mach-s3c24xx/mach-osiris.c
@@ -1,5 +1,4 @@
-/* linux/arch/arm/mach-s3c2440/mach-osiris.c
- *
+/*
  * Copyright (c) 2005-2008 Simtec Electronics
  *	http://armlinux.simtec.co.uk/
  *	Ben Dooks <ben@simtec.co.uk>
@@ -25,22 +24,12 @@
 
 #include <linux/i2c/tps65010.h>
 
+#include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 #include <asm/mach/irq.h>
-
-#include <mach/osiris-map.h>
-#include <mach/osiris-cpld.h>
-
-#include <mach/hardware.h>
 #include <asm/irq.h>
-#include <asm/mach-types.h>
 
-#include <plat/cpu-freq.h>
-#include <plat/regs-serial.h>
-#include <mach/regs-gpio.h>
-#include <mach/regs-mem.h>
-#include <mach/regs-lcd.h>
 #include <linux/platform_data/mtd-nand-s3c2410.h>
 #include <linux/platform_data/i2c-s3c2410.h>
 
@@ -49,12 +38,20 @@
 #include <linux/mtd/nand_ecc.h>
 #include <linux/mtd/partitions.h>
 
-#include <plat/gpio-cfg.h>
 #include <plat/clock.h>
-#include <plat/devs.h>
 #include <plat/cpu.h>
+#include <plat/cpu-freq.h>
+#include <plat/devs.h>
+#include <plat/gpio-cfg.h>
+#include <plat/regs-serial.h>
+
+#include <mach/hardware.h>
+#include <mach/regs-gpio.h>
+#include <mach/regs-mem.h>
+#include <mach/regs-lcd.h>
 
 #include "common.h"
+#include "osiris.h"
 
 /* onboard perihperal map */
 
diff --git a/arch/arm/mach-s3c24xx/mach-rx1950.c b/arch/arm/mach-s3c24xx/mach-rx1950.c
index bdcfb8b..c7db767 100644
--- a/arch/arm/mach-s3c24xx/mach-rx1950.c
+++ b/arch/arm/mach-s3c24xx/mach-rx1950.c
@@ -55,7 +55,6 @@
 #include <plat/clock.h>
 #include <plat/cpu.h>
 #include <plat/devs.h>
-#include <plat/irq.h>
 #include <plat/pm.h>
 #include <plat/regs-iic.h>
 #include <plat/regs-serial.h>
diff --git a/arch/arm/mach-s3c24xx/include/mach/osiris-map.h b/arch/arm/mach-s3c24xx/osiris.h
similarity index 69%
rename from arch/arm/mach-s3c24xx/include/mach/osiris-map.h
rename to arch/arm/mach-s3c24xx/osiris.h
index 17380f8..b8d5607 100644
--- a/arch/arm/mach-s3c24xx/include/mach/osiris-map.h
+++ b/arch/arm/mach-s3c24xx/osiris.h
@@ -1,9 +1,9 @@
-/* arch/arm/mach-s3c2410/include/mach/osiris-map.h
- *
+/*
  * Copyright 2005 Simtec Electronics
  *	http://www.simtec.co.uk/products/
  *	Ben Dooks <ben@simtec.co.uk>
  *
+ * OSIRIS - CPLD control constants
  * OSIRIS - Memory map definitions
  *
  * This program is free software; you can redistribute it and/or modify
@@ -11,10 +11,21 @@
  * published by the Free Software Foundation.
 */
 
-/* needs arch/map.h including with this */
+#ifndef __MACH_S3C24XX_OSIRIS_H
+#define __MACH_S3C24XX_OSIRIS_H __FILE__
+
+/* CTRL0 - NAND WP control */
+
+#define OSIRIS_CTRL0_NANDSEL		(0x3)
+#define OSIRIS_CTRL0_BOOT_INT		(1<<3)
+#define OSIRIS_CTRL0_PCMCIA		(1<<4)
+#define OSIRIS_CTRL0_FIX8		(1<<5)
+#define OSIRIS_CTRL0_PCMCIA_nWAIT	(1<<6)
+#define OSIRIS_CTRL0_PCMCIA_nIOIS16	(1<<7)
+
+#define OSIRIS_CTRL1_FIX8		(1<<0)
 
-#ifndef __ASM_ARCH_OSIRISMAP_H
-#define __ASM_ARCH_OSIRISMAP_H
+#define OSIRIS_ID_REVMASK		(0x7)
 
 /* start peripherals off after the S3C2410 */
 
@@ -39,4 +50,4 @@
 #define OSIRIS_VA_IDREG		OSIRIS_IOADDR(0x00700000)
 #define OSIRIS_PA_IDREG		(OSIRIS_PA_CPLD + (7<<23))
 
-#endif /* __ASM_ARCH_OSIRISMAP_H */
+#endif /* __MACH_S3C24XX_OSIRIS_H */
-- 
1.7.10.4
