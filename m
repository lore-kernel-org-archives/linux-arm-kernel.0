From: enric.balletbo@collabora.com (Enric Balletbo i Serra)
Date: Thu, 22 Mar 2018 18:38:40 +0100
Subject: [PATCH] arm64: defconfig: Enable ChromeOS EC drivers for supported
 Chromebooks.
Message-ID: <20180322173840.26062-1-enric.balletbo@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable following drivers for merged devices:
- ChromeOS EC RTC driver.
- ChromeOS EC userspace interface.
- ChromeOS EC light and proximity sensors.
- ChromeOS EC Barometer Sensor driver.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---
 arch/arm64/configs/defconfig | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index d65d53b1ff77..3c2188f8c1fb 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -341,6 +341,7 @@ CONFIG_MFD_AXP20X_RSB=y
 CONFIG_MFD_CROS_EC=y
 CONFIG_MFD_CROS_EC_I2C=y
 CONFIG_MFD_CROS_EC_SPI=y
+CONFIG_MFD_CROS_EC_CHARDEV=m
 CONFIG_MFD_EXYNOS_LPASS=m
 CONFIG_MFD_HI6421_PMIC=y
 CONFIG_MFD_HI655X_PMIC=y
@@ -492,6 +493,7 @@ CONFIG_RTC_DRV_SUN6I=y
 CONFIG_RTC_DRV_ARMADA38X=y
 CONFIG_RTC_DRV_TEGRA=y
 CONFIG_RTC_DRV_XGENE=y
+CONFIG_RTC_DRV_CROS_EC=y
 CONFIG_DMADEVICES=y
 CONFIG_DMA_BCM2835=m
 CONFIG_K3_DMA=y
@@ -546,6 +548,10 @@ CONFIG_EXTCON_USBC_CROS_EC=y
 CONFIG_IIO=y
 CONFIG_EXYNOS_ADC=y
 CONFIG_ROCKCHIP_SARADC=m
+CONFIG_IIO_CROS_EC_SENSORS_CORE=m
+CONFIG_IIO_CROS_EC_SENSORS=m
+CONFIG_IIO_CROS_EC_LIGHT_PROX=m
+CONFIG_IIO_CROS_EC_BARO=m
 CONFIG_PWM=y
 CONFIG_PWM_BCM2835=m
 CONFIG_PWM_CROS_EC=m
-- 
2.16.2
