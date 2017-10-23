From: weiyi.lu@mediatek.com (Weiyi Lu)
Date: Mon, 23 Oct 2017 12:10:32 +0800
Subject: [PATCH v6 1/9] dt-bindings: ARM: Mediatek: Document bindings for
 MT2712
In-Reply-To: <1508731840-4231-1-git-send-email-weiyi.lu@mediatek.com>
References: <1508731840-4231-1-git-send-email-weiyi.lu@mediatek.com>
Message-ID: <1508731840-4231-2-git-send-email-weiyi.lu@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the binding documentation for apmixedsys, bdpsys,
imgsys, imgsys, infracfg, mcucfg, mfgcfg, mmsys, pericfg, topckgen,
vdecsys and vencsys for Mediatek MT2712.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
---
 .../bindings/arm/mediatek/mediatek,apmixedsys.txt  |  1 +
 .../bindings/arm/mediatek/mediatek,bdpsys.txt      |  1 +
 .../bindings/arm/mediatek/mediatek,imgsys.txt      |  1 +
 .../bindings/arm/mediatek/mediatek,infracfg.txt    |  1 +
 .../bindings/arm/mediatek/mediatek,jpgdecsys.txt   | 22 ++++++++++++++++++++++
 .../bindings/arm/mediatek/mediatek,mcucfg.txt      | 22 ++++++++++++++++++++++
 .../bindings/arm/mediatek/mediatek,mfgcfg.txt      | 22 ++++++++++++++++++++++
 .../bindings/arm/mediatek/mediatek,mmsys.txt       |  1 +
 .../bindings/arm/mediatek/mediatek,pericfg.txt     |  1 +
 .../bindings/arm/mediatek/mediatek,topckgen.txt    |  1 +
 .../bindings/arm/mediatek/mediatek,vdecsys.txt     |  1 +
 .../bindings/arm/mediatek/mediatek,vencsys.txt     |  1 +
 12 files changed, 75 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,jpgdecsys.txt
 create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,mcucfg.txt
 create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,mfgcfg.txt

diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,apmixedsys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,apmixedsys.txt
index cd977db..19fc116 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,apmixedsys.txt
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,apmixedsys.txt
@@ -7,6 +7,7 @@ Required Properties:
 
 - compatible: Should be one of:
 	- "mediatek,mt2701-apmixedsys"
+	- "mediatek,mt2712-apmixedsys", "syscon"
 	- "mediatek,mt6797-apmixedsys"
 	- "mediatek,mt8135-apmixedsys"
 	- "mediatek,mt8173-apmixedsys"
diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,bdpsys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,bdpsys.txt
index 4137196..4010e37 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,bdpsys.txt
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,bdpsys.txt
@@ -7,6 +7,7 @@ Required Properties:
 
 - compatible: Should be:
 	- "mediatek,mt2701-bdpsys", "syscon"
+	- "mediatek,mt2712-bdpsys", "syscon"
 - #clock-cells: Must be 1
 
 The bdpsys controller uses the common clk binding from
diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,imgsys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,imgsys.txt
index 047b11a..868bd51 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,imgsys.txt
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,imgsys.txt
@@ -7,6 +7,7 @@ Required Properties:
 
 - compatible: Should be one of:
 	- "mediatek,mt2701-imgsys", "syscon"
+	- "mediatek,mt2712-imgsys", "syscon"
 	- "mediatek,mt6797-imgsys", "syscon"
 	- "mediatek,mt8173-imgsys", "syscon"
 - #clock-cells: Must be 1
diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,infracfg.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,infracfg.txt
index 58d58e2..a3430cd 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,infracfg.txt
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,infracfg.txt
@@ -8,6 +8,7 @@ Required Properties:
 
 - compatible: Should be one of:
 	- "mediatek,mt2701-infracfg", "syscon"
+	- "mediatek,mt2712-infracfg", "syscon"
 	- "mediatek,mt6797-infracfg", "syscon"
 	- "mediatek,mt8135-infracfg", "syscon"
 	- "mediatek,mt8173-infracfg", "syscon"
diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,jpgdecsys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,jpgdecsys.txt
new file mode 100644
index 0000000..2df799c
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,jpgdecsys.txt
@@ -0,0 +1,22 @@
+Mediatek jpgdecsys controller
+============================
+
+The Mediatek jpgdecsys controller provides various clocks to the system.
+
+Required Properties:
+
+- compatible: Should be:
+	- "mediatek,mt2712-jpgdecsys", "syscon"
+- #clock-cells: Must be 1
+
+The jpgdecsys controller uses the common clk binding from
+Documentation/devicetree/bindings/clock/clock-bindings.txt
+The available clocks are defined in dt-bindings/clock/mt*-clk.h.
+
+Example:
+
+jpgdecsys: syscon at 19000000 {
+	compatible = "mediatek,mt2712-jpgdecsys", "syscon";
+	reg = <0 0x19000000 0 0x1000>;
+	#clock-cells = <1>;
+};
diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mcucfg.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mcucfg.txt
new file mode 100644
index 0000000..b8fb03f
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mcucfg.txt
@@ -0,0 +1,22 @@
+Mediatek mcucfg controller
+============================
+
+The Mediatek mcucfg controller provides various clocks to the system.
+
+Required Properties:
+
+- compatible: Should be one of:
+	- "mediatek,mt2712-mcucfg", "syscon"
+- #clock-cells: Must be 1
+
+The mcucfg controller uses the common clk binding from
+Documentation/devicetree/bindings/clock/clock-bindings.txt
+The available clocks are defined in dt-bindings/clock/mt*-clk.h.
+
+Example:
+
+mcucfg: syscon at 10220000 {
+	compatible = "mediatek,mt2712-mcucfg", "syscon";
+	reg = <0 0x10220000 0 0x1000>;
+	#clock-cells = <1>;
+};
diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mfgcfg.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mfgcfg.txt
new file mode 100644
index 0000000..859e67b
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mfgcfg.txt
@@ -0,0 +1,22 @@
+Mediatek mfgcfg controller
+============================
+
+The Mediatek mfgcfg controller provides various clocks to the system.
+
+Required Properties:
+
+- compatible: Should be one of:
+	- "mediatek,mt2712-mfgcfg", "syscon"
+- #clock-cells: Must be 1
+
+The mfgcfg controller uses the common clk binding from
+Documentation/devicetree/bindings/clock/clock-bindings.txt
+The available clocks are defined in dt-bindings/clock/mt*-clk.h.
+
+Example:
+
+mfgcfg: syscon at 13000000 {
+	compatible = "mediatek,mt2712-mfgcfg", "syscon";
+	reg = <0 0x13000000 0 0x1000>;
+	#clock-cells = <1>;
+};
diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.txt
index 70529e0..4eb8bbe 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.txt
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.txt
@@ -7,6 +7,7 @@ Required Properties:
 
 - compatible: Should be one of:
 	- "mediatek,mt2701-mmsys", "syscon"
+	- "mediatek,mt2712-mmsys", "syscon"
 	- "mediatek,mt6797-mmsys", "syscon"
 	- "mediatek,mt8173-mmsys", "syscon"
 - #clock-cells: Must be 1
diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,pericfg.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,pericfg.txt
index e494366..d9f092e 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,pericfg.txt
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,pericfg.txt
@@ -8,6 +8,7 @@ Required Properties:
 
 - compatible: Should be one of:
 	- "mediatek,mt2701-pericfg", "syscon"
+	- "mediatek,mt2712-pericfg", "syscon"
 	- "mediatek,mt8135-pericfg", "syscon"
 	- "mediatek,mt8173-pericfg", "syscon"
 - #clock-cells: Must be 1
diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,topckgen.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,topckgen.txt
index ec93ecb..2024fc9 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,topckgen.txt
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,topckgen.txt
@@ -7,6 +7,7 @@ Required Properties:
 
 - compatible: Should be one of:
 	- "mediatek,mt2701-topckgen"
+	- "mediatek,mt2712-topckgen", "syscon"
 	- "mediatek,mt6797-topckgen"
 	- "mediatek,mt8135-topckgen"
 	- "mediatek,mt8173-topckgen"
diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,vdecsys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,vdecsys.txt
index d150104..ea40d05 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,vdecsys.txt
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,vdecsys.txt
@@ -7,6 +7,7 @@ Required Properties:
 
 - compatible: Should be one of:
 	- "mediatek,mt2701-vdecsys", "syscon"
+	- "mediatek,mt2712-vdecsys", "syscon"
 	- "mediatek,mt6797-vdecsys", "syscon"
 	- "mediatek,mt8173-vdecsys", "syscon"
 - #clock-cells: Must be 1
diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,vencsys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,vencsys.txt
index 8a93be6..8515453 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,vencsys.txt
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,vencsys.txt
@@ -6,6 +6,7 @@ The Mediatek vencsys controller provides various clocks to the system.
 Required Properties:
 
 - compatible: Should be one of:
+	- "mediatek,mt2712-vencsys", "syscon"
 	- "mediatek,mt6797-vencsys", "syscon"
 	- "mediatek,mt8173-vencsys", "syscon"
 - #clock-cells: Must be 1
-- 
1.9.1
