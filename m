From: mars.cheng@mediatek.com (Mars Cheng)
Date: Tue, 17 Jul 2018 16:52:24 +0800
Subject: [PATCH v5 03/11] dt-bindings: mediatek: add MT6765 power dt-bindings
In-Reply-To: <1531817552-17221-1-git-send-email-mars.cheng@mediatek.com>
References: <1531817552-17221-1-git-send-email-mars.cheng@mediatek.com>
Message-ID: <1531817552-17221-4-git-send-email-mars.cheng@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds power dt-bindings for MT6765

Signed-off-by: Mars Cheng <mars.cheng@mediatek.com>
Signed-off-by: Owen Chen <owen.chen@mediatek.com>
---
 .../devicetree/bindings/soc/mediatek/scpsys.txt    |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/mediatek/scpsys.txt b/Documentation/devicetree/bindings/soc/mediatek/scpsys.txt
index d6fe16f..62a416a 100644
--- a/Documentation/devicetree/bindings/soc/mediatek/scpsys.txt
+++ b/Documentation/devicetree/bindings/soc/mediatek/scpsys.txt
@@ -11,6 +11,7 @@ The driver implements the Generic PM domain bindings described in
 power/power_domain.txt. It provides the power domains defined in
 - include/dt-bindings/power/mt8173-power.h
 - include/dt-bindings/power/mt6797-power.h
+- include/dt-bindings/power/mt6765-power.h
 - include/dt-bindings/power/mt2701-power.h
 - include/dt-bindings/power/mt2712-power.h
 - include/dt-bindings/power/mt7622-power.h
@@ -19,6 +20,7 @@ Required properties:
 - compatible: Should be one of:
 	- "mediatek,mt2701-scpsys"
 	- "mediatek,mt2712-scpsys"
+	- "mediatek,mt6765-scpsys"
 	- "mediatek,mt6797-scpsys"
 	- "mediatek,mt7622-scpsys"
 	- "mediatek,mt7623-scpsys", "mediatek,mt2701-scpsys": For MT7623 SoC
@@ -32,6 +34,10 @@ Required properties:
                       enabled before enabling certain power domains.
 	Required clocks for MT2701 or MT7623: "mm", "mfg", "ethif"
 	Required clocks for MT2712: "mm", "mfg", "venc", "jpgdec", "audio", "vdec"
+	Required clocks for MT6765: MUX: "mm", "mfg"
+				    CG: "mm-0", "mm-1", "mm-2", "mm-3", "isp-0",
+					"isp-1", "cam-0", "cam-1", "cam-2",
+					"cam-3","cam-4"
 	Required clocks for MT6797: "mm", "mfg", "vdec"
 	Required clocks for MT7622: "hif_sel"
 	Required clocks for MT7622A: "ethif"
-- 
1.7.9.5
