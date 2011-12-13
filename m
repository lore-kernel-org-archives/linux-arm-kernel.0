From: eric@eukrea.com (=?UTF-8?q?Eric=20B=C3=A9nard?=)
Date: Tue, 13 Dec 2011 07:31:39 +0100
Subject: [PATCH 07/19] imx_v4_v5_defconfig: update default configuration
In-Reply-To: <1323757911-25217-1-git-send-email-eric@eukrea.com>
References: <1323757911-25217-1-git-send-email-eric@eukrea.com>
Message-ID: <1323757911-25217-7-git-send-email-eric@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

- add new machine APF9328
- update CPUIMX25 -> CPUIMX25SD
- add drivers :
	- MXC nand driver
	- DM9000
	- SMSC Phy
	- SPIdev
	- Led GPIO

Signed-off-by: Eric B?nard <eric@eukrea.com>
Cc: Sascha Hauer <kernel@pengutronix.de>
---
 arch/arm/configs/imx_v4_v5_defconfig |   12 +++++++-----
 1 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/arm/configs/imx_v4_v5_defconfig b/arch/arm/configs/imx_v4_v5_defconfig
index 11a4192..cf497ce 100644
--- a/arch/arm/configs/imx_v4_v5_defconfig
+++ b/arch/arm/configs/imx_v4_v5_defconfig
@@ -18,9 +18,10 @@ CONFIG_ARCH_MXC=y
 CONFIG_ARCH_IMX_V4_V5=y
 CONFIG_ARCH_MX1ADS=y
 CONFIG_MACH_SCB9328=y
+CONFIG_MACH_APF9328=y
 CONFIG_MACH_MX21ADS=y
 CONFIG_MACH_MX25_3DS=y
-CONFIG_MACH_EUKREA_CPUIMX25=y
+CONFIG_MACH_EUKREA_CPUIMX25SD=y
 CONFIG_MACH_MX27ADS=y
 CONFIG_MACH_PCM038=y
 CONFIG_MACH_CPUIMX27=y
@@ -72,17 +73,16 @@ CONFIG_MTD_CFI_GEOMETRY=y
 CONFIG_MTD_CFI_INTELEXT=y
 CONFIG_MTD_PHYSMAP=y
 CONFIG_MTD_NAND=y
+CONFIG_MTD_NAND_MXC=y
 CONFIG_MTD_UBI=y
 CONFIG_MISC_DEVICES=y
 CONFIG_EEPROM_AT24=y
 CONFIG_EEPROM_AT25=y
 CONFIG_NETDEVICES=y
-CONFIG_NET_ETHERNET=y
-CONFIG_SMC91X=y
 CONFIG_DM9000=y
+CONFIG_SMC91X=y
 CONFIG_SMC911X=y
-# CONFIG_NETDEV_1000 is not set
-# CONFIG_NETDEV_10000 is not set
+CONFIG_SMSC_PHY=y
 # CONFIG_INPUT_MOUSEDEV is not set
 CONFIG_INPUT_EVDEV=y
 # CONFIG_INPUT_KEYBOARD is not set
@@ -100,6 +100,7 @@ CONFIG_I2C_CHARDEV=y
 CONFIG_I2C_IMX=y
 CONFIG_SPI=y
 CONFIG_SPI_IMX=y
+CONFIG_SPI_SPIDEV=y
 CONFIG_W1=y
 CONFIG_W1_MASTER_MXC=y
 CONFIG_W1_SLAVE_THERM=y
@@ -139,6 +140,7 @@ CONFIG_MMC=y
 CONFIG_MMC_MXC=y
 CONFIG_NEW_LEDS=y
 CONFIG_LEDS_CLASS=y
+CONFIG_LEDS_GPIO=y
 CONFIG_LEDS_MC13783=y
 CONFIG_LEDS_TRIGGERS=y
 CONFIG_LEDS_TRIGGER_TIMER=y
-- 
1.7.6.4
