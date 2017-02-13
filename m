From: b18965@freescale.com (Alison Wang)
Date: Mon, 13 Feb 2017 14:46:56 +0800
Subject: [PATCH v3 2/2] mtd: nand: Update dependency of IFC for LS1021A
In-Reply-To: <1486968416-13536-1-git-send-email-b18965@freescale.com>
References: <1486968416-13536-1-git-send-email-b18965@freescale.com>
Message-ID: <1486968416-13536-2-git-send-email-b18965@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As NAND support for Freescale/NXP IFC controller is available on
LS1021A, the dependency for LS1021A is added.

LS1021A is an earlier product and is not compatible with later
LayerScape architecture. So ARCH_LAYERSCAPE can't cover LS1021A.

Signed-off-by: Alison Wang <alison.wang@nxp.com>
---
Changes in v3:
- Update the commit message.

Changes in v2:
- None

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
