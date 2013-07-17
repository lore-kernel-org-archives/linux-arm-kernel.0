From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 17 Jul 2013 18:51:50 +0200
Subject: [PATCH 2/2] ARM: Kirkwood: update defconfig for used i2c devices,
 EXT4 FS, r8169
In-Reply-To: <1374079910-24345-1-git-send-email-andrew@lunn.ch>
References: <1374079910-24345-1-git-send-email-andrew@lunn.ch>
Message-ID: <1374079910-24345-3-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Various kirkwood boards make use of i2c devices. Ensure the defconfig
builds them. Also, EXT4 FS is also common on NAS boxes, so include it
as well. And lastly, NSA310 has a RealTek 8169 onboard.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 arch/arm/configs/kirkwood_defconfig |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/arm/configs/kirkwood_defconfig b/arch/arm/configs/kirkwood_defconfig
index 0f2aa61..4f2bf73 100644
--- a/arch/arm/configs/kirkwood_defconfig
+++ b/arch/arm/configs/kirkwood_defconfig
@@ -92,6 +92,7 @@ CONFIG_MTD_M25P80=y
 CONFIG_MTD_NAND=y
 CONFIG_MTD_NAND_ORION=y
 CONFIG_BLK_DEV_LOOP=y
+CONFIG_EEPROM_AT24=y
 # CONFIG_SCSI_PROC_FS is not set
 CONFIG_BLK_DEV_SD=y
 CONFIG_BLK_DEV_SR=m
@@ -103,6 +104,7 @@ CONFIG_NETDEVICES=y
 CONFIG_MII=y
 CONFIG_NET_DSA_MV88E6123_61_65=y
 CONFIG_MV643XX_ETH=y
+CONFIG_R8169=y
 CONFIG_MARVELL_PHY=y
 CONFIG_LIBERTAS=y
 CONFIG_LIBERTAS_SDIO=y
@@ -123,7 +125,10 @@ CONFIG_I2C_MV64XXX=y
 CONFIG_SPI=y
 CONFIG_SPI_ORION=y
 CONFIG_GPIO_SYSFS=y
-# CONFIG_HWMON is not set
+CONFIG_SENSORS_ADT7475=y
+CONFIG_SENSORS_LM63=y
+CONFIG_SENSORS_LM75=y
+CONFIG_SENSORS_LM85=y
 CONFIG_THERMAL=y
 CONFIG_KIRKWOOD_THERMAL=y
 CONFIG_WATCHDOG=y
@@ -164,6 +169,8 @@ CONFIG_LEDS_TRIGGER_TIMER=y
 CONFIG_LEDS_TRIGGER_HEARTBEAT=y
 CONFIG_LEDS_TRIGGER_DEFAULT_ON=y
 CONFIG_RTC_CLASS=y
+CONFIG_RTC_DRV_RS5C372=y
+CONFIG_RTC_DRV_PCF8563=y
 CONFIG_RTC_DRV_S35390A=y
 CONFIG_RTC_DRV_MV=y
 CONFIG_DMADEVICES=y
@@ -171,6 +178,7 @@ CONFIG_MV_XOR=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT3_FS=y
 # CONFIG_EXT3_FS_XATTR is not set
+CONFIG_EXT4_FS=y
 CONFIG_ISO9660_FS=m
 CONFIG_JOLIET=y
 CONFIG_UDF_FS=m
-- 
1.7.10.4
