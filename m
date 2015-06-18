From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 18 Jun 2015 14:38:41 +0200
Subject: [PATCH 3/3] ARM: mvebu: update mvebu_v7_defconfig with features
 needed for Armada 388 GP
In-Reply-To: <1434631121-32014-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1434631121-32014-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1434631121-32014-4-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Armada 388 GP board has the following hardware features that were
not enabled in mvebu_v7_defconfig:

 * An AT24 I2C EEPROM (also used by armada-xp-lenovo-ix4-300d)
 * A PCA9555 I2C GPIO expander
 * Several fixed regulators

Therefore, this commit adds the necessary options to mvebu_v7_defconfig.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/configs/mvebu_v7_defconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/configs/mvebu_v7_defconfig b/arch/arm/configs/mvebu_v7_defconfig
index cacc9f4..13fcd02 100644
--- a/arch/arm/configs/mvebu_v7_defconfig
+++ b/arch/arm/configs/mvebu_v7_defconfig
@@ -58,6 +58,7 @@ CONFIG_MTD_M25P80=y
 CONFIG_MTD_NAND=y
 CONFIG_MTD_NAND_PXA3xx=y
 CONFIG_MTD_SPI_NOR=y
+CONFIG_EEPROM_AT24=y
 CONFIG_BLK_DEV_SD=y
 CONFIG_ATA=y
 CONFIG_AHCI_MVEBU=y
@@ -83,11 +84,14 @@ CONFIG_I2C_MV64XXX=y
 CONFIG_SPI=y
 CONFIG_SPI_ORION=y
 CONFIG_GPIO_SYSFS=y
+CONFIG_GPIO_PCA953X=y
 CONFIG_SENSORS_GPIO_FAN=y
 CONFIG_THERMAL=y
 CONFIG_ARMADA_THERMAL=y
 CONFIG_WATCHDOG=y
 CONFIG_ORION_WATCHDOG=y
+CONFIG_REGULATOR=y
+CONFIG_REGULATOR_FIXED_VOLTAGE=y
 CONFIG_SOUND=y
 CONFIG_SND=y
 CONFIG_SND_SOC=y
-- 
2.1.0
