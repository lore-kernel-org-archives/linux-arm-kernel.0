From: kyungmin.park@samsung.com (Kyungmin Park)
Date: Thu, 04 Nov 2010 17:16:33 +0900
Subject: [PATCH] arm: Fix HAVE_S3C2410_WATCHDOG warnings
Message-ID: <20101104081633.GA27129@july>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix build warnings
warning: (ARCH_S3C64XX && <choice> && WATCHDOG || ARCH_S5P64X0 && <choice> && WATCHDOG || ARCH_S5P6442 && <choice> && WATCHDOG || ARCH_S5PC100 && <choice> || ARCH_S5PV210 && <choice> || ARCH_S5PV310 && <choice> || MACH_SMDK6410 && ARCH_S3C64XX) selects HAVE_S3C2410_WATCHDOG which has unmet direct dependencies (WATCHDOG)

Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index a19a526..a302713 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -677,7 +677,7 @@ config ARCH_S3C64XX
 	select USB_ARCH_HAS_OHCI
 	select SAMSUNG_GPIOLIB_4BIT
 	select HAVE_S3C2410_I2C
-	select HAVE_S3C2410_WATCHDOG
+	select HAVE_S3C2410_WATCHDOG if WATCHDOG
 	help
 	  Samsung S3C64XX series based systems
 
@@ -686,7 +686,7 @@ config ARCH_S5P64X0
 	select CPU_V6
 	select GENERIC_GPIO
 	select HAVE_CLK
-	select HAVE_S3C2410_WATCHDOG
+	select HAVE_S3C2410_WATCHDOG if WATCHDOG
 	select ARCH_USES_GETTIMEOFFSET
 	select HAVE_S3C2410_I2C
 	select HAVE_S3C_RTC
@@ -700,7 +700,7 @@ config ARCH_S5P6442
 	select GENERIC_GPIO
 	select HAVE_CLK
 	select ARCH_USES_GETTIMEOFFSET
-	select HAVE_S3C2410_WATCHDOG
+	select HAVE_S3C2410_WATCHDOG if WATCHDOG
 	help
 	  Samsung S5P6442 CPU based systems
 
@@ -713,7 +713,7 @@ config ARCH_S5PC100
 	select ARCH_USES_GETTIMEOFFSET
 	select HAVE_S3C2410_I2C
 	select HAVE_S3C_RTC
-	select HAVE_S3C2410_WATCHDOG
+	select HAVE_S3C2410_WATCHDOG if WATCHDOG
 	help
 	  Samsung S5PC100 series based systems
 
@@ -728,7 +728,7 @@ config ARCH_S5PV210
 	select ARCH_USES_GETTIMEOFFSET
 	select HAVE_S3C2410_I2C
 	select HAVE_S3C_RTC
-	select HAVE_S3C2410_WATCHDOG
+	select HAVE_S3C2410_WATCHDOG if WATCHDOG
 	help
 	  Samsung S5PV210/S5PC110 series based systems
 
@@ -741,7 +741,7 @@ config ARCH_S5PV310
 	select GENERIC_CLOCKEVENTS
 	select HAVE_S3C_RTC
 	select HAVE_S3C2410_I2C
-	select HAVE_S3C2410_WATCHDOG
+	select HAVE_S3C2410_WATCHDOG if WATCHDOG
 	help
 	  Samsung S5PV310 series based systems
 
