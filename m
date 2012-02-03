From: ki0351.kim@samsung.com (=?ks_c_5601-1987?B?seiw5sDP?=)
Date: Fri, 03 Feb 2012 17:08:06 +0900
Subject: [PATCH 1/2] ARM: EXYNOS5: To use common config for EXYNOS4 and EXYNOS5
 SPI
Message-ID: <001c01cce24a$f629e5e0$e27db1a0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The naming EXYNOS4 is changed to EXYNOS
for using shared SPI config of EXYNOS4 and EXYNOS5.
And S3C64XX_DEV_SPIn configs are added to MACH_SMDK5250 config
to use SPI on the EYXNOS5250.

Signed-off-by: Kyoungil Kim <ki0351.kim@samsung.com>
---
 arch/arm/mach-exynos/Kconfig                   |    6 +++++-
 arch/arm/mach-exynos/Makefile                  |    2 +-
 arch/arm/mach-exynos/include/mach/spi-clocks.h |    2 +-
 3 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
index 745fdfd..a6ae2a3 100644
--- a/arch/arm/mach-exynos/Kconfig
+++ b/arch/arm/mach-exynos/Kconfig
@@ -171,7 +171,7 @@ config EXYNOS4_SETUP_USB_PHY
 	help
 	  Common setup code for USB PHY controller
 
-config EXYNOS4_SETUP_SPI
+config EXYNOS_SETUP_SPI
 	bool
 	help
 	  Common setup code for SPI GPIO configurations.
@@ -377,6 +377,10 @@ config MACH_SMDK5250
 	bool "SMDK5250"
 	select SOC_EXYNOS5250
 	select EXYNOS_DEV_DMA
+	select S3C64XX_DEV_SPI0
+	select S3C64XX_DEV_SPI1
+	select S3C64XX_DEV_SPI2
+	select EXYNOS_SETUP_SPI
 	help
 	  Machine support for Samsung SMDK4412
 endif
diff --git a/arch/arm/mach-exynos/Makefile b/arch/arm/mach-exynos/Makefile
index eccadc8..eb7a54f 100644
--- a/arch/arm/mach-exynos/Makefile
+++ b/arch/arm/mach-exynos/Makefile
@@ -68,4 +68,4 @@ obj-$(CONFIG_EXYNOS4_SETUP_I2C7)	+= setup-i2c7.o
 obj-$(CONFIG_EXYNOS4_SETUP_KEYPAD)	+= setup-keypad.o
 obj-$(CONFIG_EXYNOS4_SETUP_SDHCI_GPIO)	+= setup-sdhci-gpio.o
 obj-$(CONFIG_EXYNOS4_SETUP_USB_PHY)	+= setup-usb-phy.o
-obj-$(CONFIG_EXYNOS4_SETUP_SPI)		+= setup-spi.o
+obj-$(CONFIG_EXYNOS_SETUP_SPI)		+= setup-spi.o
diff --git a/arch/arm/mach-exynos/include/mach/spi-clocks.h b/arch/arm/mach-exynos/include/mach/spi-clocks.h
index 576efdf..c71a5fb 100644
--- a/arch/arm/mach-exynos/include/mach/spi-clocks.h
+++ b/arch/arm/mach-exynos/include/mach/spi-clocks.h
@@ -11,6 +11,6 @@
 #define __ASM_ARCH_SPI_CLKS_H __FILE__
 
 /* Must source from SCLK_SPI */
-#define EXYNOS4_SPI_SRCCLK_SCLK		0
+#define EXYNOS_SPI_SRCCLK_SCLK		0
 
 #endif /* __ASM_ARCH_SPI_CLKS_H */
-- 
1.7.1
