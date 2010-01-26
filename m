From: ben-linux@fluff.org (Ben Dooks)
Date: Tue, 26 Jan 2010 07:03:05 +0000
Subject: [PATCH] ARM: S3C64XX: Remove plat-s3c64xx Kconfig and PLAT_S3C64XX
In-Reply-To: <1264489385-13345-1-git-send-email-ben-linux@fluff.org>
References: <1264489385-13345-1-git-send-email-ben-linux@fluff.org>
Message-ID: <1264489385-13345-15-git-send-email-ben-linux@fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove the Kconfig and PLAT_S3C64XX defines for the previous S3C64XX
directory structure now that the code is moved into mach-s3c64xx.

Note, we cannot currently remove plat-s3c64xx directory as we have a
pair of include files used within plat-s3c and plat-samsung that need
to find a new home.

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
---
 arch/arm/Kconfig              |   16 +++++++++++++++-
 arch/arm/Makefile             |    2 +-
 arch/arm/plat-s3c64xx/Kconfig |   15 ---------------
 3 files changed, 16 insertions(+), 17 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 685ff7e..89fbed5 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -627,9 +627,24 @@ config ARCH_S3C2410
 
 config ARCH_S3C64XX
 	bool "Samsung S3C64XX"
+	select PLAT_S3C
+	select CPU_V6
 	select GENERIC_GPIO
+	select ARM_VIC
 	select HAVE_CLK
+	select NO_IOPORT
 	select ARCH_HAS_CPUFREQ
+	select ARCH_REQUIRE_GPIOLIB
+	select SAMSUNG_CLKSRC
+	select SAMSUNG_IRQ_VIC_TIMER
+	select SAMSUNG_IRQ_UART
+	select S3C_GPIO_TRACK
+	select S3C_GPIO_PULL_UPDOWN
+	select S3C_GPIO_CFG_S3C24XX
+	select S3C_GPIO_CFG_S3C64XX
+	select S3C_DEV_NAND
+	select USB_ARCH_HAS_OHCI
+	select SAMSUNG_GPIOLIB_4BIT
 	help
 	  Samsung S3C64XX series based systems
 
@@ -784,7 +799,6 @@ source "arch/arm/mach-dove/Kconfig"
 
 source "arch/arm/plat-samsung/Kconfig"
 source "arch/arm/plat-s3c24xx/Kconfig"
-source "arch/arm/plat-s3c64xx/Kconfig"
 source "arch/arm/plat-s3c/Kconfig"
 source "arch/arm/plat-s5p/Kconfig"
 source "arch/arm/plat-s5pc1xx/Kconfig"
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index ecf963d..c1300d8 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -183,7 +183,7 @@ plat-$(CONFIG_PLAT_NOMADIK)	:= nomadik
 plat-$(CONFIG_PLAT_ORION)	:= orion
 plat-$(CONFIG_PLAT_PXA)		:= pxa
 plat-$(CONFIG_PLAT_S3C24XX)	:= s3c24xx s3c samsung
-plat-$(CONFIG_PLAT_S3C64XX)	:= s3c64xx s3c samsung
+plat-$(CONFIG_ARCH_S3C64XX)	:= s3c64xx s3c samsung
 plat-$(CONFIG_PLAT_S5PC1XX)	:= s5pc1xx s3c samsung
 plat-$(CONFIG_PLAT_S5P)		:= s5p samsung s3c
 plat-$(CONFIG_ARCH_STMP3XXX)	:= stmp3xxx
diff --git a/arch/arm/plat-s3c64xx/Kconfig b/arch/arm/plat-s3c64xx/Kconfig
index 94ac74e..ae034c2 100644
--- a/arch/arm/plat-s3c64xx/Kconfig
+++ b/arch/arm/plat-s3c64xx/Kconfig
@@ -8,20 +8,5 @@ config PLAT_S3C64XX
 	bool
 	depends on ARCH_S3C64XX
 	default y
-	select CPU_V6
-	select PLAT_S3C
-	select ARM_VIC
-	select NO_IOPORT
-	select ARCH_REQUIRE_GPIOLIB
-	select SAMSUNG_CLKSRC
-	select SAMSUNG_IRQ_VIC_TIMER
-	select SAMSUNG_IRQ_UART
-	select S3C_GPIO_TRACK
-	select S3C_GPIO_PULL_UPDOWN
-	select S3C_GPIO_CFG_S3C24XX
-	select S3C_GPIO_CFG_S3C64XX
-	select S3C_DEV_NAND
-	select USB_ARCH_HAS_OHCI
-	select SAMSUNG_GPIOLIB_4BIT
 	help
 	  Base platform code for any Samsung S3C64XX device
-- 
1.6.0.4
