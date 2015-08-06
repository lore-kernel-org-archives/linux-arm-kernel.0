From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Thu,  6 Aug 2015 16:43:33 +0200
Subject: [PATCH] ARM: multi_v7_defconfig: Build a few drivers in
Message-ID: <1438872213-24754-1-git-send-email-tomeu.vizoso@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Drivers for devices that are basic dependencies (regulators, mainly) of
other devices are better built into the image because otherwise we get
so many probe deferrals that is hard to spot where a device is having
genuine trouble to probe.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---
 arch/arm/configs/multi_v7_defconfig | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index fb587b2330ad..4c5431e99522 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -309,7 +309,7 @@ CONFIG_I2C_SUN6I_P2WI=y
 CONFIG_I2C_TEGRA=y
 CONFIG_I2C_XILINX=y
 CONFIG_I2C_RCAR=y
-CONFIG_I2C_CROS_EC_TUNNEL=m
+CONFIG_I2C_CROS_EC_TUNNEL=y
 CONFIG_SPI=y
 CONFIG_SPI_ATMEL=m
 CONFIG_SPI_CADENCE=y
@@ -318,7 +318,7 @@ CONFIG_SPI_OMAP24XX=y
 CONFIG_SPI_ORION=y
 CONFIG_SPI_PL022=y
 CONFIG_SPI_RSPI=y
-CONFIG_SPI_S3C64XX=m
+CONFIG_SPI_S3C64XX=y
 CONFIG_SPI_SH_MSIOF=m
 CONFIG_SPI_SH_HSPI=y
 CONFIG_SPI_SIRF=y
@@ -408,7 +408,7 @@ CONFIG_REGULATOR_MAX14577=m
 CONFIG_REGULATOR_MAX8907=y
 CONFIG_REGULATOR_MAX8973=y
 CONFIG_REGULATOR_MAX77686=y
-CONFIG_REGULATOR_MAX77802=m
+CONFIG_REGULATOR_MAX77802=y
 CONFIG_REGULATOR_MAX77693=m
 CONFIG_REGULATOR_PALMAS=y
 CONFIG_REGULATOR_PWM=m
@@ -557,7 +557,7 @@ CONFIG_RTC_DRV_AS3722=y
 CONFIG_RTC_DRV_DS1307=y
 CONFIG_RTC_DRV_MAX8907=y
 CONFIG_RTC_DRV_MAX77686=y
-CONFIG_RTC_DRV_MAX77802=m
+CONFIG_RTC_DRV_MAX77802=y
 CONFIG_RTC_DRV_RS5C372=m
 CONFIG_RTC_DRV_PALMAS=y
 CONFIG_RTC_DRV_ST_LPC=y
@@ -610,7 +610,7 @@ CONFIG_COMMON_CLK_QCOM=y
 CONFIG_CHROME_PLATFORMS=y
 CONFIG_CROS_EC_CHARDEV=m
 CONFIG_COMMON_CLK_MAX77686=y
-CONFIG_COMMON_CLK_MAX77802=m
+CONFIG_COMMON_CLK_MAX77802=y
 CONFIG_COMMON_CLK_S2MPS11=m
 CONFIG_APQ_MMCC_8084=y
 CONFIG_MSM_GCC_8660=y
@@ -632,7 +632,7 @@ CONFIG_PWM=y
 CONFIG_PWM_ATMEL=m
 CONFIG_PWM_ATMEL_TCB=m
 CONFIG_PWM_RENESAS_TPU=y
-CONFIG_PWM_SAMSUNG=m
+CONFIG_PWM_SAMSUNG=y
 CONFIG_PWM_SUN4I=y
 CONFIG_PWM_TEGRA=y
 CONFIG_PWM_VT8500=y
@@ -647,7 +647,7 @@ CONFIG_PHY_STIH41X_USB=y
 CONFIG_PHY_STIH407_USB=y
 CONFIG_PHY_SUN4I_USB=y
 CONFIG_PHY_SUN9I_USB=y
-CONFIG_PHY_SAMSUNG_USB2=m
+CONFIG_PHY_SAMSUNG_USB2=y
 CONFIG_EXT4_FS=y
 CONFIG_AUTOFS4_FS=y
 CONFIG_MSDOS_FS=y
-- 
2.4.3
