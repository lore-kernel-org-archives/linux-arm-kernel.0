From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 02 Jan 2013 14:24:00 -0800
Subject: [PATCH 23/26] ARM: S3C64XX: make regs-modem.h local
In-Reply-To: <1357165443-3716-1-git-send-email-kgene.kim@samsung.com>
References: <1357165443-3716-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1357165443-3716-24-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The header can be local in mach-s3c64xx/.

Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s3c64xx/mach-anw6410.c                  |    2 +-
 arch/arm/mach-s3c64xx/mach-crag6410.c                 |    2 +-
 arch/arm/mach-s3c64xx/mach-mini6410.c                 |    2 +-
 arch/arm/mach-s3c64xx/mach-real6410.c                 |    2 +-
 arch/arm/mach-s3c64xx/mach-smartq.c                   |    2 +-
 arch/arm/mach-s3c64xx/mach-smdk6410.c                 |    2 +-
 arch/arm/mach-s3c64xx/pm.c                            |    2 +-
 arch/arm/mach-s3c64xx/{include/mach => }/regs-modem.h |   11 +++++------
 8 files changed, 12 insertions(+), 13 deletions(-)
 rename arch/arm/mach-s3c64xx/{include/mach => }/regs-modem.h (78%)

diff --git a/arch/arm/mach-s3c64xx/mach-anw6410.c b/arch/arm/mach-s3c64xx/mach-anw6410.c
index 99e82ac..dac03ab 100644
--- a/arch/arm/mach-s3c64xx/mach-anw6410.c
+++ b/arch/arm/mach-s3c64xx/mach-anw6410.c
@@ -50,9 +50,9 @@
 #include <plat/devs.h>
 #include <plat/cpu.h>
 #include <mach/regs-gpio.h>
-#include <mach/regs-modem.h>
 
 #include "common.h"
+#include "regs-modem.h"
 
 /* DM9000 */
 #define ANW6410_PA_DM9000	(0x18000000)
diff --git a/arch/arm/mach-s3c64xx/mach-crag6410.c b/arch/arm/mach-s3c64xx/mach-crag6410.c
index e1a0742..d254135 100644
--- a/arch/arm/mach-s3c64xx/mach-crag6410.c
+++ b/arch/arm/mach-s3c64xx/mach-crag6410.c
@@ -52,7 +52,6 @@
 
 #include <mach/regs-sys.h>
 #include <mach/regs-gpio.h>
-#include <mach/regs-modem.h>
 
 #include <plat/regs-serial.h>
 #include <plat/fb.h>
@@ -71,6 +70,7 @@
 #include "common.h"
 #include "crag6410.h"
 #include "regs-gpio-memport.h"
+#include "regs-modem.h"
 
 /* serial port setup */
 
diff --git a/arch/arm/mach-s3c64xx/mach-mini6410.c b/arch/arm/mach-s3c64xx/mach-mini6410.c
index 07c349c..67881e6d 100644
--- a/arch/arm/mach-s3c64xx/mach-mini6410.c
+++ b/arch/arm/mach-s3c64xx/mach-mini6410.c
@@ -31,7 +31,6 @@
 
 #include <mach/map.h>
 #include <mach/regs-gpio.h>
-#include <mach/regs-modem.h>
 #include <mach/regs-srom.h>
 
 #include <plat/adc.h>
@@ -46,6 +45,7 @@
 #include <video/samsung_fimd.h>
 
 #include "common.h"
+#include "regs-modem.h"
 
 #define UCON S3C2410_UCON_DEFAULT
 #define ULCON (S3C2410_LCON_CS8 | S3C2410_LCON_PNONE | S3C2410_LCON_STOPB)
diff --git a/arch/arm/mach-s3c64xx/mach-real6410.c b/arch/arm/mach-s3c64xx/mach-real6410.c
index 7476f7c..f620b89 100644
--- a/arch/arm/mach-s3c64xx/mach-real6410.c
+++ b/arch/arm/mach-s3c64xx/mach-real6410.c
@@ -32,7 +32,6 @@
 
 #include <mach/map.h>
 #include <mach/regs-gpio.h>
-#include <mach/regs-modem.h>
 #include <mach/regs-srom.h>
 
 #include <plat/adc.h>
@@ -47,6 +46,7 @@
 #include <video/samsung_fimd.h>
 
 #include "common.h"
+#include "regs-modem.h"
 
 #define UCON S3C2410_UCON_DEFAULT
 #define ULCON (S3C2410_LCON_CS8 | S3C2410_LCON_PNONE | S3C2410_LCON_STOPB)
