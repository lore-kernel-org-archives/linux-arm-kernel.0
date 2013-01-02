From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 02 Jan 2013 14:24:02 -0800
Subject: [PATCH 25/26] ARM: S3C64XX: make regs-sys.h local
In-Reply-To: <1357165443-3716-1-git-send-email-kgene.kim@samsung.com>
References: <1357165443-3716-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1357165443-3716-26-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The header file can be local in mach-s3c64xx/.

Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s3c64xx/clock.c                 |    3 ++-
 arch/arm/mach-s3c64xx/cpuidle.c               |    3 ++-
 arch/arm/mach-s3c64xx/dma.c                   |    4 ++--
 arch/arm/mach-s3c64xx/include/mach/regs-sys.h |   31 -------------------------
 arch/arm/mach-s3c64xx/mach-crag6410.c         |    2 +-
 arch/arm/mach-s3c64xx/mach-smdk6410.c         |    2 +-
 arch/arm/mach-s3c64xx/pm.c                    |    2 +-
 arch/arm/mach-s3c64xx/regs-sys.h              |   30 ++++++++++++++++++++++++
 arch/arm/mach-s3c64xx/setup-usb-phy.c         |    3 ++-
 9 files changed, 41 insertions(+), 39 deletions(-)
 delete mode 100644 arch/arm/mach-s3c64xx/include/mach/regs-sys.h
 create mode 100644 arch/arm/mach-s3c64xx/regs-sys.h

diff --git a/arch/arm/mach-s3c64xx/clock.c b/arch/arm/mach-s3c64xx/clock.c
index 803711e..8499415 100644
--- a/arch/arm/mach-s3c64xx/clock.c
+++ b/arch/arm/mach-s3c64xx/clock.c
@@ -23,7 +23,6 @@
 #include <mach/hardware.h>
 #include <mach/map.h>
 
-#include <mach/regs-sys.h>
 #include <mach/regs-clock.h>
 
 #include <plat/cpu.h>
@@ -33,6 +32,8 @@
 #include <plat/clock-clksrc.h>
 #include <plat/pll.h>
 
+#include "regs-sys.h"
+
 /* fin_apll, fin_mpll and fin_epll are all the same clock, which we call
  * ext_xtal_mux for want of an actual name from the manual.
 */
diff --git a/arch/arm/mach-s3c64xx/cpuidle.c b/arch/arm/mach-s3c64xx/cpuidle.c
index acb197c..e3e455b 100644
--- a/arch/arm/mach-s3c64xx/cpuidle.c
+++ b/arch/arm/mach-s3c64xx/cpuidle.c
@@ -20,9 +20,10 @@
 
 #include <mach/map.h>
 
-#include <mach/regs-sys.h>
 #include <mach/regs-syscon-power.h>
 
+#include "regs-sys.h"
+
 static int s3c64xx_enter_idle(struct cpuidle_device *dev,
 			      struct cpuidle_driver *drv,
 			      int index)
diff --git a/arch/arm/mach-s3c64xx/dma.c b/arch/arm/mach-s3c64xx/dma.c
index f2a7a17..ec29b35 100644
--- a/arch/arm/mach-s3c64xx/dma.c
+++ b/arch/arm/mach-s3c64xx/dma.c
@@ -28,10 +28,10 @@
 #include <mach/map.h>
 #include <mach/irqs.h>
 
-#include <mach/regs-sys.h>
-
 #include <asm/hardware/pl080.h>
 
