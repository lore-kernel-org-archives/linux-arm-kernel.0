From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 21 Jul 2010 18:00:31 +0900
Subject: [PATCH] ARM: SAMSUNG: Make RTC driver dependency SoC specific instead
	of machine specific
Message-ID: <1279702831-14968-1-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Atul Dahiya <atul.dahiya@samsung.com>

This patch moves the dependency of RTC driver from MACH_XXX(board) to
ARCH_XXX(SoC). This will enable all machines using Samsung S5P6440, S5PC100
and S5PV210 SoCs to use RTC driver by default.

Signed-off-by: Atul Dahiya <atul.dahiya@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/Kconfig              |    3 +++
 arch/arm/mach-s5p6440/Kconfig |    1 -
 arch/arm/mach-s5pc100/Kconfig |    1 -
 arch/arm/mach-s5pv210/Kconfig |    2 --
 4 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 98922f7..ea668a4 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -672,6 +672,7 @@ config ARCH_S5P6440
 	select GENERIC_GPIO
 	select HAVE_CLK
 	select ARCH_USES_GETTIMEOFFSET
+	select HAVE_S3C_RTC
 	help
 	  Samsung S5P6440 CPU based systems
 
@@ -691,6 +692,7 @@ config ARCH_S5PC100
 	select CPU_V7
 	select ARM_L1_CACHE_SHIFT_6
 	select ARCH_USES_GETTIMEOFFSET
+	select HAVE_S3C_RTC
 	help
 	  Samsung S5PC100 series based systems
 
@@ -701,6 +703,7 @@ config ARCH_S5PV210
 	select HAVE_CLK
 	select ARM_L1_CACHE_SHIFT_6
 	select ARCH_USES_GETTIMEOFFSET
+	select HAVE_S3C_RTC
 	help
 	  Samsung S5PV210/S5PC110 series based systems
 
diff --git a/arch/arm/mach-s5p6440/Kconfig b/arch/arm/mach-s5p6440/Kconfig
index b2d4716..de8f08d 100644
--- a/arch/arm/mach-s5p6440/Kconfig
+++ b/arch/arm/mach-s5p6440/Kconfig
@@ -20,7 +20,6 @@ config MACH_SMDK6440
 	select SAMSUNG_DEV_ADC
 	select S3C_DEV_RTC
 	select S3C_DEV_WDT
-	select HAVE_S3C_RTC
 	select HAVE_S3C2410_WATCHDOG
 	help
 	  Machine support for the Samsung SMDK6440
diff --git a/arch/arm/mach-s5pc100/Kconfig b/arch/arm/mach-s5pc100/Kconfig
index 2602895..e9c3d98 100644
--- a/arch/arm/mach-s5pc100/Kconfig
+++ b/arch/arm/mach-s5pc100/Kconfig
@@ -48,7 +48,6 @@ config MACH_SMDKC100
 	select S5PC100_SETUP_FB_24BPP
 	select S5PC100_SETUP_I2C1
 	select S5PC100_SETUP_SDHCI
-	select HAVE_S3C_RTC
 	help
 	  Machine support for the Samsung SMDKC100
 
diff --git a/arch/arm/mach-s5pv210/Kconfig b/arch/arm/mach-s5pv210/Kconfig
index 04597cc..7f029d1 100644
--- a/arch/arm/mach-s5pv210/Kconfig
+++ b/arch/arm/mach-s5pv210/Kconfig
@@ -75,7 +75,6 @@ config MACH_SMDKV210
 	select SAMSUNG_DEV_TS
 	select S3C_DEV_RTC
 	select S3C_DEV_WDT
-	select HAVE_S3C_RTC
 	select HAVE_S3C2410_WATCHDOG
 	help
 	  Machine support for Samsung SMDKV210
@@ -86,7 +85,6 @@ config MACH_SMDKC110
 	select ARCH_SPARSEMEM_ENABLE
 	select S3C_DEV_RTC
 	select S3C_DEV_WDT
-	select HAVE_S3C_RTC
 	select HAVE_S3C2410_WATCHDOG
 	help
 	  Machine support for Samsung SMDKC110
-- 
1.6.2.5
