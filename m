From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 28 May 2013 11:26:12 -0600
Subject: [PATCH] ARM: tegra: rebuild tegra_defconfig
Message-ID: <1369761972-31986-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

This simply rebuilds tegra_defconfig on top of next-20130520. As such, it
should introduce no changes; simply moving entries around due to Kconfig
ordering changes. The apparent exceptions are:

AUTO_ZRELADDR: Selected by ARM multi-platform support.
MTD_CHAR: Removed in Kconfig.

This should make it easier to create future defconfig patches on top of
linux-next, since all the extraneous diffs have been removed. It also
makes it more likely that once 3.12 comes around, this defconfig will
already match what's required there.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/configs/tegra_defconfig |   14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/arch/arm/configs/tegra_defconfig b/arch/arm/configs/tegra_defconfig
index 4dbcd9f..e45fe32 100644
--- a/arch/arm/configs/tegra_defconfig
+++ b/arch/arm/configs/tegra_defconfig
@@ -21,8 +21,8 @@ CONFIG_MODULE_FORCE_UNLOAD=y
 CONFIG_PARTITION_ADVANCED=y
 # CONFIG_IOSCHED_DEADLINE is not set
 # CONFIG_IOSCHED_CFQ is not set
-CONFIG_ARCH_TEGRA=y
 CONFIG_GPIO_PCA953X=y
+CONFIG_ARCH_TEGRA=y
 CONFIG_ARCH_TEGRA_2x_SOC=y
 CONFIG_ARCH_TEGRA_3x_SOC=y
 CONFIG_ARCH_TEGRA_114_SOC=y
@@ -36,7 +36,6 @@ CONFIG_HIGHMEM=y
 CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
 CONFIG_KEXEC=y
-CONFIG_AUTO_ZRELADDR=y
 CONFIG_CPU_FREQ=y
 CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=y
 CONFIG_CPU_IDLE=y
@@ -81,7 +80,6 @@ CONFIG_DEVTMPFS_MOUNT=y
 # CONFIG_FIRMWARE_IN_KERNEL is not set
 CONFIG_CMA=y
 CONFIG_MTD=y
-CONFIG_MTD_CHAR=y
 CONFIG_MTD_M25P80=y
 CONFIG_PROC_DEVICETREE=y
 CONFIG_BLK_DEV_LOOP=y
@@ -105,8 +103,8 @@ CONFIG_BRCMFMAC=m
 CONFIG_RT2X00=y
 CONFIG_RT2800USB=m
 CONFIG_INPUT_EVDEV=y
-CONFIG_KEYBOARD_TEGRA=y
 CONFIG_KEYBOARD_GPIO=y
+CONFIG_KEYBOARD_TEGRA=y
 CONFIG_INPUT_MISC=y
 CONFIG_INPUT_MPU3050=y
 # CONFIG_LEGACY_PTYS is not set
@@ -134,11 +132,11 @@ CONFIG_CHARGER_TPS65090=y
 CONFIG_POWER_RESET=y
 CONFIG_POWER_RESET_GPIO=y
 CONFIG_SENSORS_LM90=y
-CONFIG_MFD_TPS6586X=y
-CONFIG_MFD_TPS65910=y
 CONFIG_MFD_MAX8907=y
-CONFIG_MFD_TPS65090=y
 CONFIG_MFD_PALMAS=y
+CONFIG_MFD_TPS65090=y
+CONFIG_MFD_TPS6586X=y
+CONFIG_MFD_TPS65910=y
 CONFIG_REGULATOR=y
 CONFIG_REGULATOR_FIXED_VOLTAGE=y
 CONFIG_REGULATOR_VIRTUAL_CONSUMER=y
@@ -211,7 +209,6 @@ CONFIG_TEGRA20_APB_DMA=y
 CONFIG_STAGING=y
 CONFIG_SENSORS_ISL29018=y
 CONFIG_SENSORS_ISL29028=y
-CONFIG_AK8975=y
 CONFIG_MFD_NVEC=y
 CONFIG_KEYBOARD_NVEC=y
 CONFIG_SERIO_NVEC_PS2=y
@@ -221,6 +218,7 @@ CONFIG_TEGRA_IOMMU_GART=y
 CONFIG_TEGRA_IOMMU_SMMU=y
 CONFIG_MEMORY=y
 CONFIG_IIO=y
+CONFIG_AK8975=y
 CONFIG_PWM=y
 CONFIG_PWM_TEGRA=y
 CONFIG_EXT2_FS=y
-- 
1.7.10.4
