From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Mon, 27 Sep 2010 15:50:44 +0200
Subject: [PATCH 08/40] ARM: mx51_defconfig: add new boards MACH_MX51_3DS and
	MACH_EUKREA_CPUIMX51
In-Reply-To: <20100927135009.GC6271@pengutronix.de>
References: <20100927135009.GC6271@pengutronix.de>
Message-ID: <1285595476-10025-8-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Further remove FIXED_PHY as it breaks the ethernet.
VGA_CONSOLE isn't selectable anymore since fb78b51cb11e.
EXT3_DEFAULTS_TO_ORDERED defaults to y since aa32a796389b.
INOTIFY is gone since 2dfc1cae4c42.
CONFIG_DETECT_SOFTLOCKUP is gone since e16bb1d7fe07.
Enable TMPFS for udev.
KEYS is selected by NFS_USE_KERNEL_DNS

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/configs/mx51_defconfig |    9 +++------
 1 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/arm/configs/mx51_defconfig b/arch/arm/configs/mx51_defconfig
index a665ecb..163cfee 100644
--- a/arch/arm/configs/mx51_defconfig
+++ b/arch/arm/configs/mx51_defconfig
@@ -15,6 +15,8 @@ CONFIG_MODULE_SRCVERSION_ALL=y
 CONFIG_ARCH_MXC=y
 CONFIG_ARCH_MX5=y
 CONFIG_MACH_MX51_BABBAGE=y
+CONFIG_MACH_MX51_3DS=y
+CONFIG_MACH_EUKREA_CPUIMX51=y
 CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
 CONFIG_PREEMPT_VOLUNTARY=y
@@ -69,7 +71,6 @@ CONFIG_REALTEK_PHY=y
 CONFIG_NATIONAL_PHY=y
 CONFIG_STE10XP=y
 CONFIG_LSI_ET1011C_PHY=y
-CONFIG_FIXED_PHY=y
 CONFIG_MDIO_BITBANG=y
 CONFIG_MDIO_GPIO=y
 CONFIG_NET_ETHERNET=y
@@ -100,7 +101,6 @@ CONFIG_I2C_ALGOPCF=m
 CONFIG_I2C_ALGOPCA=m
 CONFIG_GPIO_SYSFS=y
 # CONFIG_HWMON is not set
-# CONFIG_VGA_CONSOLE is not set
 # CONFIG_HID_SUPPORT is not set
 CONFIG_USB=y
 CONFIG_USB_EHCI_HCD=y
@@ -117,13 +117,11 @@ CONFIG_EXT2_FS_XATTR=y
 CONFIG_EXT2_FS_POSIX_ACL=y
 CONFIG_EXT2_FS_SECURITY=y
 CONFIG_EXT3_FS=y
-CONFIG_EXT3_DEFAULTS_TO_ORDERED=y
 CONFIG_EXT3_FS_POSIX_ACL=y
 CONFIG_EXT3_FS_SECURITY=y
 CONFIG_EXT4_FS=y
 CONFIG_EXT4_FS_POSIX_ACL=y
 CONFIG_EXT4_FS_SECURITY=y
-CONFIG_INOTIFY=y
 CONFIG_QUOTA=y
 CONFIG_QUOTA_NETLINK_INTERFACE=y
 # CONFIG_PRINT_QUOTA_WARNING is not set
@@ -136,6 +134,7 @@ CONFIG_ZISOFS=y
 CONFIG_UDF_FS=m
 CONFIG_MSDOS_FS=m
 CONFIG_VFAT_FS=y
+CONFIG_TMPFS=y
 CONFIG_CONFIGFS_FS=m
 CONFIG_NFS_FS=y
 CONFIG_NFS_V3=y
@@ -151,7 +150,6 @@ CONFIG_NLS_UTF8=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_FS=y
 CONFIG_DEBUG_KERNEL=y
-# CONFIG_DETECT_SOFTLOCKUP is not set
 # CONFIG_SCHED_DEBUG is not set
 # CONFIG_DEBUG_BUGVERBOSE is not set
 # CONFIG_RCU_CPU_STALL_DETECTOR is not set
@@ -159,7 +157,6 @@ CONFIG_DEBUG_KERNEL=y
 # CONFIG_ARM_UNWIND is not set
 CONFIG_DEBUG_LL=y
 CONFIG_EARLY_PRINTK=y
-CONFIG_KEYS=y
 CONFIG_SECURITYFS=y
 CONFIG_CRYPTO_DEFLATE=y
 CONFIG_CRYPTO_LZO=y
-- 
1.7.2.3
