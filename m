From: marcel@ziswiler.com (Marcel Ziswiler)
Date: Tue, 10 Jun 2014 00:49:50 +0200
Subject: [PATCH v2 1/3] arm: multi_v7: enable igb, stmpe, lm95245, pwm leds
Message-ID: <1741a33cd88cd5525f3c50c0e0cacc0853a3512a.1402350905.git.marcel@ziswiler.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The NVIDIA Tegra 3 based Apalis T30 module contains an Intel i210 resp.
i211 gigabit Ethernet controller, an STMPE811 ADC/touch controller, PWM
LEDs generically accessible from user space and an LM95245 temperature
sensor chip. The later three can also be found on the Colibri T30
module.

While at it move the NEON entry down to its proper place to have it all
nicely ordered again.

Signed-off-by: Marcel Ziswiler <marcel@ziswiler.com>
---
Changes since v1:
- Forget about spidev for now.

 arch/arm/configs/multi_v7_defconfig |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 19dbddb..b0b996e 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -66,7 +66,6 @@ CONFIG_ARCH_VEXPRESS=y
 CONFIG_ARCH_VEXPRESS_CA9X4=y
 CONFIG_ARCH_WM8850=y
 CONFIG_ARCH_ZYNQ=y
-CONFIG_NEON=y
 CONFIG_TRUSTED_FOUNDATIONS=y
 CONFIG_PCI=y
 CONFIG_PCI_MSI=y
@@ -83,6 +82,7 @@ CONFIG_CPU_FREQ=y
 CONFIG_CPU_FREQ_STAT_DETAILS=y
 CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=y
 CONFIG_CPU_IDLE=y
+CONFIG_NEON=y
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
@@ -134,6 +134,7 @@ CONFIG_NETDEVICES=y
 CONFIG_SUN4I_EMAC=y
 CONFIG_MACB=y
 CONFIG_NET_CALXEDA_XGMAC=y
+CONFIG_IGB=y
 CONFIG_MV643XX_ETH=y
 CONFIG_MVNETA=y
 CONFIG_KS8851=y
@@ -157,6 +158,8 @@ CONFIG_KEYBOARD_TEGRA=y
 CONFIG_KEYBOARD_SPEAR=y
 CONFIG_KEYBOARD_CROS_EC=y
 CONFIG_MOUSE_PS2_ELANTECH=y
+CONFIG_INPUT_TOUCHSCREEN=y
+CONFIG_TOUCHSCREEN_STMPE=y
 CONFIG_INPUT_MISC=y
 CONFIG_INPUT_MPU3050=y
 CONFIG_SERIO_AMBAKMI=y
@@ -222,6 +225,7 @@ CONFIG_POWER_RESET_AS3722=y
 CONFIG_POWER_RESET_GPIO=y
 CONFIG_POWER_RESET_SUN6I=y
 CONFIG_SENSORS_LM90=y
+CONFIG_SENSORS_LM95245=y
 CONFIG_THERMAL=y
 CONFIG_DOVE_THERMAL=y
 CONFIG_ARMADA_THERMAL=y
@@ -233,6 +237,7 @@ CONFIG_MFD_CROS_EC=y
 CONFIG_MFD_CROS_EC_SPI=y
 CONFIG_MFD_MAX8907=y
 CONFIG_MFD_SEC_CORE=y
+CONFIG_MFD_STMPE=y
 CONFIG_MFD_PALMAS=y
 CONFIG_MFD_TPS65090=y
 CONFIG_MFD_TPS6586X=y
@@ -315,6 +320,9 @@ CONFIG_MMC_MVSDIO=y
 CONFIG_MMC_SUNXI=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_EXYNOS=y
+CONFIG_NEW_LEDS=y
+CONFIG_LEDS_CLASS=y
+CONFIG_LEDS_PWM=y
 CONFIG_EDAC=y
 CONFIG_EDAC_MM_EDAC=y
 CONFIG_EDAC_HIGHBANK_MC=y
-- 
1.7.9.5
