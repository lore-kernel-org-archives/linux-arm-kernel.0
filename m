From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 17 Oct 2016 11:23:49 +0200
Subject: [PATCH] ARM: defconfig: update U8500 defconfig
Message-ID: <1476696229-1964-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some config options like perf events and PM are now implicit,
we have an upstream driver for the AK8974, and we really
want the HRTIMER software triggers from configfs with some
of the sensors.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ARM SoC folks: please apply this wherever your usual batch of
defconfig changes go.
---
 arch/arm/configs/u8500_defconfig | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/arm/configs/u8500_defconfig b/arch/arm/configs/u8500_defconfig
index b7b09189f1c5..e2151a7aaf49 100644
--- a/arch/arm/configs/u8500_defconfig
+++ b/arch/arm/configs/u8500_defconfig
@@ -4,7 +4,6 @@ CONFIG_NO_HZ_IDLE=y
 CONFIG_HIGH_RES_TIMERS=y
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_KALLSYMS_ALL=y
-CONFIG_PERF_EVENTS=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 # CONFIG_BLK_DEV_BSG is not set
@@ -26,7 +25,6 @@ CONFIG_CPU_IDLE=y
 CONFIG_ARM_U8500_CPUIDLE=y
 CONFIG_VFP=y
 CONFIG_NEON=y
-CONFIG_PM=y
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
@@ -108,18 +106,19 @@ CONFIG_DMADEVICES=y
 CONFIG_STE_DMA40=y
 CONFIG_HSEM_U8500=y
 CONFIG_IIO=y
-CONFIG_IIO_BUFFER=y
+CONFIG_IIO_SW_TRIGGER=y
 CONFIG_IIO_ST_ACCEL_3AXIS=y
 CONFIG_IIO_ST_GYRO_3AXIS=y
 CONFIG_BH1780=y
+CONFIG_AK8974=y
 CONFIG_IIO_ST_MAGN_3AXIS=y
+CONFIG_IIO_HRTIMER_TRIGGER=y
 CONFIG_IIO_ST_PRESS=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT2_FS_XATTR=y
 CONFIG_EXT2_FS_POSIX_ACL=y
 CONFIG_EXT2_FS_SECURITY=y
 CONFIG_EXT3_FS=y
-CONFIG_EXT4_FS=y
 CONFIG_VFAT_FS=y
 CONFIG_TMPFS=y
 CONFIG_TMPFS_POSIX_ACL=y
-- 
2.7.4
