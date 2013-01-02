From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 02 Jan 2013 14:23:52 -0800
Subject: [PATCH 15/26] ARM: S3C24XX: make otom-map.h local
In-Reply-To: <1357165443-3716-1-git-send-email-kgene.kim@samsung.com>
References: <1357165443-3716-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1357165443-3716-16-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The header can be local in mach-s3c24xx/.

Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s3c24xx/mach-otom.c                  |   20 +++++++++-----------
 .../{include/mach/otom-map.h => otom.h}            |   20 +++++++++-----------
 2 files changed, 18 insertions(+), 22 deletions(-)
 rename arch/arm/mach-s3c24xx/{include/mach/otom-map.h => otom.h} (50%)

diff --git a/arch/arm/mach-s3c24xx/mach-otom.c b/arch/arm/mach-s3c24xx/mach-otom.c
index bca39f0..91d8493 100644
--- a/arch/arm/mach-s3c24xx/mach-otom.c
+++ b/arch/arm/mach-s3c24xx/mach-otom.c
@@ -1,4 +1,4 @@
-/* linux/arch/arm/mach-s3c2410/mach-otom.c
+/*
  *
  * Copyright (c) 2004 Nex Vision
  *   Guillaume GOURAT <guillaume.gourat@nexvision.fr>
@@ -6,7 +6,6 @@
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
- *
  */
 
 #include <linux/kernel.h>
@@ -19,26 +18,25 @@
 #include <linux/platform_device.h>
 #include <linux/io.h>
 
+#include <linux/platform_data/i2c-s3c2410.h>
+
+#include <asm/irq.h>
+#include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 #include <asm/mach/irq.h>
 
-#include <mach/otom-map.h>
-
 #include <mach/hardware.h>
-#include <asm/irq.h>
-#include <asm/mach-types.h>
-
-#include <plat/regs-serial.h>
 #include <mach/regs-gpio.h>
 
-#include <plat/s3c2410.h>
 #include <plat/clock.h>
-#include <plat/devs.h>
-#include <linux/platform_data/i2c-s3c2410.h>
 #include <plat/cpu.h>
+#include <plat/devs.h>
+#include <plat/regs-serial.h>
+#include <plat/s3c2410.h>
 
 #include "common.h"
+#include "otom.h"
 
 static struct map_desc otom11_iodesc[] __initdata = {
   /* Device area */
diff --git a/arch/arm/mach-s3c24xx/include/mach/otom-map.h b/arch/arm/mach-s3c24xx/otom.h
similarity index 50%
rename from arch/arm/mach-s3c24xx/include/mach/otom-map.h
rename to arch/arm/mach-s3c24xx/otom.h
index f9277a5..321b7be 100644
--- a/arch/arm/mach-s3c24xx/include/mach/otom-map.h
+++ b/arch/arm/mach-s3c24xx/otom.h
@@ -1,5 +1,4 @@
-/* arch/arm/mach-s3c2410/include/mach/otom-map.h
- *
+/*
  * (c) 2005 Guillaume GOURAT / NexVision
  *          guillaume.gourat at nexvision.fr
  *
@@ -10,21 +9,20 @@
  * published by the Free Software Foundation.
 */
 
-/* needs arch/map.h including with this */
-
-/* ok, we've used up to 0x01300000, now we need to find space for the
+/*
+ * ok, we've used up to 0x01300000, now we need to find space for the
  * peripherals that live in the nGCS[x] areas, which are quite numerous
  * in their space.
  */
 
-#ifndef __ASM_ARCH_OTOMMAP_H
-#define __ASM_ARCH_OTOMMAP_H
+#ifndef __MACH_S3C24XX_OTOM_H
+#define __MACH_S3C24XX_OTOM_H __FILE__
 
-#define OTOM_PA_CS8900A_BASE       (S3C2410_CS3 + 0x01000000)	/* nGCS3 +0x01000000 */
-#define OTOM_VA_CS8900A_BASE       S3C2410_ADDR(0x04000000)		/* 0xF4000000 */
+#define OTOM_PA_CS8900A_BASE	(S3C2410_CS3 + 0x01000000)	/* nGCS3 +0x01000000 */
+#define OTOM_VA_CS8900A_BASE	S3C2410_ADDR(0x04000000)	/* 0xF4000000 */
 
 /* physical offset addresses for the peripherals */
 
-#define OTOM_PA_FLASH0_BASE        (S3C2410_CS0)				/* Bank 0 */
+#define OTOM_PA_FLASH0_BASE	(S3C2410_CS0)
 
-#endif /* __ASM_ARCH_OTOMMAP_H */
+#endif /* __MACH_S3C24XX_OTOM_H */
-- 
1.7.10.4
