From: rajeshwari.s@samsung.com (Rajeshwari Shinde)
Date: Mon, 08 Aug 2011 14:17:52 +0530
Subject: RFC[PATCH 2/6] ARM: S5P64X0: Enable SDHCI device
In-Reply-To: <1312793277-18689-1-git-send-email-rajeshwari.s@samsung.com>
References: <1312793277-18689-1-git-send-email-rajeshwari.s@samsung.com>
Message-ID: <1312793277-18689-3-git-send-email-rajeshwari.s@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Select HSMMC device for S5P6440 and S5P6450.

Signed-off-by: Rajeshwari Shinde <rajeshwari.s@samsung.com>
---
 arch/arm/mach-s5p64x0/Kconfig |   30 ++++++++++++++++++++++++++++++
 1 files changed, 30 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s5p64x0/Kconfig b/arch/arm/mach-s5p64x0/Kconfig
index 65c7518..bbc533e 100644
--- a/arch/arm/mach-s5p64x0/Kconfig
+++ b/arch/arm/mach-s5p64x0/Kconfig
@@ -26,6 +26,18 @@ config S5P64X0_SETUP_I2C1
 	help
 	  Common setup code for i2c bus 1.
 
+config S5P64X0_SETUP_SDHCI
+	bool
+	select S5P64X0_SETUP_SDHCI_GPIO
+	help
+	  Internal helper functions for S5P64X0 based SDHCI systems
+
+config S5P64X0_SETUP_SDHCI_GPIO
+	bool
+	help
+	  Common setup code for SDHCI gpio.
+	  Gpio values are machine specific.
+
 # machine support
 
 config MACH_SMDK6440
@@ -34,12 +46,16 @@ config MACH_SMDK6440
 	select S3C_DEV_I2C1
 	select S3C_DEV_RTC
 	select S3C_DEV_WDT
+	select S3C_DEV_HSMMC
+	select S3C_DEV_HSMMC1
+	select S3C_DEV_HSMMC2
 	select S3C64XX_DEV_SPI
 	select SAMSUNG_DEV_ADC
 	select SAMSUNG_DEV_BACKLIGHT
 	select SAMSUNG_DEV_PWM
 	select SAMSUNG_DEV_TS
 	select S5P64X0_SETUP_I2C1
+	select S5P64X0_SETUP_SDHCI
 	help
 	  Machine support for the Samsung SMDK6440
 
@@ -49,13 +65,27 @@ config MACH_SMDK6450
 	select S3C_DEV_I2C1
 	select S3C_DEV_RTC
 	select S3C_DEV_WDT
+	select S3C_DEV_HSMMC
+	select S3C_DEV_HSMMC1
+	select S3C_DEV_HSMMC2
 	select S3C64XX_DEV_SPI
 	select SAMSUNG_DEV_ADC
 	select SAMSUNG_DEV_BACKLIGHT
 	select SAMSUNG_DEV_PWM
 	select SAMSUNG_DEV_TS
 	select S5P64X0_SETUP_I2C1
+	select S5P64X0_SETUP_SDHCI
 	help
 	  Machine support for the Samsung SMDK6450
 
+menu "Use 8-bit SDHCI bus width"
+
+config S5P64X0_SD_CH1_8BIT
+	bool "SDHCI Channel 1 (Slot 1)"
+	depends on MACH_SMDK6450 || MACH_SMDK6440
+	help
+	  Support SDHCI Channel 1 8-bit bus.
+
+endmenu
+
 endif
-- 
1.7.4.4
