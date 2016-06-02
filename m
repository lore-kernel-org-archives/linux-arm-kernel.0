From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 02 Jun 2016 07:55:13 +0200
Subject: [PATCH 1/4] ARM: multi_v7_defconfig: Enable Trats2 audio codec,
 touchscreen and sensors
Message-ID: <1464846916-3110-1-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Exynos4412-based Trats2 board has CM36651 proximity/ambient light
sensor, MMS114 touchscreen and Wolfson Microelectronics WM1811 CODEC.
Enable them in defconfig to get some testing coverage and use its
features.

While saving defconfig the SND_SOC_ODROIDX2 is removed because it does
not exist since commit ee12a817bb4b ("ASoC: samsung: Remove unused
Odroid x2/u3 machine driver").

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 arch/arm/configs/multi_v7_defconfig | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 995cc9b444bf..c5db9cf02e31 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -270,6 +270,7 @@ CONFIG_MOUSE_CYAPA=m
 CONFIG_MOUSE_ELAN_I2C=y
 CONFIG_INPUT_TOUCHSCREEN=y
 CONFIG_TOUCHSCREEN_ATMEL_MXT=y
+CONFIG_TOUCHSCREEN_MMS114=m
 CONFIG_TOUCHSCREEN_ST1232=m
 CONFIG_TOUCHSCREEN_STMPE=y
 CONFIG_TOUCHSCREEN_SUN4I=y
@@ -515,6 +516,7 @@ CONFIG_REGULATOR_TPS6586X=y
 CONFIG_REGULATOR_TPS65910=y
 CONFIG_REGULATOR_TWL4030=y
 CONFIG_REGULATOR_VEXPRESS=y
+CONFIG_REGULATOR_WM8994=m
 CONFIG_MEDIA_SUPPORT=m
 CONFIG_MEDIA_CAMERA_SUPPORT=y
 CONFIG_MEDIA_CONTROLLER=y
@@ -597,13 +599,14 @@ CONFIG_SND_SOC_ROCKCHIP=m
 CONFIG_SND_SOC_ROCKCHIP_SPDIF=m
 CONFIG_SND_SOC_ROCKCHIP_MAX98090=m
 CONFIG_SND_SOC_ROCKCHIP_RT5645=m
+CONFIG_SND_SOC_SAMSUNG=m
+CONFIG_SND_SOC_SAMSUNG_SMDK_WM8994=m
+CONFIG_SND_SOC_SMDK_WM8994_PCM=m
+CONFIG_SND_SOC_SNOW=m
 CONFIG_SND_SOC_SH4_FSI=m
 CONFIG_SND_SOC_RCAR=m
 CONFIG_SND_SOC_RSRC_CARD=m
 CONFIG_SND_SUN4I_CODEC=m
-CONFIG_SND_SOC_SAMSUNG=m
-CONFIG_SND_SOC_SNOW=m
-CONFIG_SND_SOC_ODROIDX2=m
 CONFIG_SND_SOC_TEGRA=m
 CONFIG_SND_SOC_TEGRA_RT5640=m
 CONFIG_SND_SOC_TEGRA_WM8753=m
@@ -800,6 +803,7 @@ CONFIG_BERLIN2_ADC=m
 CONFIG_EXYNOS_ADC=m
 CONFIG_VF610_ADC=m
 CONFIG_XILINX_XADC=y
+CONFIG_CM36651=m
 CONFIG_AK8975=y
 CONFIG_RASPBERRYPI_POWER=y
 CONFIG_PWM=y
-- 
1.9.1
