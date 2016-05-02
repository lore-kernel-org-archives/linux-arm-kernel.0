From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon,  2 May 2016 10:43:30 +0200
Subject: [PATCH 2/2] ARM: u8500_defconfig: update sensor config
Message-ID: <1462178610-13698-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Ux500 is using buffered IIO as the sensors support
IRQs. The BH1780 ambient light sensor was added to IIO,
so disable the old misc driver and activate the driver
in IIO.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/configs/u8500_defconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/configs/u8500_defconfig b/arch/arm/configs/u8500_defconfig
index 0ce2aa73c28a..d95796881b89 100644
--- a/arch/arm/configs/u8500_defconfig
+++ b/arch/arm/configs/u8500_defconfig
@@ -45,7 +45,6 @@ CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_SIZE=65536
-CONFIG_SENSORS_BH1780=y
 CONFIG_NETDEVICES=y
 CONFIG_SMSC911X=y
 CONFIG_SMSC_PHY=y
@@ -109,8 +108,10 @@ CONFIG_DMADEVICES=y
 CONFIG_STE_DMA40=y
 CONFIG_HSEM_U8500=y
 CONFIG_IIO=y
+CONFIG_IIO_BUFFER=y
 CONFIG_IIO_ST_ACCEL_3AXIS=y
 CONFIG_IIO_ST_GYRO_3AXIS=y
+CONFIG_BH1780=y
 CONFIG_IIO_ST_MAGN_3AXIS=y
 CONFIG_IIO_ST_PRESS=y
 CONFIG_EXT2_FS=y
-- 
2.4.11
