From: miquel.raynal@free-electrons.com (Miquel Raynal)
Date: Tue,  9 Jan 2018 11:36:34 +0100
Subject: [PATCH v3 4/7] mtd: nand: use reworked NAND controller driver with
 Marvell EBU SoCs
In-Reply-To: <20180109103637.23798-1-miquel.raynal@free-electrons.com>
References: <20180109103637.23798-1-miquel.raynal@free-electrons.com>
Message-ID: <20180109103637.23798-5-miquel.raynal@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Choose to compile and embed marvell_nand.c as NAND controller driver
instead of the legacy pxa3xx_nand.c for platforms with Marvell EBU
SoCs.

Signed-off-by: Miquel Raynal <miquel.raynal@free-electrons.com>
---
 arch/arm/configs/mvebu_v7_defconfig | 2 +-
 arch/arm64/configs/defconfig        | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/configs/mvebu_v7_defconfig b/arch/arm/configs/mvebu_v7_defconfig
index 69553704f2dc..4b6e4fd47e5d 100644
--- a/arch/arm/configs/mvebu_v7_defconfig
+++ b/arch/arm/configs/mvebu_v7_defconfig
@@ -57,7 +57,7 @@ CONFIG_MTD_CFI_STAA=y
 CONFIG_MTD_PHYSMAP_OF=y
 CONFIG_MTD_M25P80=y
 CONFIG_MTD_NAND=y
-CONFIG_MTD_NAND_PXA3xx=y
+CONFIG_MTD_NAND_MARVELL=y
 CONFIG_MTD_SPI_NOR=y
 CONFIG_SRAM=y
 CONFIG_MTD_UBI=y
diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 6356c6da34ea..b20fa9b31efe 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -161,7 +161,7 @@ CONFIG_MTD_BLOCK=y
 CONFIG_MTD_M25P80=y
 CONFIG_MTD_NAND=y
 CONFIG_MTD_NAND_DENALI_DT=y
-CONFIG_MTD_NAND_PXA3xx=y
+CONFIG_MTD_NAND_MARVELL=y
 CONFIG_MTD_SPI_NOR=y
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_NBD=m
-- 
2.11.0
