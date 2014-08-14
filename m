From: khilman@linaro.org (Kevin Hilman)
Date: Wed, 13 Aug 2014 17:07:15 -0700
Subject: [PATCH] ARM: shmobile: defconfig: enable initrd and atag dtb compat
Message-ID: <1407974835-11064-1-git-send-email-khilman@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable ATAG_DTB_COMPAT support for passing commandline from bootloader.
Enable initrd support.

Signed-off-by: Kevin Hilman <khilman@linaro.org>
---
With this, I can finally integrate the kzm9d into the board farm because I use
initrafms for the primary rootfs, and set the command-line from u-boot.

Tested on next-20140813

 arch/arm/configs/shmobile_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/shmobile_defconfig b/arch/arm/configs/shmobile_defconfig
index 3b136144cc83..d655f088ac58 100644
--- a/arch/arm/configs/shmobile_defconfig
+++ b/arch/arm/configs/shmobile_defconfig
@@ -3,6 +3,7 @@ CONFIG_NO_HZ=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_LOG_BUF_SHIFT=16
+CONFIG_BLK_DEV_INITRD=y
 CONFIG_CC_OPTIMIZE_FOR_SIZE=y
 CONFIG_SYSCTL_SYSCALL=y
 CONFIG_EMBEDDED=y
@@ -33,6 +34,7 @@ CONFIG_HIGHMEM=y
 CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
 CONFIG_ARM_APPENDED_DTB=y
+CONFIG_ARM_ATAG_DTB_COMPAT=y
 CONFIG_KEXEC=y
 CONFIG_VFP=y
 CONFIG_NEON=y
-- 
1.9.2
