From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 02 Jan 2013 14:23:59 -0800
Subject: [PATCH 22/26] ARM: S3C64XX: make regs-gpio-memport.h local
In-Reply-To: <1357165443-3716-1-git-send-email-kgene.kim@samsung.com>
References: <1357165443-3716-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1357165443-3716-23-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The header can be local in mach-s3c64xx/.

Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s3c64xx/mach-crag6410.c                        |    3 +--
 arch/arm/mach-s3c64xx/pm.c                                   |    3 ++-
 arch/arm/mach-s3c64xx/{include/mach => }/regs-gpio-memport.h |    9 ++++-----
 3 files changed, 7 insertions(+), 8 deletions(-)
 rename arch/arm/mach-s3c64xx/{include/mach => }/regs-gpio-memport.h (71%)

diff --git a/arch/arm/mach-s3c64xx/mach-crag6410.c b/arch/arm/mach-s3c64xx/mach-crag6410.c
index d559969..e1a0742 100644
--- a/arch/arm/mach-s3c64xx/mach-crag6410.c
+++ b/arch/arm/mach-s3c64xx/mach-crag6410.c
@@ -54,8 +54,6 @@
 #include <mach/regs-gpio.h>
 #include <mach/regs-modem.h>
 
-#include <mach/regs-gpio-memport.h>
-
 #include <plat/regs-serial.h>
 #include <plat/fb.h>
 #include <plat/sdhci.h>
@@ -72,6 +70,7 @@
 
 #include "common.h"
 #include "crag6410.h"
+#include "regs-gpio-memport.h"
 
 /* serial port setup */
 
diff --git a/arch/arm/mach-s3c64xx/pm.c b/arch/arm/mach-s3c64xx/pm.c
index 7feb426..f431987 100644
--- a/arch/arm/mach-s3c64xx/pm.c
+++ b/arch/arm/mach-s3c64xx/pm.c
@@ -30,9 +30,10 @@
 #include <mach/regs-gpio.h>
 #include <mach/regs-clock.h>
 #include <mach/regs-syscon-power.h>
-#include <mach/regs-gpio-memport.h>
 #include <mach/regs-modem.h>
 
+#include "regs-gpio-memport.h"
+
 struct s3c64xx_pm_domain {
 	char *const name;
 	u32 ena;
diff --git a/arch/arm/mach-s3c64xx/include/mach/regs-gpio-memport.h b/arch/arm/mach-s3c64xx/regs-gpio-memport.h
similarity index 71%
rename from arch/arm/mach-s3c64xx/include/mach/regs-gpio-memport.h
rename to arch/arm/mach-s3c64xx/regs-gpio-memport.h
index 82342f6..b927593 100644
--- a/arch/arm/mach-s3c64xx/include/mach/regs-gpio-memport.h
+++ b/arch/arm/mach-s3c64xx/regs-gpio-memport.h
@@ -1,5 +1,4 @@
-/* linux/arch/arm/plat-s3c64xx/include/mach/regs-gpio-memport.h
- *
+/*
  * Copyright 2008 Openmoko, Inc.
  * Copyright 2008 Simtec Electronics
  *      Ben Dooks <ben@simtec.co.uk>
@@ -8,8 +7,8 @@
  * S3C64XX - GPIO memory port register definitions
  */
 
-#ifndef __ASM_PLAT_S3C64XX_REGS_GPIO_MEMPORT_H
-#define __ASM_PLAT_S3C64XX_REGS_GPIO_MEMPORT_H __FILE__
+#ifndef __MACH_S3C64XX_REGS_GPIO_MEMPORT_H
+#define __MACH_S3C64XX_REGS_GPIO_MEMPORT_H __FILE__
 
 #define S3C64XX_MEM0CONSTOP	S3C64XX_GPIOREG(0x1B0)
 #define S3C64XX_MEM1CONSTOP	S3C64XX_GPIOREG(0x1B4)
@@ -21,5 +20,5 @@
 #define S3C64XX_MEM0DRVCON	S3C64XX_GPIOREG(0x1D0)
 #define S3C64XX_MEM1DRVCON	S3C64XX_GPIOREG(0x1D4)
 
-#endif /* __ASM_PLAT_S3C64XX_REGS_GPIO_MEMPORT_H */
+#endif /* __MACH_S3C64XX_REGS_GPIO_MEMPORT_H */
 
-- 
1.7.10.4
