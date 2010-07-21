From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 21 Jul 2010 18:00:14 +0900
Subject: [PATCH 5/5] ARM: S5PV210: Add RTC support for S5PV210 and S5PC110
In-Reply-To: <1279702814-14929-1-git-send-email-kgene.kim@samsung.com>
References: <1279702814-14929-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1279702814-14929-6-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Atul Dahiya <atul.dahiya@samsung.com>

This patch adds support RTC driver for Samsung S5PV210/S5PC110.

Signed-off-by: Atul Dahiya <atul.dahiya@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s5pv210/Kconfig            |    4 ++++
 arch/arm/mach-s5pv210/include/mach/map.h |    2 ++
 arch/arm/mach-s5pv210/mach-smdkc110.c    |    1 +
 arch/arm/mach-s5pv210/mach-smdkv210.c    |    1 +
 4 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s5pv210/Kconfig b/arch/arm/mach-s5pv210/Kconfig
index 0761eac..04597cc 100644
--- a/arch/arm/mach-s5pv210/Kconfig
+++ b/arch/arm/mach-s5pv210/Kconfig
@@ -73,7 +73,9 @@ config MACH_SMDKV210
 	select ARCH_SPARSEMEM_ENABLE
 	select SAMSUNG_DEV_ADC
 	select SAMSUNG_DEV_TS
+	select S3C_DEV_RTC
 	select S3C_DEV_WDT
+	select HAVE_S3C_RTC
 	select HAVE_S3C2410_WATCHDOG
 	help
 	  Machine support for Samsung SMDKV210
@@ -82,7 +84,9 @@ config MACH_SMDKC110
 	bool "SMDKC110"
 	select CPU_S5PV210
 	select ARCH_SPARSEMEM_ENABLE
+	select S3C_DEV_RTC
 	select S3C_DEV_WDT
+	select HAVE_S3C_RTC
 	select HAVE_S3C2410_WATCHDOG
 	help
 	  Machine support for Samsung SMDKC110
diff --git a/arch/arm/mach-s5pv210/include/mach/map.h b/arch/arm/mach-s5pv210/include/mach/map.h
index 34eb168..743ae4a 100644
--- a/arch/arm/mach-s5pv210/include/mach/map.h
+++ b/arch/arm/mach-s5pv210/include/mach/map.h
@@ -43,6 +43,7 @@
 
 #define S5PV210_PA_WATCHDOG	(0xE2700000)
 
+#define S5PV210_PA_RTC		(0xE2800000)
 #define S5PV210_PA_UART		(0xE2900000)
 
 #define S5P_PA_UART0		(S5PV210_PA_UART + 0x0)
@@ -101,6 +102,7 @@
 #define S3C_PA_IIC1		S5PV210_PA_IIC1
 #define S3C_PA_IIC2		S5PV210_PA_IIC2
 #define S3C_PA_FB		S5PV210_PA_FB
+#define S3C_PA_RTC		S5PV210_PA_RTC
 #define S3C_PA_WDT		S5PV210_PA_WATCHDOG
 
 #define SAMSUNG_PA_ADC		S5PV210_PA_ADC
diff --git a/arch/arm/mach-s5pv210/mach-smdkc110.c b/arch/arm/mach-s5pv210/mach-smdkc110.c
index 4c8903c..2b48d5a 100644
--- a/arch/arm/mach-s5pv210/mach-smdkc110.c
+++ b/arch/arm/mach-s5pv210/mach-smdkc110.c
@@ -74,6 +74,7 @@ static struct s3c2410_uartcfg smdkv210_uartcfgs[] __initdata = {
 static struct platform_device *smdkc110_devices[] __initdata = {
 	&s5pv210_device_iis0,
 	&s5pv210_device_ac97,
+	&s3c_device_rtc,
 	&s3c_device_wdt,
 };
 
diff --git a/arch/arm/mach-s5pv210/mach-smdkv210.c b/arch/arm/mach-s5pv210/mach-smdkv210.c
index 0d46279..15e2b9b 100644
--- a/arch/arm/mach-s5pv210/mach-smdkv210.c
+++ b/arch/arm/mach-s5pv210/mach-smdkv210.c
@@ -77,6 +77,7 @@ static struct platform_device *smdkv210_devices[] __initdata = {
 	&s5pv210_device_iis0,
 	&s5pv210_device_ac97,
 	&s3c_device_adc,
+	&s3c_device_rtc,
 	&s3c_device_ts,
 	&s3c_device_wdt,
 };
-- 
1.6.2.5
