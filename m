From: jamesjj.liao@mediatek.com (James Liao)
Date: Thu, 14 Apr 2016 16:11:47 +0800
Subject: [PATCH v7 2/9] dt-bindings: ARM: Mediatek: Document bindings for
 MT2701
In-Reply-To: <1460621514-65191-1-git-send-email-jamesjj.liao@mediatek.com>
References: <1460621514-65191-1-git-send-email-jamesjj.liao@mediatek.com>
Message-ID: <1460621514-65191-3-git-send-email-jamesjj.liao@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the binding documentation for apmixedsys, bdpsys,
ethsys, hifsys, imgsys, infracfg, mmsys, pericfg, topckgen and
vdecsys for Mediatek MT2701.

Signed-off-by: James Liao <jamesjj.liao@mediatek.com>
Tested-by: John Crispin <blogic@openwrt.org>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../bindings/arm/mediatek/mediatek,apmixedsys.txt  |  3 ++-
 .../bindings/arm/mediatek/mediatek,bdpsys.txt      | 22 ++++++++++++++++++++
 .../bindings/arm/mediatek/mediatek,ethsys.txt      | 22 ++++++++++++++++++++
 .../bindings/arm/mediatek/mediatek,hifsys.txt      | 24 ++++++++++++++++++++++
 .../bindings/arm/mediatek/mediatek,imgsys.txt      |  3 ++-
 .../bindings/arm/mediatek/mediatek,infracfg.txt    |  3 ++-
 .../bindings/arm/mediatek/mediatek,mmsys.txt       |  3 ++-
 .../bindings/arm/mediatek/mediatek,pericfg.txt     |  3 ++-
 .../bindings/arm/mediatek/mediatek,topckgen.txt    |  3 ++-
 .../bindings/arm/mediatek/mediatek,vdecsys.txt     |  3 ++-
 10 files changed, 82 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,bdpsys.txt
 create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,ethsys.txt
 create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,hifsys.txt

diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,apmixedsys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,apmixedsys.txt
index 936166f..cb0054a 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,apmixedsys.txt
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,apmixedsys.txt
@@ -5,7 +5,8 @@ The Mediatek apmixedsys controller provides the PLLs to the system.
 
 Required Properties:
 
-- compatible: Should be:
+- compatible: Should be one of:
+	- "mediatek,mt2701-apmixedsys"
 	- "mediatek,mt8135-apmixedsys"
 	- "mediatek,mt8173-apmixedsys"
 - #clock-cells: Must be 1
diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,bdpsys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,bdpsys.txt
new file mode 100644
index 0000000..4137196
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,bdpsys.txt
@@ -0,0 +1,22 @@
+Mediatek bdpsys controller
+============================
+
+The Mediatek bdpsys controller provides various clocks to the system.
+
+Required Properties:
+
+- compatible: Should be:
+	- "mediatek,mt2701-bdpsys", "syscon"
+- #clock-cells: Must be 1
+
+The bdpsys controller uses the common clk binding from
+Documentation/devicetree/bindings/clock/clock-bindings.txt
+The available clocks are defined in dt-bindings/clock/mt*-clk.h.
+
+Example:
+
+bdpsys: clock-controller at 1c000000 {
+	compatible = "mediatek,mt2701-bdpsys", "syscon";
+	reg = <0 0x1c000000 0 0x1000>;
+	#clock-cells = <1>;
+};
diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,ethsys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,ethsys.txt
new file mode 100644
index 0000000..768f3a5
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,ethsys.txt
@@ -0,0 +1,22 @@
+Mediatek ethsys controller
+============================
+
+The Mediatek ethsys controller provides various clocks to the system.
+
+Required Properties:
+
+- compatible: Should be:
+	- "mediatek,mt2701-ethsys", "syscon"
+- #clock-cells: Must be 1
+
+The ethsys controller uses the common clk binding from
+Documentation/devicetree/bindings/clock/clock-bindings.txt
+The available clocks are defined in dt-bindings/clock/mt*-clk.h.
+
+Example:
+
+ethsys: clock-controller at 1b000000 {
+	compatible = "mediatek,mt2701-ethsys", "syscon";
+	reg = <0 0x1b000000 0 0x1000>;
+	#clock-cells = <1>;
+};
diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,hifsys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,hifsys.txt
new file mode 100644
index 0000000..beed7b5
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,hifsys.txt
@@ -0,0 +1,24 @@
+Mediatek hifsys controller
+============================
+
+The Mediatek hifsys controller provides various clocks and reset
+outputs to the system.
+
+Required Properties:
+
+- compatible: Should be:
+	- "mediatek,mt2701-hifsys", "syscon"
+- #clock-cells: Must be 1
+
+The hifsys controller uses the common clk binding from
+Documentation/devicetree/bindings/clock/clock-bindings.txt
+The available clocks are defined in dt-bindings/clock/mt*-clk.h.
+
+Example:
+
+hifsys: clock-controller at 1a000000 {
+	compatible = "mediatek,mt2701-hifsys", "syscon";
+	reg = <0 0x1a000000 0 0x1000>;
+	#clock-cells = <1>;
+	#reset-cells = <1>;
+};
diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,imgsys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,imgsys.txt
index b1f2ce1..f6a9166 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,imgsys.txt
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,imgsys.txt
@@ -5,7 +5,8 @@ The Mediatek imgsys controller provides various clocks to the system.
 
 Required Properties:
 
