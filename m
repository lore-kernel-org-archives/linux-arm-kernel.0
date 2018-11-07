From: frieder.schrempf@kontron.de (Frieder Schrempf)
Date: Wed,  7 Nov 2018 15:43:23 +0100
Subject: [PATCH v4 06/10] ARM: defconfig: Use the new FSL QSPI driver under
 the SPI framework
In-Reply-To: <1541601809-16950-1-git-send-email-frieder.schrempf@kontron.de>
References: <1541601809-16950-1-git-send-email-frieder.schrempf@kontron.de>
Message-ID: <1541601809-16950-7-git-send-email-frieder.schrempf@kontron.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Frieder Schrempf <frieder.schrempf@exceet.de>

The new driver at spi/spi-fsl-qspi.c replaces the old SPI NOR driver
at mtd/fsl-quadspi.c. Switch to the new driver in the defconfigs.

Signed-off-by: Frieder Schrempf <frieder.schrempf@exceet.de>
---
 arch/arm/configs/imx_v6_v7_defconfig | 2 +-
 arch/arm/configs/multi_v7_defconfig  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index 1ad5736..1741d87 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -113,7 +113,6 @@ CONFIG_MTD_NAND_GPMI_NAND=y
 CONFIG_MTD_NAND_VF610_NFC=y
 CONFIG_MTD_NAND_MXC=y
 CONFIG_MTD_SPI_NOR=y
-CONFIG_SPI_FSL_QUADSPI=y
 CONFIG_MTD_UBI=y
 CONFIG_MTD_UBI_FASTMAP=y
 CONFIG_MTD_UBI_BLOCK=y
@@ -204,6 +203,7 @@ CONFIG_I2C_ALGOPCA=m
 CONFIG_I2C_GPIO=y
 CONFIG_I2C_IMX=y
 CONFIG_SPI=y
+CONFIG_SPI_FSL_QSPI=y
 CONFIG_SPI_GPIO=y
 CONFIG_SPI_IMX=y
 CONFIG_SPI_FSL_DSPI=y
diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 1c76168..faddf29 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -193,7 +193,6 @@ CONFIG_MTD_NAND_BRCMNAND=y
 CONFIG_MTD_NAND_VF610_NFC=y
 CONFIG_MTD_NAND_DAVINCI=y
 CONFIG_MTD_SPI_NOR=y
-CONFIG_SPI_FSL_QUADSPI=m
 CONFIG_MTD_UBI=y
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_RAM=y
@@ -383,6 +382,7 @@ CONFIG_SPI_BCM2835=y
 CONFIG_SPI_BCM2835AUX=y
 CONFIG_SPI_CADENCE=y
 CONFIG_SPI_DAVINCI=y
+CONFIG_SPI_FSL_QSPI=m
 CONFIG_SPI_GPIO=m
 CONFIG_SPI_FSL_DSPI=m
 CONFIG_SPI_OMAP24XX=y
-- 
2.7.4
