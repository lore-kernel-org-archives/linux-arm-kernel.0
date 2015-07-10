From: jamesjj.liao@mediatek.com (James Liao)
Date: Fri, 10 Jul 2015 18:00:02 +0800
Subject: [PATCH v3 2/5] dt-bindings: ARM: Mediatek: Document devicetree
 bindings for clock controllers
In-Reply-To: <1436522405-13923-1-git-send-email-jamesjj.liao@mediatek.com>
References: <1436522405-13923-1-git-send-email-jamesjj.liao@mediatek.com>
Message-ID: <1436522405-13923-3-git-send-email-jamesjj.liao@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the binding documentation for the mmsys, imgsys, vdecsys,
vencsys and vencltsys controllers found on Mediatek SoCs.

Signed-off-by: James Liao <jamesjj.liao@mediatek.com>
---
 .../bindings/arm/mediatek/mediatek,imgsys.txt      | 22 ++++++++++++++++++++++
 .../bindings/arm/mediatek/mediatek,mmsys.txt       | 22 ++++++++++++++++++++++
 .../bindings/arm/mediatek/mediatek,vdecsys.txt     | 22 ++++++++++++++++++++++
 .../bindings/arm/mediatek/mediatek,vencltsys.txt   | 22 ++++++++++++++++++++++
 .../bindings/arm/mediatek/mediatek,vencsys.txt     | 22 ++++++++++++++++++++++
 5 files changed, 110 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,imgsys.txt
 create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.txt
 create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,vdecsys.txt
 create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,vencltsys.txt
 create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,vencsys.txt

diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,imgsys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,imgsys.txt
new file mode 100644
index 0000000..7612bac
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,imgsys.txt
@@ -0,0 +1,22 @@
+Mediatek imgsys controller
+============================
+
+The Mediatek imgsys controller provides various clocks to the system.
+
+Required Properties:
+
+- compatible: Should be:
+	- "mediatek,mt8173-imgsys", "syscon"
+- #clock-cells: Must be 1
+
+The imgsys controller uses the common clk binding from
+Documentation/devicetree/bindings/clock/clock-bindings.txt
+The available clocks are defined in dt-bindings/clock/mt*-clk.h.
+
+Example:
+
+imgsys: imgsys at 15000000 {
+	compatible = "mediatek,mt8173-imgsys", "syscon";
+	reg = <0 0x15000000 0 0x1000>;
+	#clock-cells = <1>;
+};
diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.txt
new file mode 100644
index 0000000..b51e417
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.txt
@@ -0,0 +1,22 @@
+Mediatek mmsys controller
+============================
+
+The Mediatek mmsys controller provides various clocks to the system.
+
+Required Properties:
+
+- compatible: Should be:
+	- "mediatek,mt8173-mmsys", "syscon"
+- #clock-cells: Must be 1
+
+The mmsys controller uses the common clk binding from
+Documentation/devicetree/bindings/clock/clock-bindings.txt
+The available clocks are defined in dt-bindings/clock/mt*-clk.h.
+
+Example:
+
+mmsys: mmsys at 14000000 {
+	compatible = "mediatek,mt8173-mmsys", "syscon";
+	reg = <0 0x14000000 0 0x1000>;
+	#clock-cells = <1>;
+};
diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,vdecsys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,vdecsys.txt
new file mode 100644
index 0000000..a5b94a7
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,vdecsys.txt
@@ -0,0 +1,22 @@
+Mediatek vdecsys controller
+============================
+
+The Mediatek vdecsys controller provides various clocks to the system.
+
+Required Properties:
+
+- compatible: Should be:
+	- "mediatek,mt8173-vdecsys", "syscon"
+- #clock-cells: Must be 1
+
+The vdecsys controller uses the common clk binding from
+Documentation/devicetree/bindings/clock/clock-bindings.txt
+The available clocks are defined in dt-bindings/clock/mt*-clk.h.
+
+Example:
+
+vdecsys: vdecsys at 16000000 {
+	compatible = "mediatek,mt8173-vdecsys", "syscon";
+	reg = <0 0x16000000 0 0x1000>;
+	#clock-cells = <1>;
+};
diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,vencltsys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,vencltsys.txt
new file mode 100644
index 0000000..3d4e8d8
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,vencltsys.txt
@@ -0,0 +1,22 @@
+Mediatek vencltsys controller
+============================
+
+The Mediatek vencltsys controller provides various clocks to the system.
+
+Required Properties:
+
+- compatible: Should be:
+	- "mediatek,mt8173-vencltsys", "syscon"
+- #clock-cells: Must be 1
+
+The vencltsys controller uses the common clk binding from
+Documentation/devicetree/bindings/clock/clock-bindings.txt
+The available clocks are defined in dt-bindings/clock/mt*-clk.h.
+
+Example:
+
+vencltsys: vencltsys at 19000000 {
+	compatible = "mediatek,mt8173-vencltsys", "syscon";
+	reg = <0 0x19000000 0 0x1000>;
+	#clock-cells = <1>;
+};
diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,vencsys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,vencsys.txt
new file mode 100644
index 0000000..e5b72f5
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,vencsys.txt
@@ -0,0 +1,22 @@
+Mediatek vencsys controller
+============================
+
+The Mediatek vencsys controller provides various clocks to the system.
+
+Required Properties:
+
+- compatible: Should be:
+	- "mediatek,mt8173-vencsys", "syscon"
+- #clock-cells: Must be 1
+
+The vencsys controller uses the common clk binding from
+Documentation/devicetree/bindings/clock/clock-bindings.txt
+The available clocks are defined in dt-bindings/clock/mt*-clk.h.
+
+Example:
+
+vencsys: vencsys at 18000000 {
+	compatible = "mediatek,mt8173-vencsys", "syscon";
+	reg = <0 0x18000000 0 0x1000>;
+	#clock-cells = <1>;
+};
-- 
1.8.1.1.dirty