-- compatible: Should be:
+- compatible: Should be one of:
+	- "mediatek,mt2701-imgsys", "syscon"
 	- "mediatek,mt8173-imgsys", "syscon"
 - #clock-cells: Must be 1
 
diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,infracfg.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,infracfg.txt
index aaf8d14..1620ec2 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,infracfg.txt
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,infracfg.txt
@@ -6,7 +6,8 @@ outputs to the system.
 
 Required Properties:
 
-- compatible: Should be:
+- compatible: Should be one of:
+	- "mediatek,mt2701-infracfg", "syscon"
 	- "mediatek,mt8135-infracfg", "syscon"
 	- "mediatek,mt8173-infracfg", "syscon"
 - #clock-cells: Must be 1
diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.txt
index 4385946..67dd2e4 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.txt
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.txt
@@ -5,7 +5,8 @@ The Mediatek mmsys controller provides various clocks to the system.
 
 Required Properties:
 
-- compatible: Should be:
+- compatible: Should be one of:
+	- "mediatek,mt2701-mmsys", "syscon"
 	- "mediatek,mt8173-mmsys", "syscon"
 - #clock-cells: Must be 1
 
diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,pericfg.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,pericfg.txt
index 2f6ff86..e494366 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,pericfg.txt
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,pericfg.txt
@@ -6,7 +6,8 @@ outputs to the system.
 
 Required Properties:
 
-- compatible: Should be:
+- compatible: Should be one of:
+	- "mediatek,mt2701-pericfg", "syscon"
 	- "mediatek,mt8135-pericfg", "syscon"
 	- "mediatek,mt8173-pericfg", "syscon"
 - #clock-cells: Must be 1
diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,topckgen.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,topckgen.txt
index f9e9179..9f2fe78 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,topckgen.txt
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,topckgen.txt
@@ -5,7 +5,8 @@ The Mediatek topckgen controller provides various clocks to the system.
 
 Required Properties:
 
-- compatible: Should be:
+- compatible: Should be one of:
+	- "mediatek,mt2701-topckgen"
 	- "mediatek,mt8135-topckgen"
 	- "mediatek,mt8173-topckgen"
 - #clock-cells: Must be 1
diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,vdecsys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,vdecsys.txt
index 1faacf1..2440f73 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,vdecsys.txt
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,vdecsys.txt
@@ -5,7 +5,8 @@ The Mediatek vdecsys controller provides various clocks to the system.
 
 Required Properties:
 
-- compatible: Should be:
+- compatible: Should be one of:
+	- "mediatek,mt2701-vdecsys", "syscon"
 	- "mediatek,mt8173-vdecsys", "syscon"
 - #clock-cells: Must be 1
 
-- 
1.9.1
