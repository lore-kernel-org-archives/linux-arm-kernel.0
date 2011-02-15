From: prakity@marvell.com (Philip Rakity)
Date: Tue, 15 Feb 2011 13:50:16 -0800
Subject: [PATCH 2/4] arm: V2 configs: update mmp2 defconfig for brownstone
	and SoC Selection
In-Reply-To: <alpine.LFD.2.00.1102141320410.14920@xanadu.home>
References: <04A50A49-CBBC-4E5D-B19E-391B4DF77DF3@marvell.com>
	<alpine.LFD.2.00.1102141320410.14920@xanadu.home>
Message-ID: <E421876B-006C-4D5F-AB17-391464AEB65B@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


V2
==
Use make savedefconfigconfig to produce reduced size defconfig
per suggestion of Nico Pitre.

V1
==
took old mmp2_defconfig --
did make menuconfig
changed to CPU_MMP2
added brownstone as supported board

Signed-off-by: Philip Rakity <prakity@marvell.com>
---
 arch/arm/configs/mmp2_defconfig |    7 ++-----
 1 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/arm/configs/mmp2_defconfig b/arch/arm/configs/mmp2_defconfig
index 47ad3b1..93c03df 100644
--- a/arch/arm/configs/mmp2_defconfig
+++ b/arch/arm/configs/mmp2_defconfig
@@ -1,13 +1,14 @@
 CONFIG_EXPERIMENTAL=y
 CONFIG_SYSVIPC=y
 CONFIG_LOG_BUF_SHIFT=14
-CONFIG_SYSFS_DEPRECATED_V2=y
 CONFIG_SLAB=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 CONFIG_MODULE_FORCE_UNLOAD=y
 # CONFIG_BLK_DEV_BSG is not set
 CONFIG_ARCH_MMP=y
+CONFIG_CPU_MMP2=y
+CONFIG_MACH_BROWNSTONE=y
 CONFIG_MACH_FLINT=y
 CONFIG_MACH_MARVELL_JASPER=y
 CONFIG_HIGH_RES_TIMERS=y
@@ -16,7 +17,6 @@ CONFIG_AEABI=y
 CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
 CONFIG_CMDLINE="root=/dev/nfs rootfstype=nfs nfsroot=192.168.1.100:/nfsroot/ ip=192.168.1.101:192.168.1.100::255.255.255.0::eth0:on console=ttyS2,38400 mem=128M user_debug=255"
-CONFIG_VFP=y
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
@@ -33,7 +33,6 @@ CONFIG_MTD_NAND=y
 CONFIG_MTD_ONENAND=y
 CONFIG_MTD_ONENAND_GENERIC=y
 # CONFIG_BLK_DEV is not set
-# CONFIG_MISC_DEVICES is not set
 CONFIG_NETDEVICES=y
 CONFIG_NET_ETHERNET=y
 CONFIG_SMC91X=y
@@ -58,13 +57,11 @@ CONFIG_BACKLIGHT_LCD_SUPPORT=y
 CONFIG_LCD_CLASS_DEVICE=y
 CONFIG_BACKLIGHT_CLASS_DEVICE=y
 CONFIG_BACKLIGHT_MAX8925=y
-# CONFIG_VGA_CONSOLE is not set
 # CONFIG_HID_SUPPORT is not set
 # CONFIG_USB_SUPPORT is not set
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_MAX8925=y
 # CONFIG_DNOTIFY is not set
-CONFIG_INOTIFY=y
 CONFIG_TMPFS=y
 CONFIG_TMPFS_POSIX_ACL=y
 CONFIG_JFFS2_FS=y
-- 
1.7.0.4
