From: b18965@freescale.com (Alison Wang)
Date: Mon, 13 Feb 2017 14:46:55 +0800
Subject: [PATCH v3 1/2] mtd: ifc: Update dependency of IFC for LS1021A
Message-ID: <1486968416-13536-1-git-send-email-b18965@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As Freescale/NXP IFC controller is available on LS1021A, the dependency
for LS1021A is added.

LS1021A is an earlier product and is not compatible with later
LayerScape architecture. So ARCH_LAYERSCAPE can't cover LS1021A.

Signed-off-by: Alison Wang <alison.wang@nxp.com>
---
Changes in v3:
- Update the commit message.

Changes in v2:
- New patch

 drivers/memory/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/memory/Kconfig b/drivers/memory/Kconfig
index ec80e35..fff8345 100644
--- a/drivers/memory/Kconfig
+++ b/drivers/memory/Kconfig
@@ -115,7 +115,7 @@ config FSL_CORENET_CF
 
 config FSL_IFC
 	bool
-	depends on FSL_SOC || ARCH_LAYERSCAPE
+	depends on FSL_SOC || ARCH_LAYERSCAPE || SOC_LS1021A
 
 config JZ4780_NEMC
 	bool "Ingenic JZ4780 SoC NEMC driver"
-- 
2.1.0.27.g96db324
