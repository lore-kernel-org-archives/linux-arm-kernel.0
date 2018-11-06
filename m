From: weiyi.lu@mediatek.com (Weiyi Lu)
Date: Tue, 6 Nov 2018 14:42:00 +0800
Subject: [PATCH v1 05/11] dt-bindings: ARM: Mediatek: Document bindings for
 MT8183
In-Reply-To: <20181106064206.17535-1-weiyi.lu@mediatek.com>
References: <20181106064206.17535-1-weiyi.lu@mediatek.com>
Message-ID: <20181106064206.17535-7-weiyi.lu@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the binding documentation for apmixedsys, audiosys,
camsys, imgsys, infracfg, mcucfg, mfgcfg, mmsys, topckgen, vdecsys,
vencsys and ipu for Mediatek MT8183.

Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../arm/mediatek/mediatek,apmixedsys.txt      |  1 +
 .../bindings/arm/mediatek/mediatek,audsys.txt |  1 +
 .../bindings/arm/mediatek/mediatek,camsys.txt | 22 ++++++++++
 .../bindings/arm/mediatek/mediatek,imgsys.txt |  1 +
 .../arm/mediatek/mediatek,infracfg.txt        |  1 +
 .../bindings/arm/mediatek/mediatek,ipu.txt    | 43 +++++++++++++++++++
 .../bindings/arm/mediatek/mediatek,mcucfg.txt |  1 +
 .../bindings/arm/mediatek/mediatek,mfgcfg.txt |  1 +
 .../bindings/arm/mediatek/mediatek,mmsys.txt  |  1 +
 .../arm/mediatek/mediatek,topckgen.txt        |  1 +
 .../arm/mediatek/mediatek,vdecsys.txt         |  1 +
 .../arm/mediatek/mediatek,vencsys.txt         |  1 +
 12 files changed, 75 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,camsys.txt
 create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,ipu.txt

diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,apmixedsys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,apmixedsys.txt
index 4e4a3c0ab9ab..641f19e036a2 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,apmixedsys.txt
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,apmixedsys.txt
@@ -13,6 +13,7 @@ Required Properties:
 	- "mediatek,mt7623-apmixedsys", "mediatek,mt2701-apmixedsys"
 	- "mediatek,mt8135-apmixedsys"
 	- "mediatek,mt8173-apmixedsys"
+	- "mediatek,mt8183-apmixedsys", "syscon"
 - #clock-cells: Must be 1
 
 The apmixedsys controller uses the common clk binding from
diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,audsys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,audsys.txt
index d1606b2c3e63..f3cef1a6d95c 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,audsys.txt
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,audsys.txt
@@ -9,6 +9,7 @@ Required Properties:
 	- "mediatek,mt2701-audsys", "syscon"
 	- "mediatek,mt7622-audsys", "syscon"
 	- "mediatek,mt7623-audsys", "mediatek,mt2701-audsys", "syscon"
+	- "mediatek,mt8183-audiosys", "syscon"
 - #clock-cells: Must be 1
 
 The AUDSYS controller uses the common clk binding from
diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,camsys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,camsys.txt
new file mode 100644
index 000000000000..d8930f64aa98
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,camsys.txt
@@ -0,0 +1,22 @@
+MediaTek CAMSYS controller
+============================
+
+The MediaTek camsys controller provides various clocks to the system.
+
+Required Properties:
+
+- compatible: Should be one of:
+	- "mediatek,mt8183-camsys", "syscon"
+- #clock-cells: Must be 1
+
+The camsys controller uses the common clk binding from
+Documentation/devicetree/bindings/clock/clock-bindings.txt
+The available clocks are defined in dt-bindings/clock/mt*-clk.h.
+
+Example:
+
+camsys: camsys at 1a000000  {
+	compatible = "mediatek,mt8183-camsys", "syscon";
+	reg = <0 0x1a000000  0 0x1000>;
+	#clock-cells = <1>;
+};
diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,imgsys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,imgsys.txt
index 3f99672163e3..e3bc4a1e7a6e 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,imgsys.txt
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,imgsys.txt
@@ -11,6 +11,7 @@ Required Properties:
 	- "mediatek,mt6797-imgsys", "syscon"
 	- "mediatek,mt7623-imgsys", "mediatek,mt2701-imgsys", "syscon"
 	- "mediatek,mt8173-imgsys", "syscon"
+	- "mediatek,mt8183-imgsys", "syscon"
 - #clock-cells: Must be 1
 
 The imgsys controller uses the common clk binding from
diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,infracfg.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,infracfg.txt
index 89f4272a1441..44b2f3281c34 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,infracfg.txt
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,infracfg.txt
@@ -14,6 +14,7 @@ Required Properties:
 	- "mediatek,mt7623-infracfg", "mediatek,mt2701-infracfg", "syscon"
 	- "mediatek,mt8135-infracfg", "syscon"
 	- "mediatek,mt8173-infracfg", "syscon"
+	- "mediatek,mt8183-infracfg", "syscon"
 - #clock-cells: Must be 1
 - #reset-cells: Must be 1
 
diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,ipu.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,ipu.txt
new file mode 100644
index 000000000000..aabc8c5c8ed2
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,ipu.txt
@@ -0,0 +1,43 @@
+Mediatek IPU controller
+============================
+
+The Mediatek ipu controller provides various clocks to the system.
+
+Required Properties:
+
+- compatible: Should be one of:
+	- "mediatek,mt8183-ipu_conn", "syscon"
+	- "mediatek,mt8183-ipu_adl", "syscon"
+	- "mediatek,mt8183-ipu_core0", "syscon"
+	- "mediatek,mt8183-ipu_core1", "syscon"
+- #clock-cells: Must be 1
+
+The ipu controller uses the common clk binding from
+Documentation/devicetree/bindings/clock/clock-bindings.txt
+The available clocks are defined in dt-bindings/clock/mt*-clk.h.
+
+Example:
+
+ipu_conn: syscon at 19000000 {
+	compatible = "mediatek,mt8183-ipu_conn", "syscon";
+	reg = <0 0x19000000 0 0x1000>;
+	#clock-cells = <1>;
+};
+
+ipu_adl: syscon at 19010000 {
+	compatible = "mediatek,mt8183-ipu_adl", "syscon";
+	reg = <0 0x19010000 0 0x1000>;
+	#clock-cells = <1>;
+};
+
+ipu_core0: syscon at 19180000 {
+	compatible = "mediatek,mt8183-ipu_core0", "syscon";
+	reg = <0 0x19180000 0 0x1000>;
+	#clock-cells = <1>;
+};
+
+ipu_core1: syscon at 19280000 {
+	compatible = "mediatek,mt8183-ipu_core1", "syscon";
+	reg = <0 0x19280000 0 0x1000>;
+	#clock-cells = <1>;
+};
diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mcucfg.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mcucfg.txt
index b8fb03f3613e..2b882b7ca72e 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mcucfg.txt
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mcucfg.txt
@@ -7,6 +7,7 @@ Required Properties:
 
 - compatible: Should be one of:
 	- "mediatek,mt2712-mcucfg", "syscon"
+	- "mediatek,mt8183-mcucfg", "syscon"
 - #clock-cells: Must be 1
 
 The mcucfg controller uses the common clk binding from
diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mfgcfg.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mfgcfg.txt
index 859e67b416d5..72787e7dd227 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mfgcfg.txt
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mfgcfg.txt
@@ -7,6 +7,7 @@ Required Properties:
 
 - compatible: Should be one of:
 	- "mediatek,mt2712-mfgcfg", "syscon"
+	- "mediatek,mt8183-mfgcfg", "syscon"
 - #clock-cells: Must be 1
 
 The mfgcfg controller uses the common clk binding from
diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.txt
index 15d977afad31..545eab717c96 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.txt
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.txt
@@ -11,6 +11,7 @@ Required Properties:
 	- "mediatek,mt6797-mmsys", "syscon"
 	- "mediatek,mt7623-mmsys", "mediatek,mt2701-mmsys", "syscon"
 	- "mediatek,mt8173-mmsys", "syscon"
+	- "mediatek,mt8183-mmsys", "syscon"
 - #clock-cells: Must be 1
 
 The mmsys controller uses the common clk binding from
diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,topckgen.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,topckgen.txt
index d849465b8c99..08bbd37190ad 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,topckgen.txt
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,topckgen.txt
@@ -13,6 +13,7 @@ Required Properties:
 	- "mediatek,mt7623-topckgen", "mediatek,mt2701-topckgen"
 	- "mediatek,mt8135-topckgen"
 	- "mediatek,mt8173-topckgen"
+	- "mediatek,mt8183-topckgen", "syscon"
 - #clock-cells: Must be 1
 
 The topckgen controller uses the common clk binding from
diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,vdecsys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,vdecsys.txt
index 3212afc753c8..57176bb8dbb5 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,vdecsys.txt
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,vdecsys.txt
@@ -11,6 +11,7 @@ Required Properties:
 	- "mediatek,mt6797-vdecsys", "syscon"
 	- "mediatek,mt7623-vdecsys", "mediatek,mt2701-vdecsys", "syscon"
 	- "mediatek,mt8173-vdecsys", "syscon"
+	- "mediatek,mt8183-vdecsys", "syscon"
 - #clock-cells: Must be 1
 
 The vdecsys controller uses the common clk binding from
diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,vencsys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,vencsys.txt
index 851545357e94..c9faa6269087 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,vencsys.txt
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,vencsys.txt
@@ -9,6 +9,7 @@ Required Properties:
 	- "mediatek,mt2712-vencsys", "syscon"
 	- "mediatek,mt6797-vencsys", "syscon"
 	- "mediatek,mt8173-vencsys", "syscon"
+	- "mediatek,mt8183-vencsys", "syscon"
 - #clock-cells: Must be 1
 
 The vencsys controller uses the common clk binding from
-- 
2.18.0
