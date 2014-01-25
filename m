From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 24 Jan 2014 20:13:28 -0700
Subject: [PATCH] ARM: tegra: rebuild tegra_defconfig to add DEBUG_FS
Message-ID: <1390619608-8397-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

DEBUG_FS used to be selected by COMMON_CLK_DEBUG, which was enabled
by tegra_defconfig. However, this config option no longer exists, so
no longer selects DEBUG_FS, and nothing else selects it either. So,
"make tegra_defconfig" no longer enables DEBUG_FS in .config.

Rebuild tegra_defconfig on top of next-20140424, while manually
re-enabling DEBUG_FS.

Reasons for removed entries are:
- I2C_MUX: selected by MEDIA_SUBDRV_AUTOSELECT
- DRM_PANEL: selected by DRM_TEGRA
- NEW_LEDS: selected by many things; at least VT
- LEDS_CLASS: selected by many things; at least VT
- LEDS_TRIGGERS: selected by many things; at least VT
- COMMON_CLK_DEBUG: no longer exists

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/configs/tegra_defconfig | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/arch/arm/configs/tegra_defconfig b/arch/arm/configs/tegra_defconfig
index 5fdc9a0..00fe9e9 100644
--- a/arch/arm/configs/tegra_defconfig
+++ b/arch/arm/configs/tegra_defconfig
@@ -29,11 +29,11 @@ CONFIG_ARCH_TEGRA_3x_SOC=y
 CONFIG_ARCH_TEGRA_114_SOC=y
 CONFIG_ARCH_TEGRA_124_SOC=y
 CONFIG_TEGRA_EMC_SCALING_ENABLE=y
+CONFIG_TRUSTED_FOUNDATIONS=y
 CONFIG_PCI=y
 CONFIG_PCI_MSI=y
 CONFIG_PCI_TEGRA=y
 CONFIG_PCIEPORTBUS=y
-CONFIG_TRUSTED_FOUNDATIONS=y
 CONFIG_SMP=y
 CONFIG_PREEMPT=y
 CONFIG_AEABI=y
@@ -125,7 +125,6 @@ CONFIG_SERIAL_TEGRA=y
 CONFIG_SERIAL_OF_PLATFORM=y
 # CONFIG_HW_RANDOM is not set
 # CONFIG_I2C_COMPAT is not set
-CONFIG_I2C_MUX=y
 CONFIG_I2C_MUX_PINCTRL=y
 CONFIG_I2C_TEGRA=y
 CONFIG_SPI=y
@@ -169,9 +168,8 @@ CONFIG_MEDIA_CAMERA_SUPPORT=y
 CONFIG_MEDIA_USB_SUPPORT=y
 CONFIG_USB_VIDEO_CLASS=m
 CONFIG_DRM=y
-CONFIG_DRM_PANEL=y
-CONFIG_DRM_PANEL_SIMPLE=y
 CONFIG_DRM_TEGRA=y
+CONFIG_DRM_PANEL_SIMPLE=y
 CONFIG_BACKLIGHT_LCD_SUPPORT=y
 # CONFIG_LCD_CLASS_DEVICE is not set
 CONFIG_BACKLIGHT_CLASS_DEVICE=y
@@ -206,10 +204,7 @@ CONFIG_MMC_BLOCK_MINORS=16
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_PLTFM=y
 CONFIG_MMC_SDHCI_TEGRA=y
-CONFIG_NEW_LEDS=y
-CONFIG_LEDS_CLASS=y
 CONFIG_LEDS_GPIO=y
-CONFIG_LEDS_TRIGGERS=y
 CONFIG_LEDS_TRIGGER_TIMER=y
 CONFIG_LEDS_TRIGGER_ONESHOT=y
 CONFIG_LEDS_TRIGGER_HEARTBEAT=y
@@ -235,7 +230,6 @@ CONFIG_KEYBOARD_NVEC=y
 CONFIG_SERIO_NVEC_PS2=y
 CONFIG_NVEC_POWER=y
 CONFIG_NVEC_PAZ00=y
-CONFIG_COMMON_CLK_DEBUG=y
 CONFIG_TEGRA_IOMMU_GART=y
 CONFIG_TEGRA_IOMMU_SMMU=y
 CONFIG_MEMORY=y
@@ -265,6 +259,7 @@ CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ISO8859_1=y
 CONFIG_PRINTK_TIME=y
 CONFIG_DEBUG_INFO=y
+CONFIG_DEBUG_FS=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_SLAB=y
 CONFIG_DEBUG_VM=y
-- 
1.8.3.2
