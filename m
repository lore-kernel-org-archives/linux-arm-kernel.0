From: pawel.moll@arm.com (Pawel Moll)
Date: Wed, 16 Oct 2013 14:36:33 +0100
Subject: [PATCH 1/2] ARM: vexpress: Make defconfig work again
In-Reply-To: <1381930594-1701-1-git-send-email-pawel.moll@arm.com>
References: <1381930594-1701-1-git-send-email-pawel.moll@arm.com>
Message-ID: <1381930594-1701-2-git-send-email-pawel.moll@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fathi Boudra <fathi.boudra@linaro.org>

This patch updates the Versatile Express defconfig to a level
which makes it possible to run a defconfig-ed kernel work
on the board and in QEMU with modern userspace. It does:

- update cmdline to contain "console=ttyAMA0" only
- enable devtmpfs filesystem
- enable voltage regulator support
- enable ext4 filesystem
- disable low level debug and early printk

Signed-off-by: Fathi Boudra <fathi.boudra@linaro.org>
[PM: removed DEBUG_LL - it doesn't work on qemu]
[PM: reworded the commit message]
Signed-off-by: Pawel Moll <pawel.moll@arm.com>
---
 arch/arm/configs/vexpress_defconfig | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm/configs/vexpress_defconfig b/arch/arm/configs/vexpress_defconfig
index f2de51f..6d20bc1 100644
--- a/arch/arm/configs/vexpress_defconfig
+++ b/arch/arm/configs/vexpress_defconfig
@@ -30,7 +30,7 @@ CONFIG_HOTPLUG_CPU=y
 CONFIG_AEABI=y
 CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
-CONFIG_CMDLINE="root=/dev/nfs nfsroot=10.1.69.3:/work/nfsroot ip=dhcp console=ttyAMA0 mem=128M"
+CONFIG_CMDLINE="console=ttyAMA0"
 CONFIG_VFP=y
 CONFIG_NEON=y
 # CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
@@ -45,6 +45,7 @@ CONFIG_IP_PNP_BOOTP=y
 # CONFIG_IPV6 is not set
 # CONFIG_WIRELESS is not set
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
+CONFIG_DEVTMPFS=y
 CONFIG_MTD=y
 CONFIG_MTD_CONCAT=y
 CONFIG_MTD_PARTITIONS=y
@@ -75,6 +76,7 @@ CONFIG_SERIAL_AMBA_PL011_CONSOLE=y
 CONFIG_LEGACY_PTY_COUNT=16
 # CONFIG_HW_RANDOM is not set
 # CONFIG_HWMON is not set
+CONFIG_REGULATOR=y
 CONFIG_FB=y
 CONFIG_FB_ARMCLCD=y
 CONFIG_FRAMEBUFFER_CONSOLE=y
@@ -115,6 +117,7 @@ CONFIG_EXT2_FS=y
 CONFIG_EXT3_FS=y
 # CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
 # CONFIG_EXT3_FS_XATTR is not set
+CONFIG_EXT4_FS=y
 CONFIG_VFAT_FS=y
 CONFIG_TMPFS=y
 CONFIG_JFFS2_FS=y
@@ -134,7 +137,5 @@ CONFIG_DEBUG_INFO=y
 # CONFIG_RCU_CPU_STALL_DETECTOR is not set
 CONFIG_DEBUG_USER=y
 CONFIG_DEBUG_ERRORS=y
-CONFIG_DEBUG_LL=y
-CONFIG_EARLY_PRINTK=y
 # CONFIG_CRYPTO_ANSI_CPRNG is not set
 # CONFIG_CRYPTO_HW is not set
-- 
1.8.1.2
