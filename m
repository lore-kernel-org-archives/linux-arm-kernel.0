From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Tue, 06 Dec 2016 13:38:46 +0100
Subject: [RFC PATCH 11/23] arm: update mainstone_defconfig
In-Reply-To: <1481027938-31831-1-git-send-email-b.zolnierkie@samsung.com>
References: <1481027938-31831-1-git-send-email-b.zolnierkie@samsung.com>
Message-ID: <1481027938-31831-12-git-send-email-b.zolnierkie@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update mainstone_defconfig against kernel v4.9-rc6.

The changes were obtained by doing:

	$ make mainstone_defconfig
	$ make savedefconfig
	$ diff -u arch/arm/mainstone_defconfig defconfig

Cc: Daniel Mack <daniel@zonque.org>
Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
Cc: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: Cyril Bur <cyrilbur@gmail.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 arch/arm/configs/mainstone_defconfig | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/arch/arm/configs/mainstone_defconfig b/arch/arm/configs/mainstone_defconfig
index 04efa1b3e..73ac07d 100644
--- a/arch/arm/configs/mainstone_defconfig
+++ b/arch/arm/configs/mainstone_defconfig
@@ -1,12 +1,9 @@
-CONFIG_EXPERIMENTAL=y
 CONFIG_SYSVIPC=y
 CONFIG_LOG_BUF_SHIFT=14
 CONFIG_MODULES=y
 CONFIG_ARCH_PXA=y
 CONFIG_MACH_MAINSTONE=y
 # CONFIG_ARM_THUMB is not set
-CONFIG_LEDS=y
-CONFIG_LEDS_CPU=y
 CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
 CONFIG_CMDLINE="root=/dev/nfs ip=bootp console=ttyS0,115200 mem=64M"
@@ -18,9 +15,7 @@ CONFIG_IP_PNP=y
 CONFIG_IP_PNP_BOOTP=y
 # CONFIG_IPV6 is not set
 CONFIG_MTD=y
-CONFIG_MTD_PARTITIONS=y
 CONFIG_MTD_REDBOOT_PARTS=y
-CONFIG_MTD_CHAR=y
 CONFIG_MTD_BLOCK=y
 CONFIG_MTD_CFI=y
 CONFIG_MTD_CFI_ADV_OPTIONS=y
@@ -29,7 +24,6 @@ CONFIG_MTD_CFI_GEOMETRY=y
 CONFIG_MTD_CFI_INTELEXT=y
 CONFIG_IDE=y
 CONFIG_NETDEVICES=y
-CONFIG_NET_ETHERNET=y
 CONFIG_SMC91X=y
 CONFIG_INPUT_EVDEV=y
 # CONFIG_INPUT_MOUSE is not set
@@ -38,7 +32,6 @@ CONFIG_SERIAL_PXA=y
 CONFIG_SERIAL_PXA_CONSOLE=y
 CONFIG_FB=y
 CONFIG_FB_PXA=y
-# CONFIG_VGA_CONSOLE is not set
 CONFIG_FRAMEBUFFER_CONSOLE=y
 CONFIG_LOGO=y
 CONFIG_EXT2_FS=y
@@ -47,9 +40,8 @@ CONFIG_JFFS2_FS=y
 CONFIG_NFS_FS=y
 CONFIG_ROOT_NFS=y
 CONFIG_NLS_ISO8859_1=y
+CONFIG_DEBUG_INFO=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_KERNEL=y
-CONFIG_DEBUG_INFO=y
 CONFIG_DEBUG_USER=y
-CONFIG_DEBUG_ERRORS=y
 CONFIG_DEBUG_LL=y
-- 
1.9.1
