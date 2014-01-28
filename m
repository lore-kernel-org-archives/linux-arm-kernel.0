From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 28 Jan 2014 19:27:14 +0000
Subject: [PATCH V3 1/2] ARM: multi_v7_defconfig: update for v3.14-rc1
In-Reply-To: <1390871129-4838-1-git-send-email-jason@lakedaemon.net>
References: <1390871129-4838-1-git-send-email-jason@lakedaemon.net>
Message-ID: <9609875ac4d1bd7d628bd994e0646340d78e423d.1390936638.git.jason@lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Just the output of:

  make ARCH=arm multi_v7_defconfig
  make savedefconfig
  mv defconfig arch/arm/configs/multi_v7_defconfig

Signed-off-by: Jason Cooper <jason@lakedaemon.net>
---
v2 -> v3:
 - rebase onto arm-soc/for-next so arm-soc can apply directly for v3.14-rcX

v1 -> v2:
 - split into two patches, update and +mvebu

 arch/arm/configs/multi_v7_defconfig | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index e2c0734f22da..1f3649d94bbb 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -58,7 +58,6 @@ CONFIG_TRUSTED_FOUNDATIONS=y
 CONFIG_PCI=y
 CONFIG_PCI_MSI=y
 CONFIG_PCI_TEGRA=y
-CONFIG_SMP=y
 CONFIG_HIGHPTE=y
 CONFIG_CMA=y
 CONFIG_ARM_APPENDED_DTB=y
@@ -176,7 +175,6 @@ CONFIG_GPIO_TPS6586X=y
 CONFIG_GPIO_TPS65910=y
 CONFIG_BATTERY_SBS=y
 CONFIG_CHARGER_TPS65090=y
-CONFIG_POWER_RESET_AS3722=y
 CONFIG_POWER_RESET_GPIO=y
 CONFIG_SENSORS_LM90=y
 CONFIG_MFD_AS3722=y
@@ -205,7 +203,6 @@ CONFIG_MEDIA_CAMERA_SUPPORT=y
 CONFIG_MEDIA_USB_SUPPORT=y
 CONFIG_DRM=y
 CONFIG_DRM_TEGRA=y
-CONFIG_DRM_PANEL_SIMPLE=y
 CONFIG_FB_ARMCLCD=y
 CONFIG_FB_WM8505=y
 CONFIG_FB_SIMPLE=y
@@ -222,7 +219,6 @@ CONFIG_SND_SOC_TEGRA_WM8753=y
 CONFIG_SND_SOC_TEGRA_WM8903=y
 CONFIG_SND_SOC_TEGRA_TRIMSLICE=y
 CONFIG_SND_SOC_TEGRA_ALC5632=y
-CONFIG_SND_SOC_TEGRA_MAX98090=y
 CONFIG_USB=y
 CONFIG_USB_XHCI_HCD=y
 CONFIG_USB_EHCI_HCD=y
@@ -249,14 +245,6 @@ CONFIG_MMC_SDHCI_SPEAR=y
 CONFIG_MMC_SDHCI_BCM_KONA=y
 CONFIG_MMC_OMAP=y
 CONFIG_MMC_OMAP_HS=y
-CONFIG_LEDS_GPIO=y
-CONFIG_LEDS_TRIGGER_TIMER=y
-CONFIG_LEDS_TRIGGER_ONESHOT=y
-CONFIG_LEDS_TRIGGER_HEARTBEAT=y
-CONFIG_LEDS_TRIGGER_GPIO=y
-CONFIG_LEDS_TRIGGER_DEFAULT_ON=y
-CONFIG_LEDS_TRIGGER_TRANSIENT=y
-CONFIG_LEDS_TRIGGER_CAMERA=y
 CONFIG_EDAC=y
 CONFIG_EDAC_MM_EDAC=y
 CONFIG_EDAC_HIGHBANK_MC=y
@@ -289,7 +277,6 @@ CONFIG_MFD_NVEC=y
 CONFIG_KEYBOARD_NVEC=y
 CONFIG_SERIO_NVEC_PS2=y
 CONFIG_NVEC_POWER=y
-CONFIG_NVEC_PAZ00=y
 CONFIG_TEGRA_IOMMU_GART=y
 CONFIG_TEGRA_IOMMU_SMMU=y
 CONFIG_MEMORY=y
-- 
1.8.5.3
