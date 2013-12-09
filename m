From: w-kwok2@ti.com (WingMan Kwok)
Date: Mon, 9 Dec 2013 17:32:13 -0500
Subject: [PATCH v3 3/3] ARM: keystone: defconfig: enable USB support
In-Reply-To: <1386628333-1849-1-git-send-email-w-kwok2@ti.com>
References: <1386628333-1849-1-git-send-email-w-kwok2@ti.com>
Message-ID: <1386628333-1849-4-git-send-email-w-kwok2@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the USB support (Host mode only) on TI's Keystone platform.
It also enables the support of usb mass storage, FAT and Ext4
filesystems to test rootfs mount over an USB disk.

Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Signed-off-by: WingMan Kwok <w-kwok2@ti.com>
---
 arch/arm/configs/keystone_defconfig |   20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/arch/arm/configs/keystone_defconfig b/arch/arm/configs/keystone_defconfig
index 9943e5d..a018244 100644
--- a/arch/arm/configs/keystone_defconfig
+++ b/arch/arm/configs/keystone_defconfig
@@ -115,6 +115,8 @@ CONFIG_MTD_UBI=y
 CONFIG_PROC_DEVICETREE=y
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_EEPROM_AT24=y
+CONFIG_SCSI=y
+CONFIG_BLK_DEV_SD=y
 CONFIG_NETDEVICES=y
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
@@ -129,10 +131,24 @@ CONFIG_SPI_DAVINCI=y
 CONFIG_SPI_SPIDEV=y
 # CONFIG_HWMON is not set
 CONFIG_WATCHDOG=y
-# CONFIG_USB_SUPPORT is not set
+CONFIG_USB=y
+CONFIG_USB_DEBUG=y
+CONFIG_USB_ANNOUNCE_NEW_DEVICES=y
+CONFIG_USB_MON=y
+CONFIG_USB_XHCI_HCD=y
+CONFIG_USB_STORAGE=y
+CONFIG_USB_DWC3=y
+CONFIG_USB_DWC3_DEBUG=y
+CONFIG_USB_DWC3_VERBOSE=y
+CONFIG_KEYSTONE_USB_PHY=y
 CONFIG_DMADEVICES=y
 CONFIG_COMMON_CLK_DEBUG=y
 CONFIG_MEMORY=y
+CONFIG_EXT4_FS=y
+CONFIG_EXT4_FS_POSIX_ACL=y
+CONFIG_MSDOS_FS=y
+CONFIG_VFAT_FS=y
+CONFIG_NTFS_FS=y
 CONFIG_TMPFS=y
 CONFIG_JFFS2_FS=y
 CONFIG_JFFS2_FS_WBUF_VERIFY=y
@@ -144,6 +160,8 @@ CONFIG_ROOT_NFS=y
 CONFIG_NFSD=y
 CONFIG_NFSD_V3=y
 CONFIG_NFSD_V3_ACL=y
+CONFIG_NLS_CODEPAGE_437=y
+CONFIG_NLS_ISO8859_1=y
 CONFIG_PRINTK_TIME=y
 CONFIG_DEBUG_SHIRQ=y
 CONFIG_DEBUG_INFO=y
-- 
1.7.9.5
