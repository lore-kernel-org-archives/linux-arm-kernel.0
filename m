From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Tue, 06 Dec 2016 13:38:38 +0100
Subject: [RFC PATCH 03/23] arm: update defconfigs for ARCH_KS8695
In-Reply-To: <1481027938-31831-1-git-send-email-b.zolnierkie@samsung.com>
References: <1481027938-31831-1-git-send-email-b.zolnierkie@samsung.com>
Message-ID: <1481027938-31831-4-git-send-email-b.zolnierkie@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update [acs5k,acs5k_tiny,ks8695]_defconfig-s against kernel v4.9-rc6.

The changes were obtained by doing:

	$ make [acs5k,...]_defconfig
	$ make savedefconfig
	$ diff -u arch/arm/[acs5k,...]_defconfig defconfig

Cc: Greg Ungerer <gerg@uclinux.org>
Cc: Cyril Bur <cyrilbur@gmail.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 arch/arm/configs/acs5k_defconfig      | 12 ------------
 arch/arm/configs/acs5k_tiny_defconfig | 14 --------------
 arch/arm/configs/ks8695_defconfig     | 12 ------------
 3 files changed, 38 deletions(-)

diff --git a/arch/arm/configs/acs5k_defconfig b/arch/arm/configs/acs5k_defconfig
index 92b0f90..8840d2c 100644
--- a/arch/arm/configs/acs5k_defconfig
+++ b/arch/arm/configs/acs5k_defconfig
@@ -1,9 +1,7 @@
-CONFIG_EXPERIMENTAL=y
 # CONFIG_SWAP is not set
 CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
 CONFIG_LOG_BUF_SHIFT=14
-CONFIG_SYSFS_DEPRECATED_V2=y
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_SLAB=y
 CONFIG_MODULES=y
@@ -30,13 +28,9 @@ CONFIG_UNIX=y
 CONFIG_INET=y
 CONFIG_IP_PNP=y
 CONFIG_IP_PNP_DHCP=y
-# CONFIG_INET_LRO is not set
 # CONFIG_IPV6 is not set
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_MTD=y
-CONFIG_MTD_CONCAT=y
-CONFIG_MTD_PARTITIONS=y
-CONFIG_MTD_CHAR=y
 CONFIG_MTD_BLOCK=y
 CONFIG_MTD_CFI=y
 CONFIG_MTD_JEDECPROBE=y
@@ -47,10 +41,7 @@ CONFIG_MTD_PHYSMAP=y
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_SIZE=8192
 CONFIG_NETDEVICES=y
-CONFIG_NET_ETHERNET=y
 CONFIG_ARM_KS8695_ETHER=y
-# CONFIG_NETDEV_1000 is not set
-# CONFIG_NETDEV_10000 is not set
 CONFIG_PRISM54=m
 # CONFIG_INPUT_MOUSEDEV_PSAUX is not set
 # CONFIG_INPUT_KEYBOARD is not set
@@ -65,11 +56,9 @@ CONFIG_GPIO_SYSFS=y
 CONFIG_GPIO_PCA953X=y
 CONFIG_WATCHDOG=y
 CONFIG_KS8695_WATCHDOG=y
-# CONFIG_VGA_CONSOLE is not set
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_PCF8563=y
 CONFIG_EXT2_FS=y
-CONFIG_INOTIFY=y
 CONFIG_TMPFS=y
 CONFIG_JFFS2_FS=y
 CONFIG_JFFS2_SUMMARY=y
@@ -77,7 +66,6 @@ CONFIG_JFFS2_COMPRESSION_OPTIONS=y
 CONFIG_JFFS2_RUBIN=y
 CONFIG_CRAMFS=y
 CONFIG_NFS_FS=y
-CONFIG_NFS_V3=y
 CONFIG_ROOT_NFS=y
 CONFIG_DEBUG_KERNEL=y
 CONFIG_DEBUG_MUTEXES=y
diff --git a/arch/arm/configs/acs5k_tiny_defconfig b/arch/arm/configs/acs5k_tiny_defconfig
index 2a27a14..a8e115c 100644
--- a/arch/arm/configs/acs5k_tiny_defconfig
+++ b/arch/arm/configs/acs5k_tiny_defconfig
@@ -1,9 +1,7 @@
-CONFIG_EXPERIMENTAL=y
 # CONFIG_SWAP is not set
 CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
 CONFIG_LOG_BUF_SHIFT=14
-CONFIG_SYSFS_DEPRECATED_V2=y
 CONFIG_SLAB=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
@@ -17,7 +15,6 @@ CONFIG_AEABI=y
 CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
 CONFIG_CMDLINE="console=ttyAM0,115200 init=/bin/sh"
