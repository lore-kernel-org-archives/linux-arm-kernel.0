From: m.grzeschik@pengutronix.de (Michael Grzeschik)
Date: Thu, 25 Feb 2016 12:23:59 +0100
Subject: [PATCH v2 1/2] ARM: mxs_defconfig: Cleanup mxs_defconfig
Message-ID: <1456399440-3646-1-git-send-email-m.grzeschik@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jan Luebbe <jlu@pengutronix.de>

Regenerate mxs_defconfig by running:
make mxs_defconfig
- Manually disable EXT2_FS and EXT3_FS
make savedefconfig
mv defconfig arch/arm/configs/mxs_defconfig

Signed-off-by: Jan Luebbe <jlu@pengutronix.de>
Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
---
v2: Disabled EXT2_FS and EXT3_FS instead of EXT4_FS

 arch/arm/configs/mxs_defconfig | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/configs/mxs_defconfig b/arch/arm/configs/mxs_defconfig
index b47e7c6..3bd7cad 100644
--- a/arch/arm/configs/mxs_defconfig
+++ b/arch/arm/configs/mxs_defconfig
@@ -141,9 +141,6 @@ CONFIG_IIO=y
 CONFIG_IIO_SYSFS_TRIGGER=y
 CONFIG_PWM=y
 CONFIG_PWM_MXS=y
-CONFIG_EXT2_FS=y
-CONFIG_EXT2_FS_XATTR=y
-CONFIG_EXT3_FS=y
 CONFIG_EXT4_FS=y
 # CONFIG_DNOTIFY is not set
 CONFIG_FSCACHE=m
@@ -178,7 +175,6 @@ CONFIG_PROVE_LOCKING=y
 CONFIG_BLK_DEV_IO_TRACE=y
 CONFIG_STRICT_DEVMEM=y
 CONFIG_DEBUG_USER=y
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
 CONFIG_CRYPTO_DEV_MXS_DCP=y
 CONFIG_CRC_ITU_T=m
 CONFIG_CRC7=m
-- 
2.7.0
