From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 13 Oct 2015 10:27:05 +0900
Subject: [PATCH 1/4] ARM: exynos_defconfig: Enable Maxim 8997 family drivers
Message-ID: <1444699628-3774-1-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable support for Maxim 8997 Multi Functional Device present on Trats and
Origen boards by toggling on drivers: charger, haptic motor,
LED, RTC and extcon.

This allows to test and usage of these boards with exynos config.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 arch/arm/configs/exynos_defconfig | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_defconfig
index 7172e96af22e..0bf9c31f4661 100644
--- a/arch/arm/configs/exynos_defconfig
+++ b/arch/arm/configs/exynos_defconfig
@@ -74,6 +74,8 @@ CONFIG_KEYBOARD_CROS_EC=y
 CONFIG_MOUSE_CYAPA=y
 CONFIG_INPUT_TOUCHSCREEN=y
 CONFIG_TOUCHSCREEN_ATMEL_MXT=y
+CONFIG_INPUT_MISC=y
+CONFIG_INPUT_MAX8997_HAPTIC=y
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_SAMSUNG=y
 CONFIG_SERIAL_SAMSUNG_CONSOLE=y
@@ -95,6 +97,7 @@ CONFIG_BATTERY_MAX17040=y
 CONFIG_BATTERY_MAX17042=y
 CONFIG_CHARGER_MAX14577=y
 CONFIG_CHARGER_MAX77693=y
+CONFIG_CHARGER_MAX8997=y
 CONFIG_CHARGER_TPS65090=y
 CONFIG_SENSORS_LM90=y
 CONFIG_SENSORS_NTC_THERMISTOR=y
@@ -178,9 +181,11 @@ CONFIG_NEW_LEDS=y
 CONFIG_LEDS_CLASS=y
 CONFIG_LEDS_GPIO=y
 CONFIG_LEDS_PWM=y
+CONFIG_LEDS_MAX8997=y
 CONFIG_LEDS_TRIGGERS=y
 CONFIG_LEDS_TRIGGER_HEARTBEAT=y
 CONFIG_RTC_CLASS=y
+CONFIG_RTC_DRV_MAX8997=y
 CONFIG_RTC_DRV_MAX77686=y
 CONFIG_RTC_DRV_MAX77802=y
 CONFIG_RTC_DRV_S5M=y
@@ -195,6 +200,7 @@ CONFIG_COMMON_CLK_S2MPS11=y
 CONFIG_EXTCON=y
 CONFIG_EXTCON_MAX14577=y
 CONFIG_EXTCON_MAX77693=y
+CONFIG_EXTCON_MAX8997=y
 CONFIG_IIO=y
 CONFIG_EXYNOS_ADC=y
 CONFIG_PWM=y
-- 
1.9.1
