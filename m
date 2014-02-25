From: galak@codeaurora.org (Kumar Gala)
Date: Tue, 25 Feb 2014 14:34:05 -0600
Subject: [PATCH] ARM: qcom: Enable basic support for Qualcomm platforms in
 multi_v7_defconfig
Message-ID: <1393360445-16923-1-git-send-email-galak@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable support for the MSM8x60, MSM8960, and MSM8974 SoCs, clocks and
serial console as part of the standard multi_v7_defconfig.

Signed-off-by: Kumar Gala <galak@codeaurora.org>
---

I leave this to the arm-soc guys to apply because of possible conflicts
with other updates to multi_v7_defconfig.

- k

 arch/arm/configs/multi_v7_defconfig | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 56549f1..145bf97 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -9,8 +9,6 @@ CONFIG_MODULE_UNLOAD=y
 CONFIG_PARTITION_ADVANCED=y
 CONFIG_ARCH_MVEBU=y
 CONFIG_MACH_ARMADA_370=y
-CONFIG_MACH_ARMADA_375=y
-CONFIG_MACH_ARMADA_38X=y
 CONFIG_MACH_ARMADA_XP=y
 CONFIG_ARCH_BCM=y
 CONFIG_ARCH_BCM_MOBILE=y
@@ -31,8 +29,12 @@ CONFIG_ARCH_OMAP3=y
 CONFIG_ARCH_OMAP4=y
 CONFIG_SOC_OMAP5=y
 CONFIG_SOC_AM33XX=y
-CONFIG_SOC_DRA7XX=y
 CONFIG_SOC_AM43XX=y
+CONFIG_SOC_DRA7XX=y
+CONFIG_ARCH_QCOM=y
+CONFIG_ARCH_MSM8X60=y
+CONFIG_ARCH_MSM8960=y
+CONFIG_ARCH_MSM8974=y
 CONFIG_ARCH_ROCKCHIP=y
 CONFIG_ARCH_SOCFPGA=y
 CONFIG_PLAT_SPEAR=y
@@ -148,6 +150,8 @@ CONFIG_SERIAL_SIRFSOC_CONSOLE=y
 CONFIG_SERIAL_TEGRA=y
 CONFIG_SERIAL_IMX=y
 CONFIG_SERIAL_IMX_CONSOLE=y
+CONFIG_SERIAL_MSM=y
+CONFIG_SERIAL_MSM_CONSOLE=y
 CONFIG_SERIAL_VT8500=y
 CONFIG_SERIAL_VT8500_CONSOLE=y
 CONFIG_SERIAL_OF_PLATFORM=y
@@ -160,7 +164,6 @@ CONFIG_SERIAL_FSL_LPUART_CONSOLE=y
 CONFIG_SERIAL_ST_ASC=y
 CONFIG_SERIAL_ST_ASC_CONSOLE=y
 CONFIG_I2C_CHARDEV=y
-CONFIG_I2C_MUX=y
 CONFIG_I2C_MUX_PINCTRL=y
 CONFIG_I2C_DESIGNWARE_PLATFORM=y
 CONFIG_I2C_MV64XXX=y
@@ -191,7 +194,6 @@ CONFIG_SENSORS_LM90=y
 CONFIG_THERMAL=y
 CONFIG_ARMADA_THERMAL=y
 CONFIG_WATCHDOG=y
-CONFIG_ORION_WATCHDOG=y
 CONFIG_MFD_AS3722=y
 CONFIG_MFD_CROS_EC=y
 CONFIG_MFD_CROS_EC_SPI=y
@@ -298,6 +300,10 @@ CONFIG_MFD_NVEC=y
 CONFIG_KEYBOARD_NVEC=y
 CONFIG_SERIO_NVEC_PS2=y
 CONFIG_NVEC_POWER=y
+CONFIG_COMMON_CLK_QCOM=y
+CONFIG_MSM_GCC_8660=y
+CONFIG_MSM_MMCC_8960=y
+CONFIG_MSM_MMCC_8974=y
 CONFIG_TEGRA_IOMMU_GART=y
 CONFIG_TEGRA_IOMMU_SMMU=y
 CONFIG_MEMORY=y
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
