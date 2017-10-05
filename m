From: sean.wang@mediatek.com (sean.wang at mediatek.com)
Date: Thu, 5 Oct 2017 11:50:22 +0800
Subject: [PATCH v2 1/4] dt-bindings: clock: mediatek: document clk bindings
 for MediaTek MT7622 SoC
In-Reply-To: <cover.1507174799.git.sean.wang@mediatek.com>
References: <cover.1507174799.git.sean.wang@mediatek.com>
Message-ID: <cac2312d51a2a30e066f79214dc0b71acea7732d.1507174799.git.sean.wang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sean Wang <sean.wang@mediatek.com>

This patch adds the binding documentation for apmixedsys, ethsys, hifsys,
infracfg, pericfg, topckgen and audsys for MT7622.

Signed-off-by: Chen Zhong <chen.zhong@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../bindings/arm/mediatek/mediatek,apmixedsys.txt  |  1 +
 .../bindings/arm/mediatek/mediatek,audsys.txt      | 22 ++++++++++++++++++++++
 .../bindings/arm/mediatek/mediatek,ethsys.txt      |  1 +
 .../bindings/arm/mediatek/mediatek,hifsys.txt      |  1 +
 .../bindings/arm/mediatek/mediatek,infracfg.txt    |  1 +
 .../bindings/arm/mediatek/mediatek,pciesys.txt     | 22 ++++++++++++++++++++++
 .../bindings/arm/mediatek/mediatek,pericfg.txt     |  1 +
 .../bindings/arm/mediatek/mediatek,sgmiisys.txt    | 22 ++++++++++++++++++++++
 .../bindings/arm/mediatek/mediatek,ssusbsys.txt    | 22 ++++++++++++++++++++++
 .../bindings/arm/mediatek/mediatek,topckgen.txt    |  1 +
 10 files changed, 94 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,audsys.txt
 create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,pciesys.txt
 create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,sgmiisys.txt
 create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,ssusbsys.txt

diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,apmixedsys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,apmixedsys.txt
index cd977db..84669a58 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,apmixedsys.txt
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,apmixedsys.txt
@@ -8,6 +8,7 @@ Required Properties:
 - compatible: Should be one of:
 	- "mediatek,mt2701-apmixedsys"
 	- "mediatek,mt6797-apmixedsys"
+	- "mediatek,mt7622-apmixedsys"
 	- "mediatek,mt8135-apmixedsys"
 	- "mediatek,mt8173-apmixedsys"
 - #clock-cells: Must be 1
diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,audsys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,audsys.txt
new file mode 100644
index 0000000..9b8f578
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,audsys.txt
@@ -0,0 +1,22 @@
+MediaTek AUDSYS controller
+============================
+
+The MediaTek AUDSYS controller provides various clocks to the system.
+
+Required Properties:
+
+- compatible: Should be one of:
+	- "mediatek,mt7622-audsys", "syscon"
+- #clock-cells: Must be 1
+
+The AUDSYS controller uses the common clk binding from
+Documentation/devicetree/bindings/clock/clock-bindings.txt
+The available clocks are defined in dt-bindings/clock/mt*-clk.h.
+
+Example:
+
+audsys: audsys at 11220000 {
+	compatible = "mediatek,mt7622-audsys", "syscon";
+	reg = <0 0x11220000 0 0x1000>;
+	#clock-cells = <1>;
+};
diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,ethsys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,ethsys.txt
index 768f3a5..7aa3fa1 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,ethsys.txt
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,ethsys.txt
@@ -7,6 +7,7 @@ Required Properties:
 
 - compatible: Should be:
 	- "mediatek,mt2701-ethsys", "syscon"
+	- "mediatek,mt7622-ethsys", "syscon"
 - #clock-cells: Must be 1
 
 The ethsys controller uses the common clk binding from
diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,hifsys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,hifsys.txt
index beed7b5..f5629d6 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,hifsys.txt
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,hifsys.txt
@@ -8,6 +8,7 @@ Required Properties:
 
 - compatible: Should be:
 	- "mediatek,mt2701-hifsys", "syscon"
+	- "mediatek,mt7622-hifsys", "syscon"
 - #clock-cells: Must be 1
 
 The hifsys controller uses the common clk binding from
diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,infracfg.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,infracfg.txt
index 58d58e2..56d85b8 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,infracfg.txt
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,infracfg.txt
@@ -9,6 +9,7 @@ Required Properties:
 - compatible: Should be one of:
 	- "mediatek,mt2701-infracfg", "syscon"
 	- "mediatek,mt6797-infracfg", "syscon"
+	- "mediatek,mt7622-infracfg", "syscon"
 	- "mediatek,mt8135-infracfg", "syscon"
 	- "mediatek,mt8173-infracfg", "syscon"
 - #clock-cells: Must be 1
diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,pciesys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,pciesys.txt
new file mode 100644
index 0000000..d5d5f12
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,pciesys.txt
@@ -0,0 +1,22 @@
+MediaTek PCIESYS controller
+============================
+
+The MediaTek PCIESYS controller provides various clocks to the system.
+
+Required Properties:
+
+- compatible: Should be:
+	- "mediatek,mt7622-pciesys", "syscon"
+- #clock-cells: Must be 1
+
+The PCIESYS controller uses the common clk binding from
+Documentation/devicetree/bindings/clock/clock-bindings.txt
+The available clocks are defined in dt-bindings/clock/mt*-clk.h.
+
+Example:
+
+pciesys: pciesys at 1a100800 {
+	compatible = "mediatek,mt7622-pciesys", "syscon";
+	reg = <0 0x1a100800 0 0x1000>;
+	#clock-cells = <1>;
+};
diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,pericfg.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,pericfg.txt
index e494366..26c395c 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,pericfg.txt
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,pericfg.txt
@@ -8,6 +8,7 @@ Required Properties:
 
 - compatible: Should be one of:
 	- "mediatek,mt2701-pericfg", "syscon"
+	- "mediatek,mt7622-pericfg", "syscon"
 	- "mediatek,mt8135-pericfg", "syscon"
 	- "mediatek,mt8173-pericfg", "syscon"
 - #clock-cells: Must be 1
diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,sgmiisys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,sgmiisys.txt
new file mode 100644
index 0000000..d113b8e
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,sgmiisys.txt
@@ -0,0 +1,22 @@
+MediaTek SGMIISYS controller
+============================
+
+The MediaTek SGMIISYS controller provides various clocks to the system.
+
+Required Properties:
+
+- compatible: Should be:
+	- "mediatek,mt7622-sgmiisys", "syscon"
+- #clock-cells: Must be 1
+
+The SGMIISYS controller uses the common clk binding from
+Documentation/devicetree/bindings/clock/clock-bindings.txt
+The available clocks are defined in dt-bindings/clock/mt*-clk.h.
+
+Example:
+
+sgmiisys: sgmiisys at 1b128000 {
+	compatible = "mediatek,mt7622-sgmiisys", "syscon";
+	reg = <0 0x1b128000 0 0x1000>;
+	#clock-cells = <1>;
+};
diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,ssusbsys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,ssusbsys.txt
new file mode 100644
index 0000000..00760019
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,ssusbsys.txt
@@ -0,0 +1,22 @@
+MediaTek SSUSBSYS controller
+============================
+
+The MediaTek SSUSBSYS controller provides various clocks to the system.
+
+Required Properties:
+
+- compatible: Should be:
+	- "mediatek,mt7622-ssusbsys", "syscon"
+- #clock-cells: Must be 1
+
+The SSUSBSYS controller uses the common clk binding from
+Documentation/devicetree/bindings/clock/clock-bindings.txt
+The available clocks are defined in dt-bindings/clock/mt*-clk.h.
+
+Example:
+
+ssusbsys: ssusbsys at 1a000000 {
+	compatible = "mediatek,mt7622-ssusbsys", "syscon";
+	reg = <0 0x1a000000 0 0x1000>;
+	#clock-cells = <1>;
+};
diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,topckgen.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,topckgen.txt
index ec93ecb..368b18c 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,topckgen.txt
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,topckgen.txt
@@ -8,6 +8,7 @@ Required Properties:
 - compatible: Should be one of:
 	- "mediatek,mt2701-topckgen"
 	- "mediatek,mt6797-topckgen"
+	- "mediatek,mt7622-topckgen"
 	- "mediatek,mt8135-topckgen"
 	- "mediatek,mt8173-topckgen"
 - #clock-cells: Must be 1
-- 
2.7.4
