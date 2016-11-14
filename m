From: nsekhar@ti.com (Sekhar Nori)
Date: Mon, 14 Nov 2016 21:31:46 +0530
Subject: [PATCH] ARM: davinci_all_defconfig: add missing options for systemd
Message-ID: <20161114160146.20679-1-nsekhar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some kernel configuration options required for systemd
support are missing in davinci_all_defconfig. Add them.

This is based on recommendations in:

    http://cgit.freedesktop.org/systemd/systemd/tree/README

Options which kernel enables by default (and will thus be removed
upon next savedefconfig update) are not included.

Tested on OMAP-L138 LCDK board with fully up to date armv5
archlinux filesystem.

Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 arch/arm/configs/davinci_all_defconfig | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/configs/davinci_all_defconfig b/arch/arm/configs/davinci_all_defconfig
index b5e978ff177f..bdc62e69807a 100644
--- a/arch/arm/configs/davinci_all_defconfig
+++ b/arch/arm/configs/davinci_all_defconfig
@@ -7,13 +7,13 @@ CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_LOG_BUF_SHIFT=14
 CONFIG_CGROUPS=y
+CONFIG_CHECKPOINT_RESTORE=y
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_EXPERT=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 CONFIG_MODULE_FORCE_UNLOAD=y
 CONFIG_MODVERSIONS=y
-# CONFIG_BLK_DEV_BSG is not set
 CONFIG_PARTITION_ADVANCED=y
 # CONFIG_IOSCHED_DEADLINE is not set
 # CONFIG_IOSCHED_CFQ is not set
@@ -34,6 +34,7 @@ CONFIG_DAVINCI_MUX_WARNINGS=y
 CONFIG_DAVINCI_RESET_CLOCKS=y
 CONFIG_PREEMPT=y
 CONFIG_AEABI=y
+CONFIG_SECCOMP=y
 CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
 CONFIG_ARM_APPENDED_DTB=y
@@ -52,7 +53,6 @@ CONFIG_INET=y
 CONFIG_IP_PNP=y
 CONFIG_IP_PNP_DHCP=y
 CONFIG_NETFILTER=y
-CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
 # CONFIG_FW_LOADER is not set
@@ -189,11 +189,13 @@ CONFIG_MEMORY=y
 CONFIG_TI_AEMIF=m
 CONFIG_EXT2_FS=y
 CONFIG_EXT3_FS=y
+CONFIG_EXT4_FS_POSIX_ACL=y
 CONFIG_XFS_FS=m
 CONFIG_AUTOFS4_FS=m
 CONFIG_MSDOS_FS=y
 CONFIG_VFAT_FS=y
 CONFIG_TMPFS=y
+CONFIG_TMPFS_XATTR=y
 CONFIG_JFFS2_FS=m
 CONFIG_UBIFS_FS=m
 CONFIG_CRAMFS=y
-- 
2.9.0
