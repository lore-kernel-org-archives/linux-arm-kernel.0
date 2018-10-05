From: robh@kernel.org (Rob Herring)
Date: Fri,  5 Oct 2018 11:58:35 -0500
Subject: [PATCH 23/36] dt-bindings: arm: Convert MediaTek board/soc bindings
 to json-schema
In-Reply-To: <20181005165848.3474-1-robh@kernel.org>
References: <20181005165848.3474-1-robh@kernel.org>
Message-ID: <20181005165848.3474-24-robh@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert MediaTek SoC bindings to DT schema format using json-schema.

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>
Cc: devicetree at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-mediatek at lists.infradead.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/arm/mediatek.txt      | 79 -----------------
 .../devicetree/bindings/arm/mediatek.yaml     | 85 +++++++++++++++++++
 2 files changed, 85 insertions(+), 79 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/mediatek.txt
 create mode 100644 Documentation/devicetree/bindings/arm/mediatek.yaml

diff --git a/Documentation/devicetree/bindings/arm/mediatek.txt b/Documentation/devicetree/bindings/arm/mediatek.txt
deleted file mode 100644
index 8f260e5cfd16..000000000000
--- a/Documentation/devicetree/bindings/arm/mediatek.txt
+++ /dev/null
@@ -1,79 +0,0 @@
-MediaTek SoC based Platforms Device Tree Bindings
-
-Boards with a MediaTek SoC shall have the following property:
-
-Required root node property:
-
-compatible: Must contain one of
-   "mediatek,mt2701"
-   "mediatek,mt2712"
-   "mediatek,mt6580"
-   "mediatek,mt6589"
-   "mediatek,mt6592"
-   "mediatek,mt6755"
-   "mediatek,mt6765"
-   "mediatek,mt6795"
-   "mediatek,mt6797"
-   "mediatek,mt7622"
-   "mediatek,mt7623" which is referred to MT7623N SoC
-   "mediatek,mt7623a"
-   "mediatek,mt8127"
-   "mediatek,mt8135"
-   "mediatek,mt8173"
-
-
-Supported boards:
-
-- Evaluation board for MT2701:
-    Required root node properties:
-      - compatible = "mediatek,mt2701-evb", "mediatek,mt2701";
-- Evaluation board for MT2712:
-    Required root node properties:
-      - compatible = "mediatek,mt2712-evb", "mediatek,mt2712";
-- Evaluation board for MT6580:
-    Required root node properties:
-      - compatible = "mediatek,mt6580-evbp1", "mediatek,mt6580";
-- bq Aquaris5 smart phone:
-    Required root node properties:
-      - compatible = "mundoreader,bq-aquaris5", "mediatek,mt6589";
-- Evaluation board for MT6592:
-    Required root node properties:
-      - compatible = "mediatek,mt6592-evb", "mediatek,mt6592";
-- Evaluation phone for MT6755(Helio P10):
-    Required root node properties:
-      - compatible = "mediatek,mt6755-evb", "mediatek,mt6755";
-- Evaluation board for MT6765(Helio P22):
-    Required root node properties:
-      - compatible = "mediatek,mt6765-evb", "mediatek,mt6765";
-- Evaluation board for MT6795(Helio X10):
-    Required root node properties:
-      - compatible = "mediatek,mt6795-evb", "mediatek,mt6795";
-- Evaluation board for MT6797(Helio X20):
-    Required root node properties:
-      - compatible = "mediatek,mt6797-evb", "mediatek,mt6797";
-- Mediatek X20 Development Board:
-    Required root node properties:
-      - compatible = "archermind,mt6797-x20-dev", "mediatek,mt6797";
-- Reference board variant 1 for MT7622:
-    Required root node properties:
-      - compatible = "mediatek,mt7622-rfb1", "mediatek,mt7622";
-- Reference board for MT7623a with eMMC:
-    Required root node properties:
-      - compatible = "mediatek,mt7623a-rfb-emmc", "mediatek,mt7623";
-- Reference board for MT7623a with NAND:
-    Required root node properties:
-      - compatible = "mediatek,mt7623a-rfb-nand", "mediatek,mt7623";
-- Reference board for MT7623n with eMMC:
-    Required root node properties:
-      - compatible = "mediatek,mt7623n-rfb-emmc", "mediatek,mt7623";
-- Bananapi BPI-R2 board:
-      - compatible = "bananapi,bpi-r2", "mediatek,mt7623";
-- MTK mt8127 tablet moose EVB:
-    Required root node properties:
-      - compatible = "mediatek,mt8127-moose", "mediatek,mt8127";
-- MTK mt8135 tablet EVB:
-    Required root node properties:
-      - compatible = "mediatek,mt8135-evbp1", "mediatek,mt8135";
-- MTK mt8173 tablet EVB:
-    Required root node properties:
-      - compatible = "mediatek,mt8173-evb", "mediatek,mt8173";
diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Documentation/devicetree/bindings/arm/mediatek.yaml
new file mode 100644
index 000000000000..861af7c66ac5
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
@@ -0,0 +1,85 @@
+# SPDX-License-Identifier: None
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/bindings/arm/mediatek.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek SoC based Platforms Device Tree Bindings
+
+maintainers:
+  - Sean Wang <sean.wang@mediatek.com>
+  - Matthias Brugger <matthias.bgg@gmail.com>
+description: |
+  Boards with a MediaTek SoC shall have the following properties.
+
+properties:
+  $nodename:
+    const: '/'
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - mediatek,mt2701-evb
+          - const: mediatek,mt2701
+
+      - items:
+          - enum:
+              - mediatek,mt2712-evb
+          - const: mediatek,mt2712
+      - items:
+          - enum:
+              - mediatek,mt6580-evbp1
+          - const: mediatek,mt6580
+      - items:
+          - enum:
+              - mundoreader,bq-aquaris5
+          - const: mediatek,mt6589
+      - items:
+          - enum:
+              - mediatek,mt6592-evb
+          - const: mediatek,mt6592
+      - items:
+          - enum:
+              - mediatek,mt6755-evb
+          - const: mediatek,mt6755
+      - items:
+          - enum:
+              - mediatek,mt6765-evb
+          - const: mediatek,mt6765
+      - items:
+          - enum:
+              - mediatek,mt6795-evb
+          - const: mediatek,mt6795
+      - items:
+          - enum:
+              - archermind,mt6797-x20-dev
+              - mediatek,mt6797-evb
+          - const: mediatek,mt6797
+      - items:
+          - enum:
+              - mediatek,mt7622-rfb1
+          - const: mediatek,mt7622
+      - items:
+          - enum:
+              - mediatek,mt7623a-rfb-emmc
+              - mediatek,mt7623a-rfb-nand
+              - mediatek,mt7623n-rfb-emmc
+              - bananapi,bpi-r2
+          - const: mediatek,mt7623
+        description: Also referred to as MT7623N SoC
+
+      - items:
+          - const: mediatek,mt7623a
+      - items:
+          - enum:
+              - mediatek,mt8127-moose
+          - const: mediatek,mt8127
+      - items:
+          - enum:
+              - mediatek,mt8135-evbp1
+          - const: mediatek,mt8135
+      - items:
+          - enum:
+              - mediatek,mt8173-evb
+          - const: mediatek,mt8173
+...
-- 
2.17.1