+#include "regs-sys.h"
+
 /* dma channel state information */
 
 struct s3c64xx_dmac {
diff --git a/arch/arm/mach-s3c64xx/include/mach/regs-sys.h b/arch/arm/mach-s3c64xx/include/mach/regs-sys.h
deleted file mode 100644
index b91e020..0000000
--- a/arch/arm/mach-s3c64xx/include/mach/regs-sys.h
+++ /dev/null
@@ -1,31 +0,0 @@
-/* arch/arm/plat-s3c64xx/include/plat/regs-sys.h
- *
- * Copyright 2008 Openmoko, Inc.
- * Copyright 2008 Simtec Electronics
- *	Ben Dooks <ben@simtec.co.uk>
- *	http://armlinux.simtec.co.uk/
- *
- * S3C64XX system register definitions
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#ifndef __PLAT_REGS_SYS_H
-#define __PLAT_REGS_SYS_H __FILE__
-
-#define S3C_SYSREG(x)		(S3C_VA_SYS + (x))
-
-#define S3C64XX_AHB_CON0	S3C_SYSREG(0x100)
-#define S3C64XX_AHB_CON1	S3C_SYSREG(0x104)
-#define S3C64XX_AHB_CON2	S3C_SYSREG(0x108)
-
-#define S3C64XX_SDMA_SEL	S3C_SYSREG(0x110)
-
-#define S3C64XX_OTHERS		S3C_SYSREG(0x900)
-
-#define S3C64XX_OTHERS_USBMASK	(1 << 16)
-#define S3C64XX_OTHERS_SYNCMUXSEL	(1 << 6)
-
-#endif /* _PLAT_REGS_SYS_H */
diff --git a/arch/arm/mach-s3c64xx/mach-crag6410.c b/arch/arm/mach-s3c64xx/mach-crag6410.c
index d254135..8b89e89 100644
--- a/arch/arm/mach-s3c64xx/mach-crag6410.c
+++ b/arch/arm/mach-s3c64xx/mach-crag6410.c
@@ -50,7 +50,6 @@
 #include <mach/hardware.h>
 #include <mach/map.h>
 
-#include <mach/regs-sys.h>
 #include <mach/regs-gpio.h>
 
 #include <plat/regs-serial.h>
@@ -71,6 +70,7 @@
 #include "crag6410.h"
 #include "regs-gpio-memport.h"
 #include "regs-modem.h"
+#include "regs-sys.h"
 
 /* serial port setup */
 
diff --git a/arch/arm/mach-s3c64xx/mach-smdk6410.c b/arch/arm/mach-s3c64xx/mach-smdk6410.c
index dcf41bd..ddd0eb8 100644
--- a/arch/arm/mach-s3c64xx/mach-smdk6410.c
+++ b/arch/arm/mach-s3c64xx/mach-smdk6410.c
@@ -58,7 +58,6 @@
 
 #include <plat/regs-serial.h>
 #include <mach/regs-gpio.h>
-#include <mach/regs-sys.h>
 #include <linux/platform_data/ata-samsung_cf.h>
 #include <linux/platform_data/i2c-s3c2410.h>
 #include <plat/fb.h>
@@ -75,6 +74,7 @@
 #include "common.h"
 #include "regs-modem.h"
 #include "regs-srom.h"
+#include "regs-sys.h"
 
 #define UCON S3C2410_UCON_DEFAULT | S3C2410_UCON_UCLK
 #define ULCON S3C2410_LCON_CS8 | S3C2410_LCON_PNONE | S3C2410_LCON_STOPB
diff --git a/arch/arm/mach-s3c64xx/pm.c b/arch/arm/mach-s3c64xx/pm.c
index c6eff9f..546d6e0 100644
--- a/arch/arm/mach-s3c64xx/pm.c
+++ b/arch/arm/mach-s3c64xx/pm.c
@@ -26,13 +26,13 @@
 #include <plat/pm.h>
 #include <plat/wakeup-mask.h>
 
-#include <mach/regs-sys.h>
 #include <mach/regs-gpio.h>
 #include <mach/regs-clock.h>
 #include <mach/regs-syscon-power.h>
 
 #include "regs-gpio-memport.h"
 #include "regs-modem.h"
+#include "regs-sys.h"
 
 struct s3c64xx_pm_domain {
 	char *const name;
diff --git a/arch/arm/mach-s3c64xx/regs-sys.h b/arch/arm/mach-s3c64xx/regs-sys.h
new file mode 100644
index 0000000..8c411fb
--- /dev/null
+++ b/arch/arm/mach-s3c64xx/regs-sys.h
@@ -0,0 +1,30 @@
+/*
+ * Copyright 2008 Openmoko, Inc.
+ * Copyright 2008 Simtec Electronics
+ *	Ben Dooks <ben@simtec.co.uk>
+ *	http://armlinux.simtec.co.uk/
+ *
+ * S3C64XX system register definitions
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#ifndef __MACH_S3C64XX_REGS_SYS_H
+#define __MACH_S3C64XX_REGS_SYS_H __FILE__
+
+#define S3C_SYSREG(x)			(S3C_VA_SYS + (x))
+
+#define S3C64XX_AHB_CON0		S3C_SYSREG(0x100)
+#define S3C64XX_AHB_CON1		S3C_SYSREG(0x104)
+#define S3C64XX_AHB_CON2		S3C_SYSREG(0x108)
+
+#define S3C64XX_SDMA_SEL		S3C_SYSREG(0x110)
+
+#define S3C64XX_OTHERS			S3C_SYSREG(0x900)
+
+#define S3C64XX_OTHERS_USBMASK		(1 << 16)
+#define S3C64XX_OTHERS_SYNCMUXSEL	(1 << 6)
+
+#endif /* __MACH_S3C64XX_REGS_SYS_H */
diff --git a/arch/arm/mach-s3c64xx/setup-usb-phy.c b/arch/arm/mach-s3c64xx/setup-usb-phy.c
index f6757e0..c8174d9 100644
--- a/arch/arm/mach-s3c64xx/setup-usb-phy.c
+++ b/arch/arm/mach-s3c64xx/setup-usb-phy.c
@@ -15,11 +15,12 @@
 #include <linux/io.h>
 #include <linux/platform_device.h>
 #include <mach/map.h>
-#include <mach/regs-sys.h>
 #include <plat/cpu.h>
 #include <plat/regs-usb-hsotg-phy.h>
 #include <plat/usb-phy.h>
 
+#include "regs-sys.h"
+
 static int s3c_usb_otgphy_init(struct platform_device *pdev)
 {
 	struct clk *xusbxti;
-- 
1.7.10.4
