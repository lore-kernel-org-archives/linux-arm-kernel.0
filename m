From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri, 18 Dec 2015 15:17:48 +0100
Subject: [PATCH 35/69] clocksource/drivers/Kconfig: Add missing
 GENERIC_CLOCKEVENTS dependency
In-Reply-To: <1450448302-27429-1-git-send-email-daniel.lezcano@linaro.org>
References: <5672CB9E.7090707@linaro.org>
 <1450448302-27429-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1450448302-27429-35-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to compile on all arch without error with 'allyesconfig' make
sure the platform selected the GENERIC_CLOCKEVENTS. Without this patch
the new added drivers will prevent the kernel to compile on PARISC.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/Kconfig | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 7085eb7..de331b8 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -29,11 +29,13 @@ config CLKSRC_MMIO
 
 config DIGICOLOR_TIMER
 	bool "Digicolor timer driver" if COMPILE_TEST
+	depends on GENERIC_CLOCKEVENTS
 	help
 	  Enables the support for the digicolor timer driver.
 
 config DW_APB_TIMER
 	bool "DW APB timer driver" if COMPILE_TEST
+	depends on GENERIC_CLOCKEVENTS
 	help
 	  Enables the support for the dw_apb timer.
 
@@ -58,6 +60,7 @@ config ARMADA_370_XP_TIMER
 
 config MESON6_TIMER
 	bool "Meson6 timer driver" if COMPILE_TEST
+	depends on GENERIC_CLOCKEVENTS
 	select CLKSRC_MMIO
 	help
 	  Enables the support for the Meson6 timer driver.
@@ -72,6 +75,7 @@ config ORION_TIMER
 
 config SUN4I_TIMER
 	bool "Sun4i timer driver" if COMPILE_TEST
+	depends on GENERIC_CLOCKEVENTS
 	select CLKSRC_MMIO
 	help
 	  Enables support for the Sun4i timer.
@@ -91,6 +95,7 @@ config TEGRA_TIMER
 
 config VT8500_TIMER
 	bool "VT8500 timer driver" if COMPILE_TEST
+	depends on GENERIC_CLOCKEVENTS
 	help
 	  Enables support for the VT8500 driver.
 
@@ -102,6 +107,7 @@ config CADENCE_TTC_TIMER
 
 config ASM9260_TIMER
 	bool "ASM9260 timer driver" if COMPILE_TEST
+	depends on GENERIC_CLOCKEVENTS
 	select CLKSRC_MMIO
 	select CLKSRC_OF
 	help
@@ -124,6 +130,7 @@ config CLKSRC_NOMADIK_MTU_SCHED_CLOCK
 
 config CLKSRC_DBX500_PRCMU
 	bool "Clocksource PRCMU Timer" if COMPILE_TEST
+	depends on GENERIC_CLOCKEVENTS
 	help
 	  Use the always on PRCMU Timer as clocksource
 
@@ -145,6 +152,7 @@ config CLKSRC_EFM32
 
 config CLKSRC_LPC32XX
 	bool "Clocksource for LPC32XX" if COMPILE_TEST
+	depends on GENERIC_CLOCKEVENTS
 	select CLKSRC_MMIO
 	select CLKSRC_OF
 	help
@@ -238,6 +246,7 @@ config CLKSRC_EXYNOS_MCT
 
 config CLKSRC_SAMSUNG_PWM
 	bool "PWM timer drvier for Samsung S3C, S5P" if COMPILE_TEST
+	depends on GENERIC_CLOCKEVENTS
 	help
 	  This is a new clocksource driver for the PWM timer found in
 	  Samsung S3C, S5P and Exynos SoCs, replacing an earlier driver
@@ -246,6 +255,7 @@ config CLKSRC_SAMSUNG_PWM
 
 config FSL_FTM_TIMER
 	bool "Freescale FlexTimer Module driver" if COMPILE_TEST
+	depends on GENERIC_CLOCKEVENTS
 	help
 	  Support for Freescale FlexTimer Module (FTM) timer.
 
@@ -259,6 +269,7 @@ config SYS_SUPPORTS_SH_CMT
 
 config MTK_TIMER
 	bool "Mediatek timer driver" if COMPILE_TEST
+	depends on GENERIC_CLOCKEVENTS
 	select CLKSRC_OF
 	select CLKSRC_MMIO
 	help
-- 
1.9.1
