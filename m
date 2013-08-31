From: fathi.boudra@linaro.org (Fathi Boudra)
Date: Sat, 31 Aug 2013 15:57:31 +0300
Subject: [PATCH 1/1] ARM: vexpress_defconfig update
Message-ID: <1377953851-15738-1-git-send-email-fathi.boudra@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update cmdline to contain "console=ttyAMA0" only
Enable devtmpfs filesystem
Enable voltage regulator support
Enable ext4 filesystem

Signed-off-by: Fathi Boudra <fathi.boudra@linaro.org>
---
 arch/arm/configs/vexpress_defconfig | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm/configs/vexpress_defconfig b/arch/arm/configs/vexpress_defconfig
index f2de51f..8ddd187 100644
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
-- 
1.8.1.2
