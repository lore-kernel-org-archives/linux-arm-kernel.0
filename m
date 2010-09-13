From: vince@kyllikki.org (Vincent Sanders)
Date: Mon, 13 Sep 2010 16:13:46 +0100
Subject: [PATCH 3/9] Remove unused default configuration
In-Reply-To: <1284390832-7181-1-git-send-email-vince@kyllikki.org>
References: <1284390832-7181-1-git-send-email-vince@kyllikki.org>
Message-ID: <1284390832-7181-4-git-send-email-vince@kyllikki.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Vincent Sanders <vince@simtec.co.uk>

The mx51 default configuration has not built throughout the 2.6.36
series (since 2.6.35-git1). The link has failed with

fs/built-in.o: In function `nfs_callback_authenticate':
compr_zlib.c:(.text+0x7c12c): undefined reference to `svc_gss_principal'

In addition this build has several unique warnings

arch/arm/mach-mx5/clock-mx51.c:624: warning: 'ckih_clk' defined but not used
arch/arm/mach-mx5/clock-mx51.c:628: warning: 'ckih2_clk' defined but not used
arch/arm/mach-mx5/clock-mx51.c:747: warning: 'aips_tz2_clk' defined but not used
arch/arm/mach-mx5/clock-mx51.c:756: warning: 'gpt_32k_clk' defined but not used
arch/arm/mach-mx5/clock-mx51.c:792: warning: 'uart1_ipg_clk' defined but not used
arch/arm/mach-mx5/clock-mx51.c:794: warning: 'uart2_ipg_clk' defined but not used
arch/arm/mach-mx5/clock-mx51.c:796: warning: 'uart3_ipg_clk' defined but not used
arch/arm/mach-mx5/clock-mx51.c:802: warning: 'gpt_ipg_clk' defined but not used
arch/arm/mach-mx5/board-mx51_babbage.c: In function 'initialize_otg_port':
arch/arm/mach-mx5/board-mx51_babbage.c:184: warning: assignment makes integer from pointer without a cast
arch/arm/mach-mx5/board-mx51_babbage.c: In function 'initialize_usbh1_port':
arch/arm/mach-mx5/board-mx51_babbage.c:202: warning: assignment makes integer from pointer without a cast
arch/arm/plat-mxc/ehci.c: In function 'mxc_initialize_usb_hw':
arch/arm/plat-mxc/ehci.c:260: warning: assignment makes integer from pointer without a cast
arch/arm/plat-mxc/ehci.c:263: warning: assignment makes integer from pointer without a cast
arch/arm/plat-mxc/ehci.c:270: warning: assignment makes integer from pointer without a cast

This configuration appers to be unused by the maintainer so remove it.

Signed-off-by: Vincent Sanders <vince@kyllikki.org>
---
 arch/arm/configs/mx51_defconfig |  171 ---------------------------------------
 1 files changed, 0 insertions(+), 171 deletions(-)
 delete mode 100644 arch/arm/configs/mx51_defconfig

