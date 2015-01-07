From: paul@pwsan.com (Paul Walmsley)
Date: Wed, 07 Jan 2015 01:17:39 -0700
Subject: [PATCH 2/2] arm64: defconfig: add some Kconfig entries used by
 Tegra132 Norrin FFD board
In-Reply-To: <20150107081638.14381.42444.stgit@dusk.lan>
References: <20150107081638.14381.42444.stgit@dusk.lan>
Message-ID: <20150107081733.14381.4690.stgit@dusk.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add some Kconfig entries to the ARM64 defconfig for functionality used
by the Tegra132, or Tegra K1 64-bit, SoC on the Norrin FFD board.

Once the required compilation fixes to support ARCH_TEGRA builds on
ARM64 have been merged, a subsequent patch will be sent to remove the
CONFIG_BROKEN dependency and to add a few more Kconfig entries that
have ARCH_TEGRA dependencies.  The objective of this patch is to start
building some of the needed code as early as possible to prevent
regressions and to facilitate testing.

This patch draws on work done by Allen Martin <amartin@nvidia.com> and
Thierry Reding <treding@nvidia.com>.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Paul Walmsley <pwalmsley@nvidia.com>
Cc: Allen Martin <amartin@nvidia.com>
Cc: Thierry Reding <treding@nvidia.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
---
 arch/arm64/configs/defconfig |   52 ++++++++++++++++++++++++++++++++++--------
 1 file changed, 42 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 5376d908eabe..8de319d23802 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -55,9 +55,10 @@ CONFIG_IP_PNP_BOOTP=y
 # CONFIG_INET_LRO is not set
 # CONFIG_IPV6 is not set
 CONFIG_BPF_JIT=y
-# CONFIG_WIRELESS is not set
+CONFIG_CFG80211=y
 CONFIG_NET_9P=y
 CONFIG_NET_9P_VIRTIO=y
+CONFIG_TEGRA_AHB=y
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
@@ -79,8 +80,10 @@ CONFIG_VIRTIO_NET=y
 CONFIG_NET_XGENE=y
 CONFIG_SMC91X=y
 CONFIG_SMSC911X=y
-# CONFIG_WLAN is not set
+CONFIG_MWIFIEX=y
+CONFIG_MWIFIEX_SDIO=y
 CONFIG_INPUT_EVDEV=y
+CONFIG_KEYBOARD_CROS_EC=y
 # CONFIG_SERIO_SERPORT is not set
 CONFIG_SERIO_AMBAKMI=y
 CONFIG_LEGACY_PTY_COUNT=16
@@ -91,21 +94,46 @@ CONFIG_SERIAL_AMBA_PL011_CONSOLE=y
 CONFIG_SERIAL_OF_PLATFORM=y
 CONFIG_VIRTIO_CONSOLE=y
 # CONFIG_HW_RANDOM is not set
+CONFIG_TCG_TPM=y
+CONFIG_TCG_TIS_I2C_INFINEON=y
+# CONFIG_I2C_COMPAT is not set
+CONFIG_I2C_CHARDEV=y
+# CONFIG_I2C_HELPER_AUTO is not set
 CONFIG_SPI=y
 CONFIG_SPI_PL022=y
+CONFIG_GPIO_SYSFS=y
 CONFIG_GPIO_PL061=y
 CONFIG_GPIO_XGENE=y
-# CONFIG_HWMON is not set
+CONFIG_BATTERY_SBS=y
+CONFIG_CHARGER_GPIO=y
+CONFIG_POWER_RESET_AS3722=y
+CONFIG_SENSORS_LM90=y
+CONFIG_SENSORS_INA2XX=y
+CONFIG_WATCHDOG=y
+CONFIG_WATCHDOG_CORE=y
+CONFIG_WATCHDOG_NOWAYOUT=y
+CONFIG_MFD_AS3722=y
+CONFIG_MFD_CROS_EC=y
+CONFIG_MFD_CROS_EC_I2C=y
+CONFIG_MFD_CROS_EC_SPI=y
 CONFIG_REGULATOR=y
 CONFIG_REGULATOR_FIXED_VOLTAGE=y
-CONFIG_FB=y
-CONFIG_FB_ARMCLCD=y
-CONFIG_FRAMEBUFFER_CONSOLE=y
-CONFIG_LOGO=y
-# CONFIG_LOGO_LINUX_MONO is not set
-# CONFIG_LOGO_LINUX_VGA16 is not set
+CONFIG_REGULATOR_VIRTUAL_CONSUMER=y
+CONFIG_REGULATOR_USERSPACE_CONSUMER=y
+CONFIG_REGULATOR_AS3722=y
+CONFIG_DRM=y
+CONFIG_DRM_NOUVEAU=y
+# CONFIG_LCD_CLASS_DEVICE is not set
+# CONFIG_BACKLIGHT_GENERIC is not set
+CONFIG_BACKLIGHT_PWM=y
+CONFIG_SOUND=y
+CONFIG_SND=y
+CONFIG_SND_DYNAMIC_MINORS=y
+CONFIG_SND_SOC=y
 CONFIG_USB=y
+CONFIG_USB_XHCI_HCD=y
 CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_EHCI_ROOT_HUB_TT=y
 CONFIG_USB_EHCI_HCD_PLATFORM=y
 CONFIG_USB_ISP1760_HCD=y
 CONFIG_USB_OHCI_HCD=y
@@ -113,16 +141,20 @@ CONFIG_USB_OHCI_HCD_PLATFORM=y
 CONFIG_USB_STORAGE=y
 CONFIG_USB_ULPI=y
 CONFIG_MMC=y
+CONFIG_MMC_BLOCK_MINORS=16
 CONFIG_MMC_ARMMMCI=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_PLTFM=y
 CONFIG_MMC_SPI=y
 CONFIG_RTC_CLASS=y
+CONFIG_RTC_DRV_AS3722=y
 CONFIG_RTC_DRV_EFI=y
 CONFIG_RTC_DRV_XGENE=y
+CONFIG_DMADEVICES=y
 CONFIG_VIRTIO_BALLOON=y
 CONFIG_VIRTIO_MMIO=y
-# CONFIG_IOMMU_SUPPORT is not set
+CONFIG_PWM=y
+CONFIG_RESET_CONTROLLER=y
 CONFIG_PHY_XGENE=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT3_FS=y
