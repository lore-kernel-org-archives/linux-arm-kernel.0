From: frieder.schrempf@exceet.de (Frieder Schrempf)
Date: Wed, 30 May 2018 15:14:36 +0200
Subject: [PATCH 07/11] ARM: defconfig: Use the new FSL QSPI driver under the
 SPI framework
In-Reply-To: <1527686082-15142-1-git-send-email-frieder.schrempf@exceet.de>
References: <1527686082-15142-1-git-send-email-frieder.schrempf@exceet.de>
Message-ID: <1527686082-15142-8-git-send-email-frieder.schrempf@exceet.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The new driver at spi/spi-fsl-qspi.c replaces the old SPI NOR driver
at mtd/fsl-quadspi.c. Switch to the new driver in the defconfigs.

Signed-off-by: Frieder Schrempf <frieder.schrempf@exceet.de>
---
 arch/arm/configs/imx_v6_v7_defconfig | 2 +-
 arch/arm/configs/multi_v7_defconfig  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index f70507a..d07a535 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -111,7 +111,6 @@ CONFIG_MTD_NAND_GPMI_NAND=y
 CONFIG_MTD_NAND_VF610_NFC=y
 CONFIG_MTD_NAND_MXC=y
 CONFIG_MTD_SPI_NOR=y
-CONFIG_SPI_FSL_QUADSPI=y
 CONFIG_MTD_UBI=y
 CONFIG_MTD_UBI_FASTMAP=y
 CONFIG_MTD_UBI_BLOCK=y
@@ -199,6 +198,7 @@ CONFIG_I2C_ALGOPCA=m
 CONFIG_I2C_GPIO=y
 CONFIG_I2C_IMX=y
 CONFIG_SPI=y
+CONFIG_SPI_FSL_QSPI=y
 CONFIG_SPI_GPIO=y
 CONFIG_SPI_IMX=y
 CONFIG_SPI_FSL_DSPI=y
diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 7b2283a..1423ec3 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -191,7 +191,6 @@ CONFIG_MTD_NAND_BRCMNAND=y
 CONFIG_MTD_NAND_VF610_NFC=y
 CONFIG_MTD_NAND_DAVINCI=y
 CONFIG_MTD_SPI_NOR=y
-CONFIG_SPI_FSL_QUADSPI=m
 CONFIG_MTD_UBI=y
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_RAM=y
@@ -379,6 +378,7 @@ CONFIG_SPI_BCM2835=y
 CONFIG_SPI_BCM2835AUX=y
 CONFIG_SPI_CADENCE=y
 CONFIG_SPI_DAVINCI=y
+CONFIG_SPI_FSL_QSPI=m
 CONFIG_SPI_GPIO=m
 CONFIG_SPI_FSL_DSPI=m
 CONFIG_SPI_OMAP24XX=y
-- 
2.7.4
