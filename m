From: marcel.ziswiler@toradex.com (Marcel Ziswiler)
Date: Fri, 28 Aug 2015 23:08:15 +0200
Subject: [PATCH v2] arm: tegra: update default configuration
Message-ID: <1440796095-26962-1-git-send-email-marcel.ziswiler@toradex.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

  * Expose hardware/virtual IRQ mapping via debugfs
  * WM9712 audio/touch controller as found on Colibri T20
  * sysfs interface for GPIOs
  * NFS client support for NFS version 4

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
---

Changes in v2:
- drop WM9712 battery support as that driver still requires platform
  data rather than a device tree as pointed out by Mark

 arch/arm/configs/tegra_defconfig | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/configs/tegra_defconfig b/arch/arm/configs/tegra_defconfig
index 9808581..9114bfe 100644
--- a/arch/arm/configs/tegra_defconfig
+++ b/arch/arm/configs/tegra_defconfig
@@ -1,5 +1,6 @@
 CONFIG_SYSVIPC=y
 CONFIG_FHANDLE=y
+CONFIG_IRQ_DOMAIN_DEBUG=y
 CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
 CONFIG_IKCONFIG=y
@@ -121,6 +122,9 @@ CONFIG_KEYBOARD_CROS_EC=y
 CONFIG_MOUSE_PS2_ELANTECH=y
 CONFIG_INPUT_TOUCHSCREEN=y
 CONFIG_TOUCHSCREEN_ATMEL_MXT=y
+CONFIG_TOUCHSCREEN_WM97XX=y
+# CONFIG_TOUCHSCREEN_WM9705 is not set
+# CONFIG_TOUCHSCREEN_WM9713 is not set
 CONFIG_TOUCHSCREEN_STMPE=y
 CONFIG_INPUT_MISC=y
 CONFIG_INPUT_MPU3050=y
@@ -142,6 +146,7 @@ CONFIG_SPI_TEGRA20_SFLASH=y
 CONFIG_SPI_TEGRA20_SLINK=y
 CONFIG_PINCTRL_AS3722=y
 CONFIG_PINCTRL_PALMAS=y
+CONFIG_GPIO_SYSFS=y
 CONFIG_GPIO_PCA953X=y
 CONFIG_GPIO_PCA953X_IRQ=y
 CONFIG_GPIO_PALMAS=y
@@ -208,6 +213,7 @@ CONFIG_SND_SOC_TEGRA=y
 CONFIG_SND_SOC_TEGRA_RT5640=y
 CONFIG_SND_SOC_TEGRA_WM8753=y
 CONFIG_SND_SOC_TEGRA_WM8903=y
+CONFIG_SND_SOC_TEGRA_WM9712=y
 CONFIG_SND_SOC_TEGRA_TRIMSLICE=y
 CONFIG_SND_SOC_TEGRA_ALC5632=y
 CONFIG_SND_SOC_TEGRA_MAX98090=y
@@ -278,6 +284,7 @@ CONFIG_SQUASHFS=y
 CONFIG_SQUASHFS_LZO=y
 CONFIG_SQUASHFS_XZ=y
 CONFIG_NFS_FS=y
+CONFIG_NFS_V4=y
 CONFIG_ROOT_NFS=y
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ISO8859_1=y
-- 
2.4.3