diff --git a/arch/arm/mach-s3c64xx/mach-smartq.c b/arch/arm/mach-s3c64xx/mach-smartq.c
index c6d7390..fc3e9b3 100644
--- a/arch/arm/mach-s3c64xx/mach-smartq.c
+++ b/arch/arm/mach-s3c64xx/mach-smartq.c
@@ -25,7 +25,6 @@
 
 #include <mach/map.h>
 #include <mach/regs-gpio.h>
-#include <mach/regs-modem.h>
 
 #include <plat/clock.h>
 #include <plat/cpu.h>
@@ -41,6 +40,7 @@
 #include <video/platform_lcd.h>
 
 #include "common.h"
+#include "regs-modem.h"
 
 #define UCON S3C2410_UCON_DEFAULT
 #define ULCON (S3C2410_LCON_CS8 | S3C2410_LCON_PNONE)
diff --git a/arch/arm/mach-s3c64xx/mach-smdk6410.c b/arch/arm/mach-s3c64xx/mach-smdk6410.c
index 574a9ee..f49ecae 100644
--- a/arch/arm/mach-s3c64xx/mach-smdk6410.c
+++ b/arch/arm/mach-s3c64xx/mach-smdk6410.c
@@ -57,7 +57,6 @@
 #include <asm/mach-types.h>
 
 #include <plat/regs-serial.h>
-#include <mach/regs-modem.h>
 #include <mach/regs-gpio.h>
 #include <mach/regs-sys.h>
 #include <mach/regs-srom.h>
@@ -75,6 +74,7 @@
 #include <plat/backlight.h>
 
 #include "common.h"
+#include "regs-modem.h"
 
 #define UCON S3C2410_UCON_DEFAULT | S3C2410_UCON_UCLK
 #define ULCON S3C2410_LCON_CS8 | S3C2410_LCON_PNONE | S3C2410_LCON_STOPB
diff --git a/arch/arm/mach-s3c64xx/pm.c b/arch/arm/mach-s3c64xx/pm.c
index f431987..c6eff9f 100644
--- a/arch/arm/mach-s3c64xx/pm.c
+++ b/arch/arm/mach-s3c64xx/pm.c
@@ -30,9 +30,9 @@
 #include <mach/regs-gpio.h>
 #include <mach/regs-clock.h>
 #include <mach/regs-syscon-power.h>
-#include <mach/regs-modem.h>
 
 #include "regs-gpio-memport.h"
+#include "regs-modem.h"
 
 struct s3c64xx_pm_domain {
 	char *const name;
diff --git a/arch/arm/mach-s3c64xx/include/mach/regs-modem.h b/arch/arm/mach-s3c64xx/regs-modem.h
similarity index 78%
rename from arch/arm/mach-s3c64xx/include/mach/regs-modem.h
rename to arch/arm/mach-s3c64xx/regs-modem.h
index 49f7759..073cdd3 100644
--- a/arch/arm/mach-s3c64xx/include/mach/regs-modem.h
+++ b/arch/arm/mach-s3c64xx/regs-modem.h
@@ -1,5 +1,4 @@
-/* arch/arm/plat-s3c64xx/include/plat/regs-modem.h
- *
+/*
  * Copyright 2008 Openmoko, Inc.
  * Copyright 2008 Simtec Electronics
  *      http://armlinux.simtec.co.uk/
@@ -12,10 +11,10 @@
  * published by the Free Software Foundation.
 */
 
-#ifndef __PLAT_S3C64XX_REGS_MODEM_H
-#define __PLAT_S3C64XX_REGS_MODEM_H __FILE__
+#ifndef __MACH_S3C64XX_REGS_MODEM_H
+#define __MACH_S3C64XX_REGS_MODEM_H __FILE__
 
-#define S3C64XX_MODEMREG(x)	(S3C64XX_VA_MODEM + (x))
+#define S3C64XX_MODEMREG(x)			(S3C64XX_VA_MODEM + (x))
 
 #define S3C64XX_MODEM_INT2AP			S3C64XX_MODEMREG(0x0)
 #define S3C64XX_MODEM_INT2MODEM			S3C64XX_MODEMREG(0x4)
@@ -28,4 +27,4 @@
 #define MIFPCON_INT2M_LEVEL			(1 << 4)
 #define MIFPCON_LCD_BYPASS			(1 << 3)
 
-#endif /* __PLAT_S3C64XX_REGS_MODEM_H */
+#endif /* __MACH_S3C64XX_REGS_MODEM_H */
-- 
1.7.10.4
