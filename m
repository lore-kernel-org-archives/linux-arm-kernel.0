From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Fri,  1 Dec 2017 13:07:06 +0100
Subject: [PATCH 1/3] dt-bindings: ARM: Mediatek: Fix ethsys documentation
Message-ID: <20171201120708.30129-1-matthias.bgg@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ethsys registers a reset controller, so we need to specify a
reset cell. This patch fixes the documentation.

Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
---
 Documentation/devicetree/bindings/arm/mediatek/mediatek,ethsys.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,ethsys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,ethsys.txt
index 7aa3fa167668..6cc7840ff37a 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,ethsys.txt
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,ethsys.txt
@@ -20,4 +20,5 @@ ethsys: clock-controller at 1b000000 {
 	compatible = "mediatek,mt2701-ethsys", "syscon";
 	reg = <0 0x1b000000 0 0x1000>;
 	#clock-cells = <1>;
+	#reset-cells = <1>;
 };
-- 
2.12.3