diff --git a/arch/arm/configs/mx51_defconfig b/arch/arm/configs/mx51_defconfig
deleted file mode 100644
index a665ecb..0000000
--- a/arch/arm/configs/mx51_defconfig
+++ /dev/null
@@ -1,171 +0,0 @@
-CONFIG_EXPERIMENTAL=y
-# CONFIG_LOCALVERSION_AUTO is not set
-CONFIG_SYSVIPC=y
-CONFIG_LOG_BUF_SHIFT=18
-CONFIG_RELAY=y
-CONFIG_EMBEDDED=y
-# CONFIG_SLUB_DEBUG is not set
-# CONFIG_COMPAT_BRK is not set
-CONFIG_MODULES=y
-CONFIG_MODULE_UNLOAD=y
-CONFIG_MODVERSIONS=y
-CONFIG_MODULE_SRCVERSION_ALL=y
-# CONFIG_LBDAF is not set
-# CONFIG_BLK_DEV_BSG is not set
-CONFIG_ARCH_MXC=y
-CONFIG_ARCH_MX5=y
-CONFIG_MACH_MX51_BABBAGE=y
-CONFIG_NO_HZ=y
-CONFIG_HIGH_RES_TIMERS=y
-CONFIG_PREEMPT_VOLUNTARY=y
-CONFIG_AEABI=y
-# CONFIG_OABI_COMPAT is not set
-CONFIG_DEFAULT_MMAP_MIN_ADDR=32768
-CONFIG_CMDLINE="noinitrd console=ttymxc0,115200 root=/dev/nfs nfsroot=192.168.0.101:/shared/nfs ip=dhcp"
-CONFIG_VFP=y
-CONFIG_NEON=y
-CONFIG_BINFMT_MISC=m
-CONFIG_PM=y
-CONFIG_PM_DEBUG=y
-CONFIG_PM_TEST_SUSPEND=y
-CONFIG_NET=y
-CONFIG_PACKET=y
-CONFIG_UNIX=y
-CONFIG_INET=y
-CONFIG_IP_PNP=y
-CONFIG_IP_PNP_DHCP=y
-# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
-# CONFIG_INET_XFRM_MODE_TUNNEL is not set
-# CONFIG_INET_XFRM_MODE_BEET is not set
-# CONFIG_INET_LRO is not set
-# CONFIG_IPV6 is not set
-# CONFIG_WIRELESS is not set
-# CONFIG_STANDALONE is not set
-CONFIG_CONNECTOR=y
-CONFIG_BLK_DEV_LOOP=y
-CONFIG_BLK_DEV_RAM=y
-CONFIG_BLK_DEV_RAM_SIZE=65536
-# CONFIG_MISC_DEVICES is not set
-CONFIG_SCSI=y
-# CONFIG_SCSI_PROC_FS is not set
-CONFIG_BLK_DEV_SD=y
-CONFIG_SCSI_MULTI_LUN=y
-CONFIG_SCSI_CONSTANTS=y
-CONFIG_SCSI_LOGGING=y
-CONFIG_SCSI_SCAN_ASYNC=y
-# CONFIG_SCSI_LOWLEVEL is not set
-CONFIG_ATA=m
-CONFIG_NETDEVICES=y
-CONFIG_MARVELL_PHY=y
-CONFIG_DAVICOM_PHY=y
-CONFIG_QSEMI_PHY=y
-CONFIG_LXT_PHY=y
-CONFIG_CICADA_PHY=y
-CONFIG_VITESSE_PHY=y
-CONFIG_SMSC_PHY=y
-CONFIG_BROADCOM_PHY=y
-CONFIG_ICPLUS_PHY=y
-CONFIG_REALTEK_PHY=y
-CONFIG_NATIONAL_PHY=y
-CONFIG_STE10XP=y
-CONFIG_LSI_ET1011C_PHY=y
-CONFIG_FIXED_PHY=y
-CONFIG_MDIO_BITBANG=y
-CONFIG_MDIO_GPIO=y
-CONFIG_NET_ETHERNET=y
-CONFIG_MII=m
-CONFIG_FEC=y
-# CONFIG_NETDEV_1000 is not set
-# CONFIG_NETDEV_10000 is not set
-# CONFIG_WLAN is not set
-CONFIG_INPUT_FF_MEMLESS=m
-# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
-CONFIG_INPUT_EVDEV=y
-CONFIG_INPUT_EVBUG=m
-CONFIG_MOUSE_PS2=m
-CONFIG_MOUSE_PS2_ELANTECH=y
-CONFIG_SERIO_SERPORT=m
-CONFIG_VT_HW_CONSOLE_BINDING=y
-# CONFIG_DEVKMEM is not set
-CONFIG_SERIAL_IMX=y
-CONFIG_SERIAL_IMX_CONSOLE=y
-# CONFIG_LEGACY_PTYS is not set
-CONFIG_HW_RANDOM=y
-CONFIG_I2C=y
-# CONFIG_I2C_COMPAT is not set
-CONFIG_I2C_CHARDEV=m
-# CONFIG_I2C_HELPER_AUTO is not set
-CONFIG_I2C_ALGOBIT=m
-CONFIG_I2C_ALGOPCF=m
-CONFIG_I2C_ALGOPCA=m
-CONFIG_GPIO_SYSFS=y
-# CONFIG_HWMON is not set
-# CONFIG_VGA_CONSOLE is not set
-# CONFIG_HID_SUPPORT is not set
-CONFIG_USB=y
-CONFIG_USB_EHCI_HCD=y
-CONFIG_USB_EHCI_MXC=y
-CONFIG_MMC=y
-CONFIG_MMC_BLOCK=m
-CONFIG_MMC_SDHCI=m
-CONFIG_NEW_LEDS=y
-CONFIG_LEDS_CLASS=m
-CONFIG_RTC_CLASS=y
-CONFIG_RTC_INTF_DEV_UIE_EMUL=y
-CONFIG_EXT2_FS=y
-CONFIG_EXT2_FS_XATTR=y
-CONFIG_EXT2_FS_POSIX_ACL=y
-CONFIG_EXT2_FS_SECURITY=y
-CONFIG_EXT3_FS=y
-CONFIG_EXT3_DEFAULTS_TO_ORDERED=y
-CONFIG_EXT3_FS_POSIX_ACL=y
-CONFIG_EXT3_FS_SECURITY=y
-CONFIG_EXT4_FS=y
-CONFIG_EXT4_FS_POSIX_ACL=y
-CONFIG_EXT4_FS_SECURITY=y
-CONFIG_INOTIFY=y
-CONFIG_QUOTA=y
-CONFIG_QUOTA_NETLINK_INTERFACE=y
-# CONFIG_PRINT_QUOTA_WARNING is not set
-CONFIG_AUTOFS_FS=y
-CONFIG_AUTOFS4_FS=y
-CONFIG_FUSE_FS=y
-CONFIG_ISO9660_FS=m
-CONFIG_JOLIET=y
-CONFIG_ZISOFS=y
-CONFIG_UDF_FS=m
-CONFIG_MSDOS_FS=m
-CONFIG_VFAT_FS=y
-CONFIG_CONFIGFS_FS=m
-CONFIG_NFS_FS=y
-CONFIG_NFS_V3=y
-CONFIG_NFS_V3_ACL=y
-CONFIG_NFS_V4=y
-CONFIG_ROOT_NFS=y
-CONFIG_NLS_DEFAULT="cp437"
-CONFIG_NLS_CODEPAGE_437=y
-CONFIG_NLS_ASCII=y
-CONFIG_NLS_ISO8859_1=m
-CONFIG_NLS_ISO8859_15=m
-CONFIG_NLS_UTF8=y
-CONFIG_MAGIC_SYSRQ=y
-CONFIG_DEBUG_FS=y
-CONFIG_DEBUG_KERNEL=y
-# CONFIG_DETECT_SOFTLOCKUP is not set
-# CONFIG_SCHED_DEBUG is not set
-# CONFIG_DEBUG_BUGVERBOSE is not set
-# CONFIG_RCU_CPU_STALL_DETECTOR is not set
-# CONFIG_FTRACE is not set
-# CONFIG_ARM_UNWIND is not set
-CONFIG_DEBUG_LL=y
-CONFIG_EARLY_PRINTK=y
-CONFIG_KEYS=y
-CONFIG_SECURITYFS=y
-CONFIG_CRYPTO_DEFLATE=y
-CONFIG_CRYPTO_LZO=y
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
-# CONFIG_CRYPTO_HW is not set
-CONFIG_CRC_CCITT=m
-CONFIG_CRC_T10DIF=y
-CONFIG_CRC7=m
-CONFIG_LIBCRC32C=m
-- 
1.7.0.4
