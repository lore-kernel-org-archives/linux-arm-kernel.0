From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Mon, 04 Apr 2016 16:43:50 +0900
Subject: [PATCH] ARM: exynos_defconfig: Enable Trats2 audio codec,
 touchscreen and sensors
Message-ID: <1459755830-20390-1-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Exynos4412-based Trats2 board has Asahi Kasei AK 3-Axis
Magnetometer, CM36651 proximity/ambient light sensor, MMS114 touchscreen
and Wolfson Microelectronics WM1811 CODEC. Enable them in defconfig to
get some testing coverage and use its features.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 arch/arm/configs/exynos_defconfig | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_defconfig
index 6ffd7e76f3ce..d8f09e5558bf 100644
--- a/arch/arm/configs/exynos_defconfig
+++ b/arch/arm/configs/exynos_defconfig
@@ -74,6 +74,7 @@ CONFIG_KEYBOARD_CROS_EC=y
 CONFIG_MOUSE_CYAPA=y
 CONFIG_INPUT_TOUCHSCREEN=y
 CONFIG_TOUCHSCREEN_ATMEL_MXT=y
+CONFIG_TOUCHSCREEN_MMS114=y
 CONFIG_INPUT_MISC=y
 CONFIG_INPUT_MAX77693_HAPTIC=y
 CONFIG_INPUT_MAX8997_HAPTIC=y
@@ -93,6 +94,7 @@ CONFIG_SPI=y
 CONFIG_SPI_GPIO=y
 CONFIG_SPI_S3C64XX=y
 CONFIG_DEBUG_GPIO=y
+CONFIG_GPIO_WM8994=y
 CONFIG_POWER_SUPPLY=y
 CONFIG_BATTERY_SBS=y
 CONFIG_BATTERY_MAX17040=y
@@ -134,6 +136,7 @@ CONFIG_REGULATOR_S2MPA01=y
 CONFIG_REGULATOR_S2MPS11=y
 CONFIG_REGULATOR_S5M8767=y
 CONFIG_REGULATOR_TPS65090=y
+CONFIG_REGULATOR_WM8994=y
 CONFIG_MEDIA_SUPPORT=m
 CONFIG_MEDIA_CAMERA_SUPPORT=y
 CONFIG_MEDIA_USB_SUPPORT=y
@@ -160,6 +163,8 @@ CONFIG_SOUND=y
 CONFIG_SND=y
 CONFIG_SND_SOC=y
 CONFIG_SND_SOC_SAMSUNG=y
+CONFIG_SND_SOC_SAMSUNG_SMDK_WM8994=y
+CONFIG_SND_SOC_SMDK_WM8994_PCM=y
 CONFIG_SND_SOC_SNOW=y
 CONFIG_SND_SOC_ODROIDX2=y
 CONFIG_SND_SIMPLE_CARD=y
@@ -210,6 +215,8 @@ CONFIG_EXTCON_MAX77693=y
 CONFIG_EXTCON_MAX8997=y
 CONFIG_IIO=y
 CONFIG_EXYNOS_ADC=y
+CONFIG_CM36651=y
+CONFIG_AK8975=y
 CONFIG_PWM=y
 CONFIG_PWM_SAMSUNG=y
 CONFIG_PHY_EXYNOS5250_SATA=y
-- 
2.5.0
