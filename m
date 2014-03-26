From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Wed, 26 Mar 2014 14:19:07 +0100
Subject: [PATCH] ARM: ux500: u8500_defconfig: Enable PARTITION_ADVANCED
Message-ID: <1395839947-2534-1-git-send-email-ulf.hansson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are both (e)MMC/SD-card support in ux500, thus it's reasonable to
support partitions for block devices as default.

While updating the defconfig, we rebase it towards Kconfig changes.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 arch/arm/configs/u8500_defconfig |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/configs/u8500_defconfig b/arch/arm/configs/u8500_defconfig
index 65f7788..1ee8da3 100644
--- a/arch/arm/configs/u8500_defconfig
+++ b/arch/arm/configs/u8500_defconfig
@@ -7,6 +7,7 @@ CONFIG_KALLSYMS_ALL=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 # CONFIG_BLK_DEV_BSG is not set
+CONFIG_PARTITION_ADVANCED=y
 CONFIG_ARCH_U8500=y
 CONFIG_MACH_HREFV60=y
 CONFIG_MACH_SNOWBALL=y
@@ -37,6 +38,8 @@ CONFIG_PHONET=y
 # CONFIG_WIRELESS is not set
 CONFIG_CAIF=y
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
+CONFIG_DEVTMPFS=y
+CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_SIZE=65536
 CONFIG_SENSORS_BH1780=y
@@ -110,8 +113,6 @@ CONFIG_EXT2_FS_SECURITY=y
 CONFIG_EXT3_FS=y
 CONFIG_EXT4_FS=y
 CONFIG_VFAT_FS=y
-CONFIG_DEVTMPFS=y
-CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_TMPFS=y
 CONFIG_TMPFS_POSIX_ACL=y
 # CONFIG_MISC_FILESYSTEMS is not set
-- 
1.7.9.5
