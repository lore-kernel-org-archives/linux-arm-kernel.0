From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 13 Oct 2015 10:27:07 +0900
Subject: [PATCH 3/4] ARM: multi_v7_defconfig: Enable Maxim 8997 family drivers
In-Reply-To: <1444699628-3774-1-git-send-email-k.kozlowski@samsung.com>
References: <1444699628-3774-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1444699628-3774-3-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable support for Maxim 8997 Multi Function Device present on Trats and
Origen boards by toggling on drivers: main MFD, charger, haptic motor,
regulator, LED and RTC.

This allows to test and usage of these boards with multi_v7 config.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 arch/arm/configs/multi_v7_defconfig | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 05948da5bb69..0b2b474649a2 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -248,6 +248,7 @@ CONFIG_TOUCHSCREEN_ST1232=m
 CONFIG_TOUCHSCREEN_STMPE=y
 CONFIG_TOUCHSCREEN_SUN4I=y
 CONFIG_INPUT_MISC=y
+CONFIG_INPUT_MAX8997_HAPTIC=m
 CONFIG_INPUT_MPU3050=y
 CONFIG_INPUT_AXP20X_PEK=y
 CONFIG_INPUT_ADXL34X=m
@@ -359,6 +360,7 @@ CONFIG_BATTERY_MAX17040=m
 CONFIG_BATTERY_MAX17042=m
 CONFIG_CHARGER_MAX14577=m
 CONFIG_CHARGER_MAX77693=m
+CONFIG_CHARGER_MAX8997=m
 CONFIG_CHARGER_TPS65090=y
 CONFIG_POWER_RESET_AS3722=y
 CONFIG_POWER_RESET_GPIO=y
@@ -397,6 +399,7 @@ CONFIG_MFD_MAX14577=y
 CONFIG_MFD_MAX77686=y
 CONFIG_MFD_MAX77693=y
 CONFIG_MFD_MAX8907=y
+CONFIG_MFD_MAX8997=y
 CONFIG_MFD_RK808=y
 CONFIG_MFD_PM8921_CORE=y
 CONFIG_MFD_QCOM_RPM=y
@@ -421,6 +424,7 @@ CONFIG_POWER_RESET_SYSCON=y
 CONFIG_REGULATOR_MAX14577=m
 CONFIG_REGULATOR_MAX8907=y
 CONFIG_REGULATOR_MAX8973=y
+CONFIG_REGULATOR_MAX8997=m
 CONFIG_REGULATOR_MAX77686=y
 CONFIG_REGULATOR_MAX77693=m
 CONFIG_REGULATOR_MAX77802=m
@@ -568,6 +572,7 @@ CONFIG_NEW_LEDS=y
 CONFIG_LEDS_CLASS=y
 CONFIG_LEDS_GPIO=y
 CONFIG_LEDS_PWM=y
+CONFIG_LEDS_MAX8997=m
 CONFIG_LEDS_TRIGGERS=y
 CONFIG_LEDS_TRIGGER_TIMER=y
 CONFIG_LEDS_TRIGGER_ONESHOT=y
@@ -587,6 +592,7 @@ CONFIG_RTC_DRV_AS3722=y
 CONFIG_RTC_DRV_DS1307=y
 CONFIG_RTC_DRV_HYM8563=m
 CONFIG_RTC_DRV_MAX8907=y
+CONFIG_RTC_DRV_MAX8997=m
 CONFIG_RTC_DRV_MAX77686=y
 CONFIG_RTC_DRV_RK808=m
 CONFIG_RTC_DRV_MAX77802=m
-- 
1.9.1
