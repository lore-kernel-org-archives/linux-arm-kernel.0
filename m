From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 19 Jul 2017 17:31:25 +0200
Subject: [PATCH 1/2] mtd: nand: pxa3xx_nand: enable building on mvebu 64-bit
 platforms
In-Reply-To: <20170719153126.16905-1-gregory.clement@free-electrons.com>
References: <20170719153126.16905-1-gregory.clement@free-electrons.com>
Message-ID: <20170719153126.16905-2-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The controller supported by the pxa3xx_nand driver is also available on
the mvebu 64-bit SoCs, such as the Armada 7K and Armada 8K SoCs. This
patch updates the Kconfig dependency to allow building the kernel for
this SoC family too.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 drivers/mtd/nand/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/Kconfig b/drivers/mtd/nand/Kconfig
index dbfa72d61d5a..ca42503e42f7 100644
--- a/drivers/mtd/nand/Kconfig
+++ b/drivers/mtd/nand/Kconfig
@@ -315,7 +315,7 @@ config MTD_NAND_ATMEL
 
 config MTD_NAND_PXA3xx
 	tristate "NAND support on PXA3xx and Armada 370/XP"
-	depends on PXA3xx || ARCH_MMP || PLAT_ORION
+	depends on PXA3xx || ARCH_MMP || PLAT_ORION  || ARCH_MVEBU
 	help
 	  This enables the driver for the NAND flash device found on
 	  PXA3xx processors (NFCv1) and also on Armada 370/XP (NFCv2).
-- 
2.13.2
