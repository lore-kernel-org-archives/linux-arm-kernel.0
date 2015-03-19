From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 19 Mar 2015 09:42:10 +0100
Subject: [PATCH 6/6] dt-bindings: ARM: Mediatek: Document devicetree bindings
 for clock/reset controllers
In-Reply-To: <1426754530-3137-1-git-send-email-s.hauer@pengutronix.de>
References: <1426754530-3137-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1426754530-3137-7-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 .../bindings/arm/mediatek/mediatek,apmixedsys.txt  | 23 +++++++++++++++++
 .../bindings/arm/mediatek/mediatek,infracfg.txt    | 30 ++++++++++++++++++++++
 .../bindings/arm/mediatek/mediatek,pericfg.txt     | 30 ++++++++++++++++++++++
 .../bindings/arm/mediatek/mediatek,topckgen.txt    | 23 +++++++++++++++++
 4 files changed, 106 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,apmixedsys.txt
 create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,infracfg.txt
 create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,pericfg.txt
 create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,topckgen.txt

diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,apmixedsys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,apmixedsys.txt
new file mode 100644
index 0000000..5af6d73
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,apmixedsys.txt
@@ -0,0 +1,23 @@
+Mediatek apmixedsys controller
+==============================
+
+The Mediatek apmixedsys controller provides the PLLs to the system.
+
+Required Properties:
+
+- compatible: Should be:
+	- "mediatek,mt8135-apmixedsys"
+	- "mediatek,mt8173-apmixedsys"
+- #clock-cells: Must be 1
+
+The apmixedsys controller uses the common clk binding from
+Documentation/devicetree/bindings/clock/clock-bindings.txt
+The available clocks are defined in dt-bindings/clock/mt*-clk.h.
+
+Example:
+
+apmixedsys: apmixedsys at 10209000 {
+	compatible = "mediatek,mt8173-apmixedsys";
+	reg = <0 0x10209000 0 0x1000>;
+	#clock-cells = <1>;
+};
diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,infracfg.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,infracfg.txt
new file mode 100644
index 0000000..684da473
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,infracfg.txt
@@ -0,0 +1,30 @@
+Mediatek infracfg controller
+============================
+
+The Mediatek infracfg controller provides various clocks and reset
+outputs to the system.
+
+Required Properties:
+
+- compatible: Should be:
+	- "mediatek,mt8135-infracfg", "syscon"
+	- "mediatek,mt8173-infracfg", "syscon"
+- #clock-cells: Must be 1
+- #reset-cells: Must be 1
+
+The infracfg controller uses the common clk binding from
+Documentation/devicetree/bindings/clock/clock-bindings.txt
+The available clocks are defined in dt-bindings/clock/mt*-clk.h.
+Also it uses the common reset controller binding from
+Documentation/devicetree/bindings/reset/reset.txt.
+The available reset outputs are defined in
+dt-bindings/reset-controller/mt*-resets.h
+
+Example:
+
+infracfg: infracfg at 10001000 {
+	compatible = "mediatek,mt8173-infracfg", "syscon";
+	reg = <0 0x10001000 0 0x1000>;
+	#clock-cells = <1>;
+	#reset-cells = <1>;
+};
diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,pericfg.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,pericfg.txt
new file mode 100644
index 0000000..fdb45c6
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,pericfg.txt
@@ -0,0 +1,30 @@
+Mediatek pericfg controller
+===========================
+
+The Mediatek pericfg controller provides various clocks and reset
+outputs to the system.
+
+Required Properties:
+
+- compatible: Should be:
+	- "mediatek,mt8135-pericfg", "syscon"
+	- "mediatek,mt8173-pericfg", "syscon"
+- #clock-cells: Must be 1
+- #reset-cells: Must be 1
+
+The pericfg controller uses the common clk binding from
+Documentation/devicetree/bindings/clock/clock-bindings.txt
+The available clocks are defined in dt-bindings/clock/mt*-clk.h.
+Also it uses the common reset controller binding from
+Documentation/devicetree/bindings/reset/reset.txt.
+The available reset outputs are defined in
+dt-bindings/reset-controller/mt*-resets.h
+
+Example:
+
+pericfg: pericfg at 10003000 {
+	compatible = "mediatek,mt8173-pericfg", "syscon";
+	reg = <0 0x10003000 0 0x1000>;
+	#clock-cells = <1>;
+	#reset-cells = <1>;
+};
diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,topckgen.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,topckgen.txt
new file mode 100644
index 0000000..a425248
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,topckgen.txt
@@ -0,0 +1,23 @@
+Mediatek topckgen controller
+============================
+
+The Mediatek topckgen controller provides various clocks to the system.
+
+Required Properties:
+
+- compatible: Should be:
+	- "mediatek,mt8135-topckgen"
+	- "mediatek,mt8173-topckgen"
+- #clock-cells: Must be 1
+
+The topckgen controller uses the common clk binding from
+Documentation/devicetree/bindings/clock/clock-bindings.txt
+The available clocks are defined in dt-bindings/clock/mt*-clk.h.
+
+Example:
+
+topckgen: topckgen at 10000000 {
+	compatible = "mediatek,mt8173-topckgen";
+	reg = <0 0x10000000 0 0x1000>;
+	#clock-cells = <1>;
+};
-- 
2.1.4
