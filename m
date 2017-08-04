From: guochun.mao@mediatek.com (Guochun Mao)
Date: Fri, 4 Aug 2017 16:10:39 +0800
Subject: [PATCH v5 1/1] dt-bindings: mtd: add new compatible strings and
 improve description
In-Reply-To: <1501834239-25581-1-git-send-email-guochun.mao@mediatek.com>
References: <1501834239-25581-1-git-send-email-guochun.mao@mediatek.com>
Message-ID: <1501834239-25581-2-git-send-email-guochun.mao@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add "mediatek,mt2712-nor" and "mediatek,mt7622-nor"
for nor flash node's compatible strings.
Explicate the fallback compatible.

Signed-off-by: Guochun Mao <guochun.mao@mediatek.com>
---
 .../devicetree/bindings/mtd/mtk-quadspi.txt        |   15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/mtd/mtk-quadspi.txt b/Documentation/devicetree/bindings/mtd/mtk-quadspi.txt
index 5ded66a..f97d601 100644
--- a/Documentation/devicetree/bindings/mtd/mtk-quadspi.txt
+++ b/Documentation/devicetree/bindings/mtd/mtk-quadspi.txt
@@ -1,13 +1,16 @@
 * Serial NOR flash controller for MTK MT81xx (and similar)
 
 Required properties:
-- compatible: 	  The possible values are:
-		  "mediatek,mt2701-nor"
-		  "mediatek,mt7623-nor"
+- compatible: 	  For mt8173, compatible should be "mediatek,mt8173-nor",
+		  and it's the fallback compatible for other Soc.
+		  For every other SoC, should contain both the SoC-specific compatible
+		  string and "mediatek,mt8173-nor".
+		  The possible values are:
+		  "mediatek,mt2701-nor", "mediatek,mt8173-nor"
+		  "mediatek,mt2712-nor", "mediatek,mt8173-nor"
+		  "mediatek,mt7622-nor", "mediatek,mt8173-nor"
+		  "mediatek,mt7623-nor", "mediatek,mt8173-nor"
 		  "mediatek,mt8173-nor"
-		  For mt8173, compatible should be "mediatek,mt8173-nor".
-		  For every other SoC, should contain both the SoC-specific compatible string
-		  and "mediatek,mt8173-nor".
 - reg: 		  physical base address and length of the controller's register
 - clocks: 	  the phandle of the clocks needed by the nor controller
 - clock-names: 	  the names of the clocks
-- 
1.7.9.5