-CONFIG_FPE_NWFPE=y
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
@@ -25,13 +22,9 @@ CONFIG_INET=y
 # CONFIG_INET_XFRM_MODE_TRANSPORT is not set
 # CONFIG_INET_XFRM_MODE_TUNNEL is not set
 # CONFIG_INET_XFRM_MODE_BEET is not set
-# CONFIG_INET_LRO is not set
 # CONFIG_IPV6 is not set
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_MTD=y
-CONFIG_MTD_CONCAT=y
-CONFIG_MTD_PARTITIONS=y
-CONFIG_MTD_CHAR=y
 CONFIG_MTD_BLOCK=y
 CONFIG_MTD_CFI=y
 CONFIG_MTD_JEDECPROBE=y
@@ -40,12 +33,8 @@ CONFIG_MTD_CFI_INTELEXT=y
 CONFIG_MTD_CFI_AMDSTD=y
 CONFIG_MTD_PHYSMAP=y
 # CONFIG_BLK_DEV is not set
-# CONFIG_MISC_DEVICES is not set
 CONFIG_NETDEVICES=y
-CONFIG_NET_ETHERNET=y
 CONFIG_ARM_KS8695_ETHER=y
-# CONFIG_NETDEV_1000 is not set
-# CONFIG_NETDEV_10000 is not set
 # CONFIG_INPUT_MOUSEDEV_PSAUX is not set
 # CONFIG_INPUT_KEYBOARD is not set
 # CONFIG_INPUT_MOUSE is not set
@@ -61,12 +50,9 @@ CONFIG_GPIO_PCA953X=y
 # CONFIG_HWMON is not set
 CONFIG_WATCHDOG=y
 CONFIG_KS8695_WATCHDOG=y
-# CONFIG_VGA_CONSOLE is not set
-# CONFIG_HID_SUPPORT is not set
 # CONFIG_USB_SUPPORT is not set
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_PCF8563=y
-CONFIG_INOTIFY=y
 CONFIG_TMPFS=y
 CONFIG_JFFS2_FS=y
 CONFIG_JFFS2_SUMMARY=y
diff --git a/arch/arm/configs/ks8695_defconfig b/arch/arm/configs/ks8695_defconfig
index 47c4883..b5ef2b4 100644
--- a/arch/arm/configs/ks8695_defconfig
+++ b/arch/arm/configs/ks8695_defconfig
@@ -1,8 +1,6 @@
-CONFIG_EXPERIMENTAL=y
 # CONFIG_SWAP is not set
 CONFIG_SYSVIPC=y
 CONFIG_LOG_BUF_SHIFT=14
-CONFIG_SYSFS_DEPRECATED_V2=y
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_SLAB=y
 CONFIG_MODULES=y
@@ -28,14 +26,11 @@ CONFIG_UNIX=y
 CONFIG_INET=y
 CONFIG_IP_PNP=y
 CONFIG_IP_PNP_DHCP=y
-# CONFIG_INET_LRO is not set
 # CONFIG_IPV6 is not set
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_MTD=y
-CONFIG_MTD_PARTITIONS=y
 CONFIG_MTD_REDBOOT_PARTS=y
 CONFIG_MTD_CMDLINE_PARTS=y
-CONFIG_MTD_CHAR=y
 CONFIG_MTD_BLOCK=y
 CONFIG_MTD_CFI=y
 CONFIG_MTD_JEDECPROBE=y
@@ -44,10 +39,6 @@ CONFIG_MTD_PHYSMAP=y
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_SIZE=8192
 CONFIG_NETDEVICES=y
-CONFIG_NET_ETHERNET=y
-CONFIG_MII=y
-# CONFIG_NETDEV_1000 is not set
-# CONFIG_NETDEV_10000 is not set
 CONFIG_PRISM54=m
 # CONFIG_INPUT_MOUSEDEV_PSAUX is not set
 # CONFIG_INPUT_KEYBOARD is not set
@@ -56,9 +47,7 @@ CONFIG_PRISM54=m
 CONFIG_SERIAL_KS8695=y
 CONFIG_SERIAL_KS8695_CONSOLE=y
 # CONFIG_HWMON is not set
-# CONFIG_VGA_CONSOLE is not set
 CONFIG_EXT2_FS=y
-CONFIG_INOTIFY=y
 CONFIG_TMPFS=y
 CONFIG_JFFS2_FS=y
 CONFIG_JFFS2_SUMMARY=y
@@ -66,7 +55,6 @@ CONFIG_JFFS2_COMPRESSION_OPTIONS=y
 CONFIG_JFFS2_RUBIN=y
 CONFIG_CRAMFS=y
 CONFIG_NFS_FS=y
-CONFIG_NFS_V3=y
 CONFIG_ROOT_NFS=y
 CONFIG_DEBUG_KERNEL=y
 CONFIG_DEBUG_MUTEXES=y
-- 
1.9.1
