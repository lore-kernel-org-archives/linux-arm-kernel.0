From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 17 Nov 2015 00:38:28 +0800
Subject: [PATCH v3 9/9] ARM: multi_v7_defconfig: Enable RSB and AXP20X related
 drivers as modules
In-Reply-To: <1447691908-25456-1-git-send-email-wens@csie.org>
References: <1447691908-25456-1-git-send-email-wens@csie.org>
Message-ID: <1447691908-25456-10-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

axp20x support has been split into 2 parts, I2C and RSB interface
variants.

Update the MFD_AXP20X symbol for I2C support. Also enable SUNXI_RSB
MFD_AXP20X_RSB to support RSB variants. Build these drivers as
modules.

Keep MFD_AXP20X enabled for now, to ease migration for automated
boot farms while the patches are being merged. This should be
removed in the next release.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/configs/multi_v7_defconfig | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 69a22fdb52a5..bf6dac096bb6 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -169,6 +169,7 @@ CONFIG_DMA_CMA=y
 CONFIG_CMA_SIZE_MBYTES=64
 CONFIG_OMAP_OCP2SCP=y
 CONFIG_SIMPLE_PM_BUS=y
+CONFIG_SUNXI_RSB=m
 CONFIG_MTD=y
 CONFIG_MTD_CMDLINE_PARTS=y
 CONFIG_MTD_BLOCK=y
@@ -253,7 +254,7 @@ CONFIG_TOUCHSCREEN_SUN4I=y
 CONFIG_TOUCHSCREEN_WM97XX=m
 CONFIG_INPUT_MISC=y
 CONFIG_INPUT_MPU3050=y
-CONFIG_INPUT_AXP20X_PEK=y
+CONFIG_INPUT_AXP20X_PEK=m
 CONFIG_INPUT_ADXL34X=m
 CONFIG_SERIO_AMBAKMI=y
 CONFIG_SERIAL_8250=y
@@ -366,6 +367,7 @@ CONFIG_BATTERY_MAX17042=m
 CONFIG_CHARGER_MAX14577=m
 CONFIG_CHARGER_MAX77693=m
 CONFIG_CHARGER_TPS65090=y
+CONFIG_AXP20X_POWER=m
 CONFIG_POWER_RESET_AS3722=y
 CONFIG_POWER_RESET_GPIO=y
 CONFIG_POWER_RESET_GPIO_RESTART=y
@@ -397,6 +399,8 @@ CONFIG_MFD_AS3722=y
 CONFIG_MFD_ATMEL_FLEXCOM=y
 CONFIG_MFD_BCM590XX=y
 CONFIG_MFD_AXP20X=y
+CONFIG_MFD_AXP20X_I2C=m
+CONFIG_MFD_AXP20X_RSB=m
 CONFIG_MFD_CROS_EC=y
 CONFIG_MFD_CROS_EC_I2C=m
 CONFIG_MFD_CROS_EC_SPI=y
@@ -417,7 +421,7 @@ CONFIG_REGULATOR_AB8500=y
 CONFIG_REGULATOR_ACT8865=y
 CONFIG_REGULATOR_AS3711=y
 CONFIG_REGULATOR_AS3722=y
-CONFIG_REGULATOR_AXP20X=y
+CONFIG_REGULATOR_AXP20X=m
 CONFIG_REGULATOR_BCM590XX=y
 CONFIG_REGULATOR_DA9210=y
 CONFIG_REGULATOR_FAN53555=y
-- 
2.6.2
