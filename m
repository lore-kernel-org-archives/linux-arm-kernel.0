From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 21 Jul 2010 18:00:12 +0900
Subject: [PATCH 3/5] ARM: S5P6440: Add RTC support for S5P6440
In-Reply-To: <1279702814-14929-1-git-send-email-kgene.kim@samsung.com>
References: <1279702814-14929-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1279702814-14929-4-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Atul Dahiya <atul.dahiya@samsung.com>

This patch adds support RTC driver for Samsung S5P6440.

Signed-off-by: Atul Dahiya <atul.dahiya@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s5p6440/Kconfig            |    2 ++
 arch/arm/mach-s5p6440/include/mach/map.h |    2 +-
 arch/arm/mach-s5p6440/mach-smdk6440.c    |    1 +
 3 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-s5p6440/Kconfig b/arch/arm/mach-s5p6440/Kconfig
index f066fae..b2d4716 100644
--- a/arch/arm/mach-s5p6440/Kconfig
+++ b/arch/arm/mach-s5p6440/Kconfig
@@ -18,7 +18,9 @@ config MACH_SMDK6440
 	select CPU_S5P6440
 	select SAMSUNG_DEV_TS
 	select SAMSUNG_DEV_ADC
+	select S3C_DEV_RTC
 	select S3C_DEV_WDT
+	select HAVE_S3C_RTC
 	select HAVE_S3C2410_WATCHDOG
 	help
 	  Machine support for the Samsung SMDK6440
diff --git a/arch/arm/mach-s5p6440/include/mach/map.h b/arch/arm/mach-s5p6440/include/mach/map.h
index 44011b9..255a2e7 100644
--- a/arch/arm/mach-s5p6440/include/mach/map.h
+++ b/arch/arm/mach-s5p6440/include/mach/map.h
@@ -38,7 +38,6 @@
 #define S5P_PA_TIMER		S5P6440_PA_TIMER
 
 #define S5P6440_PA_RTC		(0xEA100000)
-#define S5P_PA_RTC		S5P6440_PA_RTC
 
 #define S5P6440_PA_WDT		(0xEA200000)
 #define S5P_PA_WDT		S5P6440_PA_WDT
@@ -77,6 +76,7 @@
 /* compatibiltiy defines. */
 #define S3C_PA_UART		S5P6440_PA_UART
 #define S3C_PA_IIC		S5P6440_PA_IIC0
+#define S3C_PA_RTC		S5P6440_PA_RTC
 #define S3C_PA_WDT		S5P6440_PA_WDT
 
 #define SAMSUNG_PA_ADC		S5P6440_PA_ADC
diff --git a/arch/arm/mach-s5p6440/mach-smdk6440.c b/arch/arm/mach-s5p6440/mach-smdk6440.c
index 8291fec..142edd5 100644
--- a/arch/arm/mach-s5p6440/mach-smdk6440.c
+++ b/arch/arm/mach-s5p6440/mach-smdk6440.c
@@ -88,6 +88,7 @@ static struct s3c2410_uartcfg smdk6440_uartcfgs[] __initdata = {
 static struct platform_device *smdk6440_devices[] __initdata = {
 	&s5p6440_device_iis,
 	&s3c_device_adc,
+	&s3c_device_rtc,
 	&s3c_device_ts,
 	&s3c_device_wdt,
 };
-- 
1.6.2.5
