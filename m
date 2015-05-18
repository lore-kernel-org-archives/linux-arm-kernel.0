From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Mon, 18 May 2015 10:47:14 +0900
Subject: [PATCH v2 2/4] ARM: multi_v7_defconfig: Enable PMIC and MUIC drivers
 for Exynos boards
In-Reply-To: <1431913636-31854-1-git-send-email-k.kozlowski@samsung.com>
References: <1431913636-31854-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1431913636-31854-3-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable drivers for PMICs and MUICs present on Exynos-based devices:
 - max14577: charger, fuel gauge (max17040), regulator,
   used on: Gear 1, Gear 2,
 - max77693: charger, fuel gauge (max17042),
   used on: Trats2,
 - s5m/s2mps: RTC, clock,
   used on: Arndale, Arndale Octa, Gear 1, Gear 2

This allows full usage of charging stack on these devices along with RTC
and 32 kHz clocks.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 arch/arm/configs/multi_v7_defconfig | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index d524d2e9633c..f09ae2089284 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -328,6 +328,10 @@ CONFIG_GPIO_SYSCON=y
 CONFIG_GPIO_TPS6586X=y
 CONFIG_GPIO_TPS65910=y
 CONFIG_BATTERY_SBS=y
+CONFIG_CHARGER_MAX14577=m
+CONFIG_BATTERY_MAX17040=m
+CONFIG_BATTERY_MAX17042=m
+CONFIG_CHARGER_MAX77693=m
 CONFIG_CHARGER_TPS65090=y
 CONFIG_POWER_RESET_AS3722=y
 CONFIG_POWER_RESET_GPIO=y
@@ -357,8 +361,10 @@ CONFIG_MFD_AXP20X=y
 CONFIG_MFD_CROS_EC=y
 CONFIG_MFD_CROS_EC_I2C=m
 CONFIG_MFD_CROS_EC_SPI=y
+CONFIG_MFD_MAX14577=y
 CONFIG_MFD_MAX77686=y
 CONFIG_MFD_MAX8907=y
+CONFIG_MFD_MAX77693=y
 CONFIG_MFD_SEC_CORE=y
 CONFIG_MFD_STMPE=y
 CONFIG_MFD_PALMAS=y
@@ -374,9 +380,11 @@ CONFIG_REGULATOR_DA9210=y
 CONFIG_REGULATOR_GPIO=y
 CONFIG_MFD_SYSCON=y
 CONFIG_POWER_RESET_SYSCON=y
+CONFIG_REGULATOR_MAX14577=m
 CONFIG_REGULATOR_MAX8907=y
 CONFIG_REGULATOR_MAX8973=y
 CONFIG_REGULATOR_MAX77686=y
+CONFIG_REGULATOR_MAX77693=m
 CONFIG_REGULATOR_MAX77802=m
 CONFIG_REGULATOR_PALMAS=y
 CONFIG_REGULATOR_S2MPS11=y
@@ -529,6 +537,7 @@ CONFIG_RTC_DRV_SUN6I=y
 CONFIG_RTC_DRV_SUNXI=y
 CONFIG_RTC_DRV_MV=y
 CONFIG_RTC_DRV_TEGRA=y
+CONFIG_RTC_DRV_S5M=m
 CONFIG_DMADEVICES=y
 CONFIG_DW_DMAC=y
 CONFIG_MV_XOR=y
@@ -558,6 +567,7 @@ CONFIG_QCOM_GSBI=y
 CONFIG_COMMON_CLK_QCOM=y
 CONFIG_COMMON_CLK_MAX77686=y
 CONFIG_COMMON_CLK_MAX77802=m
+CONFIG_COMMON_CLK_S2MPS11=m
 CONFIG_APQ_MMCC_8084=y
 CONFIG_MSM_GCC_8660=y
 CONFIG_MSM_MMCC_8960=y
-- 
1.9.1
