From: olof@lixom.net (Olof Johansson)
Date: Mon,  7 Mar 2011 02:26:39 -0600
Subject: [PATCH 3/3] ARM: tegra: enable new drivers in defconfig
In-Reply-To: <1299486399-21761-1-git-send-email-olof@lixom.net>
References: <1299486399-21761-1-git-send-email-olof@lixom.net>
Message-ID: <1299486399-21761-4-git-send-email-olof@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable new platforms and tegra drivers in tegra_defconfig. Also enable
some of the common devices several platforms, and GUID partition tables
to make it possible to boot a tegra_defconfig kernel with a ChromiumOS
filesystem.

Signed-off-by: Olof Johansson <olof@lixom.net>
---
 arch/arm/configs/tegra_defconfig |   16 +++++++++++++++-
 1 files changed, 15 insertions(+), 1 deletions(-)

diff --git a/arch/arm/configs/tegra_defconfig b/arch/arm/configs/tegra_defconfig
index 7a9267e..766e7e8 100644
--- a/arch/arm/configs/tegra_defconfig
+++ b/arch/arm/configs/tegra_defconfig
@@ -21,6 +21,9 @@ CONFIG_MODULE_FORCE_UNLOAD=y
 # CONFIG_IOSCHED_CFQ is not set
 CONFIG_ARCH_TEGRA=y
 CONFIG_MACH_HARMONY=y
+CONFIG_MACH_KAEN=y
+CONFIG_MACH_TRIMSLICE=y
+CONFIG_MACH_WARIO=y
 CONFIG_TEGRA_DEBUG_UARTD=y
 CONFIG_ARM_ERRATA_742230=y
 CONFIG_NO_HZ=y
@@ -78,12 +81,21 @@ CONFIG_SERIAL_8250_CONSOLE=y
 # CONFIG_LEGACY_PTYS is not set
 # CONFIG_HW_RANDOM is not set
 CONFIG_I2C=y
-# CONFIG_HWMON is not set
+# CONFIG_I2C_COMPAT is not set
+# CONFIG_I2C_HELPER_AUTO is not set
+CONFIG_I2C_TEGRA=y
+CONFIG_SENSORS_LM90=y
 # CONFIG_MFD_SUPPORT is not set
 # CONFIG_USB_SUPPORT is not set
 CONFIG_MMC=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_PLTFM=y
+CONFIG_MMC_SDHCI_TEGRA=y
+CONFIG_STAGING=y
+# CONFIG_STAGING_EXCLUDE_BUILD is not set
+CONFIG_IIO=y
+CONFIG_SENSORS_ISL29018=y
+CONFIG_SENSORS_AK8975=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT2_FS_XATTR=y
 CONFIG_EXT2_FS_POSIX_ACL=y
@@ -95,6 +107,8 @@ CONFIG_EXT3_FS_SECURITY=y
 # CONFIG_DNOTIFY is not set
 CONFIG_VFAT_FS=y
 CONFIG_TMPFS=y
+CONFIG_PARTITION_ADVANCED=y
+CONFIG_EFI_PARTITION=y
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ISO8859_1=y
 CONFIG_PRINTK_TIME=y
-- 
1.7.0.4
