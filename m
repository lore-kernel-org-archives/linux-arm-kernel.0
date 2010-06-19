From: kgene.kim@samsung.com (Kukjin Kim)
Date: Sat, 19 Jun 2010 11:28:31 +0900
Subject: [PATCH 2/2] ARM: SAMSUNG: Make WDT driver dependency SoC specific
	instead of machine specific
In-Reply-To: <1276914511-7677-1-git-send-email-kgene.kim@samsung.com>
References: <1276914511-7677-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1276914511-7677-2-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Banajit Goswami <banajit.g@samsung.com>

This patch moves the dependency of watchdog timer driver from
MACH_XXX(board) to ARCH_XXX(SoC). This will enable all machines
using Samsung S3C64XX, S5P6440, S5PC100 and S5PV210/S5PC110 SoCs
to use the WDT driver by default.

Signed-off-by: Banajit Goswami <banajit.g@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/Kconfig              |    4 ++++
 arch/arm/mach-s3c64xx/Kconfig |    1 -
 arch/arm/mach-s5p6440/Kconfig |    1 -
 arch/arm/mach-s5pc100/Kconfig |    1 -
 arch/arm/mach-s5pv210/Kconfig |    2 --
 5 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 1f254bd..47fb03e 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -663,6 +663,7 @@ config ARCH_S3C64XX
 	select S3C_DEV_NAND
 	select USB_ARCH_HAS_OHCI
 	select SAMSUNG_GPIOLIB_4BIT
+	select HAVE_S3C2410_WATCHDOG
 	help
 	  Samsung S3C64XX series based systems
 
@@ -672,6 +673,7 @@ config ARCH_S5P6440
 	select GENERIC_GPIO
 	select HAVE_CLK
 	select ARCH_USES_GETTIMEOFFSET
+	select HAVE_S3C2410_WATCHDOG
 	help
 	  Samsung S5P6440 CPU based systems
 
@@ -691,6 +693,7 @@ config ARCH_S5PC100
 	select CPU_V7
 	select ARM_L1_CACHE_SHIFT_6
 	select ARCH_USES_GETTIMEOFFSET
+	select HAVE_S3C2410_WATCHDOG
 	help
 	  Samsung S5PC100 series based systems
 
@@ -701,6 +704,7 @@ config ARCH_S5PV210
 	select HAVE_CLK
 	select ARM_L1_CACHE_SHIFT_6
 	select ARCH_USES_GETTIMEOFFSET
+	select HAVE_S3C2410_WATCHDOG
 	help
 	  Samsung S5PV210/S5PC110 series based systems
 
diff --git a/arch/arm/mach-s3c64xx/Kconfig b/arch/arm/mach-s3c64xx/Kconfig
index f5a5972..915cb47 100644
--- a/arch/arm/mach-s3c64xx/Kconfig
+++ b/arch/arm/mach-s3c64xx/Kconfig
@@ -100,7 +100,6 @@ config MACH_SMDK6410
 	select S3C_DEV_USB_HOST
 	select S3C_DEV_USB_HSOTG
 	select S3C_DEV_WDT
-	select HAVE_S3C2410_WATCHDOG
 	select S3C64XX_SETUP_SDHCI
 	select S3C64XX_SETUP_I2C1
 	select S3C64XX_SETUP_FB_24BPP
diff --git a/arch/arm/mach-s5p6440/Kconfig b/arch/arm/mach-s5p6440/Kconfig
index f066fae..084c0bc 100644
--- a/arch/arm/mach-s5p6440/Kconfig
+++ b/arch/arm/mach-s5p6440/Kconfig
@@ -19,7 +19,6 @@ config MACH_SMDK6440
 	select SAMSUNG_DEV_TS
 	select SAMSUNG_DEV_ADC
 	select S3C_DEV_WDT
-	select HAVE_S3C2410_WATCHDOG
 	help
 	  Machine support for the Samsung SMDK6440
 
diff --git a/arch/arm/mach-s5pc100/Kconfig b/arch/arm/mach-s5pc100/Kconfig
index b63b440..0593b3f 100644
--- a/arch/arm/mach-s5pc100/Kconfig
+++ b/arch/arm/mach-s5pc100/Kconfig
@@ -45,7 +45,6 @@ config MACH_SMDKC100
 	select S3C_DEV_HSMMC1
 	select S3C_DEV_HSMMC2
 	select S3C_DEV_WDT
-	select HAVE_S3C2410_WATCHDOG
 	select S5PC100_SETUP_FB_24BPP
 	select S5PC100_SETUP_I2C1
 	select S5PC100_SETUP_SDHCI
diff --git a/arch/arm/mach-s5pv210/Kconfig b/arch/arm/mach-s5pv210/Kconfig
index 0761eac..2e3ed18 100644
--- a/arch/arm/mach-s5pv210/Kconfig
+++ b/arch/arm/mach-s5pv210/Kconfig
@@ -74,7 +74,6 @@ config MACH_SMDKV210
 	select SAMSUNG_DEV_ADC
 	select SAMSUNG_DEV_TS
 	select S3C_DEV_WDT
-	select HAVE_S3C2410_WATCHDOG
 	help
 	  Machine support for Samsung SMDKV210
 
@@ -83,7 +82,6 @@ config MACH_SMDKC110
 	select CPU_S5PV210
 	select ARCH_SPARSEMEM_ENABLE
 	select S3C_DEV_WDT
-	select HAVE_S3C2410_WATCHDOG
 	help
 	  Machine support for Samsung SMDKC110
 	  S5PC110(MCP) is one of package option of S5PV210
-- 
1.6.2.5
