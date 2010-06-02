From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed,  2 Jun 2010 16:06:08 +0900
Subject: [PATCH v2] ARM: S5PC100: Add Watchdog support for S5PC100
Message-ID: <1275462368-21621-1-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Banajit Goswami <banajit.g@samsung.com>

This patch adds support for Watchdog timer for Samsung S5PC100.

Signed-off-by: Banajit Goswami <banajit.g@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
Changes since v1:
- Move the dependency of watchdog timer driver from MACH_XXX(board)
  to ARCH_XXX(SoC) as per comments from Ben Dooks

 arch/arm/Kconfig                         |    1 +
 arch/arm/mach-s5pc100/Kconfig            |    1 +
 arch/arm/mach-s5pc100/include/mach/map.h |    3 +++
 arch/arm/mach-s5pc100/mach-smdkc100.c    |    1 +
 4 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 40c90bd..47fb03e 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -693,6 +693,7 @@ config ARCH_S5PC100
 	select CPU_V7
 	select ARM_L1_CACHE_SHIFT_6
 	select ARCH_USES_GETTIMEOFFSET
+	select HAVE_S3C2410_WATCHDOG
 	help
 	  Samsung S5PC100 series based systems
 
diff --git a/arch/arm/mach-s5pc100/Kconfig b/arch/arm/mach-s5pc100/Kconfig
index b2a11df..56ebd3c 100644
--- a/arch/arm/mach-s5pc100/Kconfig
+++ b/arch/arm/mach-s5pc100/Kconfig
@@ -12,6 +12,7 @@ config CPU_S5PC100
 	select PLAT_S5P
 	select S5P_EXT_INT
 	select S3C_PL330_DMA
+	select S3C_DEV_WDT
 	help
 	  Enable S5PC100 CPU support
 
diff --git a/arch/arm/mach-s5pc100/include/mach/map.h b/arch/arm/mach-s5pc100/include/mach/map.h
index cadae43..4b3a7b7 100644
--- a/arch/arm/mach-s5pc100/include/mach/map.h
+++ b/arch/arm/mach-s5pc100/include/mach/map.h
@@ -72,6 +72,8 @@
 
 #define S5PC100_PA_SYSTIMER	(0xEA100000)
 
+#define S5PC100_PA_WATCHDOG	(0xEA200000)
+
 #define S5PC100_PA_UART		(0xEC000000)
 
 #define S5P_PA_UART0		(S5PC100_PA_UART + 0x0)
@@ -131,6 +133,7 @@
 #define S3C_PA_HSMMC2		S5PC100_PA_HSMMC(2)
 #define S3C_PA_KEYPAD		S5PC100_PA_KEYPAD
 #define S3C_PA_TSADC		S5PC100_PA_TSADC
+#define S3C_PA_WDT		S5PC100_PA_WATCHDOG
 #define S3C_PA_ONENAND		S5PC100_PA_ONENAND
 #define S3C_PA_ONENAND_BUF	S5PC100_PA_ONENAND_BUF
 #define S3C_SZ_ONENAND_BUF	S5PC100_SZ_ONENAND_BUF
diff --git a/arch/arm/mach-s5pc100/mach-smdkc100.c b/arch/arm/mach-s5pc100/mach-smdkc100.c
index af22f82..49c0270 100644
--- a/arch/arm/mach-s5pc100/mach-smdkc100.c
+++ b/arch/arm/mach-s5pc100/mach-smdkc100.c
@@ -159,6 +159,7 @@ static struct platform_device *smdkc100_devices[] __initdata = {
 	&smdkc100_lcd_powerdev,
 	&s5pc100_device_iis0,
 	&s5pc100_device_ac97,
+	&s3c_device_wdt,
 };
 
 static void __init smdkc100_map_io(void)
-- 
1.6.2.5
