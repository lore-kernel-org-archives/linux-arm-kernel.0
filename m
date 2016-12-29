From: b18965@freescale.com (Alison Wang)
Date: Thu, 29 Dec 2016 08:58:22 +0800
Subject: [PATCH] mtd: nand: Update dependency of IFC for LS1021A
Message-ID: <1482973102-47659-1-git-send-email-b18965@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As NAND support for Freescale/NXP IFC controller is available on
LS1021A, the dependency for LS1021A is added.

Signed-off-by: Alison Wang <alison.wang@nxp.com>
---
 drivers/mtd/nand/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/Kconfig b/drivers/mtd/nand/Kconfig
index 353a9dd..85e3860 100644
--- a/drivers/mtd/nand/Kconfig
+++ b/drivers/mtd/nand/Kconfig
@@ -441,7 +441,7 @@ config MTD_NAND_FSL_ELBC
 
 config MTD_NAND_FSL_IFC
 	tristate "NAND support for Freescale IFC controller"
-	depends on FSL_SOC || ARCH_LAYERSCAPE
+	depends on FSL_SOC || ARCH_LAYERSCAPE || SOC_LS1021A
 	select FSL_IFC
 	select MEMORY
 	help
-- 
2.1.0.27.g96db324
