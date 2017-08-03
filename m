From: chunfeng.yun@mediatek.com (Chunfeng Yun)
Date: Thu, 3 Aug 2017 18:01:03 +0800
Subject: [PATCH 4/4] dt-bindings: phy-mt65xx-usb: supports PCIe,
 SATA and rename file
In-Reply-To: <72854b92d5d86698e5cbb427b1009e346eb15978.1501753328.git.chunfeng.yun@mediatek.com>
References: <72854b92d5d86698e5cbb427b1009e346eb15978.1501753328.git.chunfeng.yun@mediatek.com>
Message-ID: <b6d9a64f328356fb726845a7c7903683eb496c01.1501753328.git.chunfeng.yun@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

add support for PCIe and SATA, also add some new compatibles.

due to phy-mt65xx-usb.txt holds the bindings for all mediatek SoCs
with T-PHY controller, change the name to phy-mtk-tphy.txt to
reflect that.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 .../phy/{phy-mt65xx-usb.txt => phy-mtk-tphy.txt}   |   17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)
 rename Documentation/devicetree/bindings/phy/{phy-mt65xx-usb.txt => phy-mtk-tphy.txt} (88%)

diff --git a/Documentation/devicetree/bindings/phy/phy-mt65xx-usb.txt b/Documentation/devicetree/bindings/phy/phy-mtk-tphy.txt
similarity index 88%
rename from Documentation/devicetree/bindings/phy/phy-mt65xx-usb.txt
rename to Documentation/devicetree/bindings/phy/phy-mtk-tphy.txt
index 0acc5a9..faf1808 100644
--- a/Documentation/devicetree/bindings/phy/phy-mt65xx-usb.txt
+++ b/Documentation/devicetree/bindings/phy/phy-mtk-tphy.txt
@@ -1,13 +1,18 @@
-mt65xx USB3.0 PHY binding
+MediaTek T-PHY binding
 --------------------------
 
-This binding describes a usb3.0 phy for mt65xx platforms of Medaitek SoC.
+T-phy controller supports physical layer functionality for a number of
+controllers on MediaTek SoCs, such as, USB2.0, USB3.0, PCIe, and SATA.
 
 Required properties (controller (parent) node):
  - compatible	: should be one of
-		  "mediatek,mt2701-u3phy"
-		  "mediatek,mt2712-u3phy"
-		  "mediatek,mt8173-u3phy"
+		  "mediatek,generic-tphy-v1"
+		  "mediatek,generic-tphy-v2"
+		  "mediatek,mt2701-u3phy" (deprecated)
+		  "mediatek,mt2712-u3phy" (deprecated)
+		  "mediatek,mt8173-u3phy";
+		  make use of "mediatek,generic-tphy-v1" on mt2701 instead and
+		  "mediatek,generic-tphy-v2" on mt2712 instead.
  - clocks	: (deprecated, use port's clocks instead) a list of phandle +
 		  clock-specifier pairs, one for each entry in clock-names
  - clock-names	: (deprecated, use port's one instead) must contain
@@ -35,6 +40,8 @@ Required properties (port (child) node):
 		  cell after port phandle is phy type from:
 			- PHY_TYPE_USB2
 			- PHY_TYPE_USB3
+			- PHY_TYPE_PCIE
+			- PHY_TYPE_SATA
 
 Example:
 
-- 
1.7.9.5
