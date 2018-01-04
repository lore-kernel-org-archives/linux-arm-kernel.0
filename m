From: sean.wang@mediatek.com (sean.wang at mediatek.com)
Date: Thu, 4 Jan 2018 17:40:51 +0800
Subject: [PATCH 01/12] dt-bindings: clock: mediatek: add missing required
 #reset-cells
In-Reply-To: <cover.1515057696.git.sean.wang@mediatek.com>
References: <cover.1515057696.git.sean.wang@mediatek.com>
Message-ID: <084288e2520f9bd3ccdb3cf7aeef8ebcae48e6d7.1515057696.git.sean.wang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sean Wang <sean.wang@mediatek.com>

All ethsys, pciesys and ssusbsys internally include reset controller, so
explicitly add back these missing cell definitions to related bindings
and examples.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Cc: Rob Herring <robh@kernel.org>
Cc: Stephen Boyd <sboyd@codeaurora.org>
---
 Documentation/devicetree/bindings/arm/mediatek/mediatek,ethsys.txt   | 2 ++
 Documentation/devicetree/bindings/arm/mediatek/mediatek,pciesys.txt  | 2 ++
 Documentation/devicetree/bindings/arm/mediatek/mediatek,ssusbsys.txt | 2 ++
 3 files changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,ethsys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,ethsys.txt
index 7aa3fa1..8f5335b 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,ethsys.txt
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,ethsys.txt
@@ -9,6 +9,7 @@ Required Properties:
 	- "mediatek,mt2701-ethsys", "syscon"
 	- "mediatek,mt7622-ethsys", "syscon"
 - #clock-cells: Must be 1
+- #reset-cells: Must be 1
 
 The ethsys controller uses the common clk binding from
 Documentation/devicetree/bindings/clock/clock-bindings.txt
@@ -20,4 +21,5 @@ ethsys: clock-controller at 1b000000 {
 	compatible = "mediatek,mt2701-ethsys", "syscon";
 	reg = <0 0x1b000000 0 0x1000>;
 	#clock-cells = <1>;
+	#reset-cells = <1>;
 };
diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,pciesys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,pciesys.txt
index d5d5f12..7fe5dc6 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,pciesys.txt
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,pciesys.txt
@@ -8,6 +8,7 @@ Required Properties:
 - compatible: Should be:
 	- "mediatek,mt7622-pciesys", "syscon"
 - #clock-cells: Must be 1
+- #reset-cells: Must be 1
 
 The PCIESYS controller uses the common clk binding from
 Documentation/devicetree/bindings/clock/clock-bindings.txt
@@ -19,4 +20,5 @@ pciesys: pciesys at 1a100800 {
 	compatible = "mediatek,mt7622-pciesys", "syscon";
 	reg = <0 0x1a100800 0 0x1000>;
 	#clock-cells = <1>;
+	#reset-cells = <1>;
 };
diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,ssusbsys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,ssusbsys.txt
index 00760019..b8184da 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,ssusbsys.txt
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,ssusbsys.txt
@@ -8,6 +8,7 @@ Required Properties:
 - compatible: Should be:
 	- "mediatek,mt7622-ssusbsys", "syscon"
 - #clock-cells: Must be 1
+- #reset-cells: Must be 1
 
 The SSUSBSYS controller uses the common clk binding from
 Documentation/devicetree/bindings/clock/clock-bindings.txt
@@ -19,4 +20,5 @@ ssusbsys: ssusbsys at 1a000000 {
 	compatible = "mediatek,mt7622-ssusbsys", "syscon";
 	reg = <0 0x1a000000 0 0x1000>;
 	#clock-cells = <1>;
+	#reset-cells = <1>;
 };
-- 
2.7.4
