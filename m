From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Tue, 18 May 2010 12:38:43 +0200
Subject: [PATCH 05/11] ARM: S5PC100: Move frame buffer helpers from
	plat-s5pc1xx to mach-s5pc100
In-Reply-To: <1274179129-14659-1-git-send-email-m.szyprowski@samsung.com>
References: <1274179129-14659-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1274179129-14659-6-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move frame buffer helpers from plat-s5pc1xx to mach-s5pc100.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-s5pc100/Kconfig                      |    7 ++++++-
 arch/arm/mach-s5pc100/Makefile                     |    1 +
 .../setup-fb-24bpp.c                               |    4 ++--
 arch/arm/plat-s5pc1xx/Kconfig                      |    5 -----
 arch/arm/plat-s5pc1xx/Makefile                     |    1 -
 5 files changed, 9 insertions(+), 9 deletions(-)
 rename arch/arm/{plat-s5pc1xx => mach-s5pc100}/setup-fb-24bpp.c (91%)

diff --git a/arch/arm/mach-s5pc100/Kconfig b/arch/arm/mach-s5pc100/Kconfig
index 27ec167..7d9b68c 100644
--- a/arch/arm/mach-s5pc100/Kconfig
+++ b/arch/arm/mach-s5pc100/Kconfig
@@ -12,6 +12,11 @@ config CPU_S5PC100
 	help
 	  Enable S5PC100 CPU support
 
+config S5PC100_SETUP_FB_24BPP
+	bool
+	help
+	  Common setup code for S5PC1XX with an 24bpp RGB display helper.
+
 config S5PC100_SETUP_SDHCI
         bool
         select S5PC1XX_SETUP_SDHCI_GPIO
@@ -28,7 +33,7 @@ config MACH_SMDKC100
 	select S3C_DEV_HSMMC2
 	select S5PC1XX_SETUP_I2C0
 	select S5PC1XX_SETUP_I2C1
-	select S5PC1XX_SETUP_FB_24BPP
+	select S5PC100_SETUP_FB_24BPP
 	select S5PC100_SETUP_SDHCI
 	help
 	  Machine support for the Samsung SMDKC100
diff --git a/arch/arm/mach-s5pc100/Makefile b/arch/arm/mach-s5pc100/Makefile
index 4199ce2..1d1276c 100644
--- a/arch/arm/mach-s5pc100/Makefile
+++ b/arch/arm/mach-s5pc100/Makefile
@@ -15,6 +15,7 @@ obj-$(CONFIG_CPU_S5PC100)	+= cpu.o gpiolib.o
 
 # Helper and device support
 
+obj-$(CONFIG_S5PC100_SETUP_FB_24BPP)	+= setup-fb-24bpp.o
 obj-$(CONFIG_S5PC100_SETUP_SDHCI)       += setup-sdhci.o
 
 # machine support
diff --git a/arch/arm/plat-s5pc1xx/setup-fb-24bpp.c b/arch/arm/mach-s5pc100/setup-fb-24bpp.c
similarity index 91%
rename from arch/arm/plat-s5pc1xx/setup-fb-24bpp.c
rename to arch/arm/mach-s5pc100/setup-fb-24bpp.c
index b02c36f..6eba6cb 100644
--- a/arch/arm/plat-s5pc1xx/setup-fb-24bpp.c
+++ b/arch/arm/mach-s5pc100/setup-fb-24bpp.c
@@ -1,9 +1,9 @@
 /*
- * linux/arch/arm/plat-s5pc100/setup-fb-24bpp.c
+ * linux/arch/arm/mach-s5pc100/setup-fb-24bpp.c
  *
  * Copyright 2009 Samsung Electronics
  *
- * Base S5PC1XX setup information for 24bpp LCD framebuffer
+ * Base S5PC100 setup information for 24bpp LCD framebuffer
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
diff --git a/arch/arm/plat-s5pc1xx/Kconfig b/arch/arm/plat-s5pc1xx/Kconfig
index 98bbaf9..708f7a0 100644
--- a/arch/arm/plat-s5pc1xx/Kconfig
+++ b/arch/arm/plat-s5pc1xx/Kconfig
@@ -39,11 +39,6 @@ config CPU_S5PC100_CLOCK
 
 # platform specific device setup
 
-config S5PC1XX_SETUP_FB_24BPP
-	bool
-	help
-          Common setup code for S5PC1XX with an 24bpp RGB display helper.
-
 config S5PC1XX_SETUP_I2C0
 	bool
 	default y
diff --git a/arch/arm/plat-s5pc1xx/Makefile b/arch/arm/plat-s5pc1xx/Makefile
index 540fca5..a5b90c0 100644
--- a/arch/arm/plat-s5pc1xx/Makefile
+++ b/arch/arm/plat-s5pc1xx/Makefile
@@ -23,7 +23,6 @@ obj-$(CONFIG_CPU_S5PC100_CLOCK)	+= s5pc100-clock.o
 
 # Device setup
 
-obj-$(CONFIG_S5PC1XX_SETUP_FB_24BPP) += setup-fb-24bpp.o
 obj-$(CONFIG_S5PC1XX_SETUP_I2C0) += setup-i2c0.o
 obj-$(CONFIG_S5PC1XX_SETUP_I2C1) += setup-i2c1.o
 obj-$(CONFIG_S5PC1XX_SETUP_SDHCI_GPIO)	+= setup-sdhci-gpio.o
-- 
1.6.4
