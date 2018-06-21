From: pawel.mikolaj.chmiel@gmail.com (=?UTF-8?q?Pawe=C5=82=20Chmiel?=)
Date: Thu, 21 Jun 2018 21:09:56 +0200
Subject: [PATCH 4/7] ARM: s5pv210_defconfig: Enable drivers for Samsung Aries
 based phones
In-Reply-To: <1529608199-5583-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
References: <1529608199-5583-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
Message-ID: <1529608199-5583-5-git-send-email-pawel.mikolaj.chmiel@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable config options required for Samsung Aries based phones..
While we're here, also enable other useful options like:
- SYSVIPC
- CGROUPS
- DEVTMPFS
- networking support
- ext4 and autofs

Signed-off-by: Pawe? Chmiel <pawel.mikolaj.chmiel@gmail.com>
---
 arch/arm/configs/s5pv210_defconfig | 49 +++++++++++++++++++++++++++++++++++---
 1 file changed, 46 insertions(+), 3 deletions(-)

diff --git a/arch/arm/configs/s5pv210_defconfig b/arch/arm/configs/s5pv210_defconfig
index 09b5a7386414..a077597369f1 100644
--- a/arch/arm/configs/s5pv210_defconfig
+++ b/arch/arm/configs/s5pv210_defconfig
@@ -1,5 +1,7 @@
+CONFIG_SYSVIPC=y
 CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
+CONFIG_CGROUPS=y
 CONFIG_SYSFS_DEPRECATED=y
 CONFIG_SYSFS_DEPRECATED_V2=y
 CONFIG_BLK_DEV_INITRD=y
@@ -13,28 +15,68 @@ CONFIG_SOLARIS_X86_PARTITION=y
 CONFIG_ARCH_S5PV210=y
 CONFIG_VMSPLIT_2G=y
 CONFIG_PREEMPT=y
-CONFIG_AEABI=y
+CONFIG_ARM_APPENDED_DTB=y
 CONFIG_CMDLINE="root=/dev/ram0 rw ramdisk=8192 initrd=0x20800000,8M console=ttySAC1,115200 init=/linuxrc"
 CONFIG_VFP=y
 CONFIG_NEON=y
+CONFIG_NET=y
+CONFIG_PACKET=y
+CONFIG_UNIX=y
+CONFIG_INET=y
+CONFIG_IP_PNP=y
+CONFIG_IP_PNP_DHCP=y
+CONFIG_IP_PNP_BOOTP=y
+CONFIG_IP_PNP_RARP=y
+CONFIG_CFG80211=m
+CONFIG_MAC80211=m
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
+CONFIG_DEVTMPFS=y
+CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_SIZE=8192
 CONFIG_SCSI=y
 CONFIG_BLK_DEV_SD=y
 CONFIG_CHR_DEV_SG=y
+CONFIG_NETDEVICES=y
+CONFIG_BRCMFMAC=m
 CONFIG_INPUT_EVDEV=y
-# CONFIG_INPUT_KEYBOARD is not set
+CONFIG_KEYBOARD_GPIO=y
 # CONFIG_INPUT_MOUSE is not set
 CONFIG_INPUT_TOUCHSCREEN=y
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_SAMSUNG=y
 CONFIG_SERIAL_SAMSUNG_CONSOLE=y
 CONFIG_HW_RANDOM=y
+CONFIG_I2C_GPIO=y
+CONFIG_POWER_SUPPLY=y
+CONFIG_BATTERY_MAX17040=y
 # CONFIG_HWMON is not set
-# CONFIG_USB_SUPPORT is not set
+CONFIG_MFD_MAX8998=y
+CONFIG_REGULATOR=y
+CONFIG_REGULATOR_MAX8998=y
+CONFIG_DRM=y
+CONFIG_DRM_EXYNOS=y
+CONFIG_DRM_EXYNOS_FIMD=y
+CONFIG_DRM_EXYNOS_DPI=y
+CONFIG_USB=y
+CONFIG_USB_OTG=y
+CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_EHCI_EXYNOS=y
+CONFIG_USB_OHCI_HCD=y
+CONFIG_USB_OHCI_EXYNOS=y
+CONFIG_USB_DWC2=y
+CONFIG_MMC=y
+CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_S3C=y
+CONFIG_MMC_SDHCI_S3C_DMA=y
+CONFIG_RTC_CLASS=y
+CONFIG_RTC_DRV_MAX8998=m
+CONFIG_PHY_SAMSUNG_USB2=m
+CONFIG_PHY_S5PV210_USB2=y
 CONFIG_EXT2_FS=y
+CONFIG_EXT4_FS=y
+CONFIG_AUTOFS4_FS=y
 CONFIG_MSDOS_FS=y
 CONFIG_VFAT_FS=y
 CONFIG_TMPFS=y
@@ -44,6 +86,7 @@ CONFIG_ROMFS_FS=y
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ASCII=y
 CONFIG_NLS_ISO8859_1=y
+CONFIG_NLS_UTF8=y
 CONFIG_DEBUG_INFO=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_KERNEL=y
-- 
2.7.4
