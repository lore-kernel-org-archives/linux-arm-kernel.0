From: heiko@sntech.de (Heiko =?iso-8859-1?q?St=FCbner?=)
Date: Tue, 6 Mar 2012 11:00:32 +0100
Subject: [PATCH 4/4] ARM: S3C24XX: Move device setup files to mach directory
In-Reply-To: <201203061057.15815.heiko@sntech.de>
References: <201203061057.15815.heiko@sntech.de>
Message-ID: <201203061100.32931.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Includes a small rename of the SETUP_TS option to a S3C24XX prefix.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/mach-s3c24xx/Kconfig                      |    7 ++++++-
 arch/arm/mach-s3c24xx/Makefile                     |    2 ++
 .../arm/{plat-s3c24xx => mach-s3c24xx}/setup-i2c.c |    0
 arch/arm/{plat-s3c24xx => mach-s3c24xx}/setup-ts.c |    0
 arch/arm/plat-s3c24xx/Kconfig                      |    5 -----
 arch/arm/plat-s3c24xx/Makefile                     |    4 ----
 6 files changed, 8 insertions(+), 10 deletions(-)
 rename arch/arm/{plat-s3c24xx => mach-s3c24xx}/setup-i2c.c (100%)
 rename arch/arm/{plat-s3c24xx => mach-s3c24xx}/setup-ts.c (100%)

diff --git a/arch/arm/mach-s3c24xx/Kconfig b/arch/arm/mach-s3c24xx/Kconfig
index df6f419..b399021 100644
--- a/arch/arm/mach-s3c24xx/Kconfig
+++ b/arch/arm/mach-s3c24xx/Kconfig
@@ -106,6 +106,11 @@ config S3C24XX_SIMTEC_USB
 	help
 	  USB management code for common Simtec S3C24XX boards
 
+config S3C24XX_SETUP_TS
+	bool
+	help
+	  Compile in platform device definition for Samsung TouchScreen.
+
 # cpu-specific sections
 
 if CPU_S3C2410
@@ -178,7 +183,7 @@ config ARCH_H1940
 	select PM_H1940 if PM
 	select S3C_DEV_USB_HOST
 	select S3C_DEV_NAND
-	select S3C2410_SETUP_TS
+	select S3C24XX_SETUP_TS
 	help
 	  Say Y here if you are using the HP IPAQ H1940
 
diff --git a/arch/arm/mach-s3c24xx/Makefile b/arch/arm/mach-s3c24xx/Makefile
index 2843c81..3f39e6f 100644
--- a/arch/arm/mach-s3c24xx/Makefile
+++ b/arch/arm/mach-s3c24xx/Makefile
@@ -91,3 +91,5 @@ obj-$(CONFIG_MACH_OSIRIS_DVS)		+= mach-osiris-dvs.o
 # device setup
 
 obj-$(CONFIG_S3C2416_SETUP_SDHCI_GPIO)	+= setup-sdhci-gpio.o
+obj-$(CONFIG_ARCH_S3C24XX)		+= setup-i2c.o
+obj-$(CONFIG_S3C24XX_SETUP_TS)		+= setup-ts.o
diff --git a/arch/arm/plat-s3c24xx/setup-i2c.c b/arch/arm/mach-s3c24xx/setup-i2c.c
similarity index 100%
rename from arch/arm/plat-s3c24xx/setup-i2c.c
rename to arch/arm/mach-s3c24xx/setup-i2c.c
diff --git a/arch/arm/plat-s3c24xx/setup-ts.c b/arch/arm/mach-s3c24xx/setup-ts.c
similarity index 100%
rename from arch/arm/plat-s3c24xx/setup-ts.c
rename to arch/arm/mach-s3c24xx/setup-ts.c
diff --git a/arch/arm/plat-s3c24xx/Kconfig b/arch/arm/plat-s3c24xx/Kconfig
index 0338d20..21bf6ad 100644
--- a/arch/arm/plat-s3c24xx/Kconfig
+++ b/arch/arm/plat-s3c24xx/Kconfig
@@ -113,9 +113,4 @@ config S3C2412_IOTIMING
 	  Intel node to select io timing code that is common to the s3c2412
 	  and the s3c2443.
 
-config S3C2410_SETUP_TS
-	bool
-	help
-	  Compile in platform device definition for Samsung TouchScreen.
-
 endif
diff --git a/arch/arm/plat-s3c24xx/Makefile b/arch/arm/plat-s3c24xx/Makefile
index 27dd9c5..2467b80 100644
--- a/arch/arm/plat-s3c24xx/Makefile
+++ b/arch/arm/plat-s3c24xx/Makefile
@@ -31,7 +31,3 @@ obj-$(CONFIG_S3C24XX_DMA)	+= dma.o
 obj-$(CONFIG_S3C2410_IOTIMING)	+= s3c2410-iotiming.o
 obj-$(CONFIG_S3C2412_IOTIMING)	+= s3c2412-iotiming.o
 obj-$(CONFIG_S3C2410_CPUFREQ_UTILS) += s3c2410-cpufreq-utils.o
-
-# device specific setup and/or initialisation
-obj-$(CONFIG_ARCH_S3C24XX)	+= setup-i2c.o
-obj-$(CONFIG_S3C2410_SETUP_TS)	+= setup-ts.o
-- 
1.7.5.4
