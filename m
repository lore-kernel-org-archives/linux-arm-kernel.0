From: robh@kernel.org (Rob Herring)
Date: Fri,  5 Oct 2018 11:58:30 -0500
Subject: [PATCH 18/36] dt-bindings: arm: Convert Amlogic board/soc bindings to
 json-schema
In-Reply-To: <20181005165848.3474-1-robh@kernel.org>
References: <20181005165848.3474-1-robh@kernel.org>
Message-ID: <20181005165848.3474-19-robh@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert Amlogic SoC bindings to DT schema format using json-schema.

Cc: Carlo Caione <carlo@caione.org>
Cc: Kevin Hilman <khilman@baylibre.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: devicetree at vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/arm/amlogic.txt       | 102 -----------------
 .../devicetree/bindings/arm/amlogic.yaml      | 104 ++++++++++++++++++
 2 files changed, 104 insertions(+), 102 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/amlogic.txt
 create mode 100644 Documentation/devicetree/bindings/arm/amlogic.yaml

diff --git a/Documentation/devicetree/bindings/arm/amlogic.txt b/Documentation/devicetree/bindings/arm/amlogic.txt
deleted file mode 100644
index 2f2d01a00c54..000000000000
--- a/Documentation/devicetree/bindings/arm/amlogic.txt
+++ /dev/null
@@ -1,102 +0,0 @@
-Amlogic MesonX device tree bindings
--------------------------------------------
-
-Work in progress statement:
-
-Device tree files and bindings applying to Amlogic SoCs and boards are
-considered "unstable". Any Amlogic device tree binding may change at
-any time. Be sure to use a device tree binary and a kernel image
-generated from the same source tree.
-
-Please refer to Documentation/devicetree/bindings/ABI.txt for a definition of a
-stable binding/ABI.
-
----------------------------------------------------------------
-
-Boards with the Amlogic Meson6 SoC shall have the following properties:
-  Required root node property:
-    compatible: "amlogic,meson6"
-
-Boards with the Amlogic Meson8 SoC shall have the following properties:
-  Required root node property:
-    compatible: "amlogic,meson8";
-
-Boards with the Amlogic Meson8b SoC shall have the following properties:
-  Required root node property:
-    compatible: "amlogic,meson8b";
-
-Boards with the Amlogic Meson8m2 SoC shall have the following properties:
-  Required root node property:
-    compatible: "amlogic,meson8m2";
-
-Boards with the Amlogic Meson GXBaby SoC shall have the following properties:
-  Required root node property:
-    compatible: "amlogic,meson-gxbb";
-
-Boards with the Amlogic Meson GXL S905X SoC shall have the following properties:
-  Required root node property:
-    compatible: "amlogic,s905x", "amlogic,meson-gxl";
-
-Boards with the Amlogic Meson GXL S905D SoC shall have the following properties:
-  Required root node property:
-    compatible: "amlogic,s905d", "amlogic,meson-gxl";
-
-Boards with the Amlogic Meson GXL S805X SoC shall have the following properties:
-  Required root node property:
-    compatible: "amlogic,s805x", "amlogic,meson-gxl";
-
-Boards with the Amlogic Meson GXL S905W SoC shall have the following properties:
-  Required root node property:
-    compatible: "amlogic,s905w", "amlogic,meson-gxl";
-
-Boards with the Amlogic Meson GXM S912 SoC shall have the following properties:
-  Required root node property:
-    compatible: "amlogic,s912", "amlogic,meson-gxm";
-
-Boards with the Amlogic Meson AXG A113D SoC shall have the following properties:
-  Required root node property:
-    compatible: "amlogic,a113d", "amlogic,meson-axg";
-
-Board compatible values (alphabetically, grouped by SoC):
-
-  - "geniatech,atv1200" (Meson6)
-
-  - "minix,neo-x8" (Meson8)
-
-  - "hardkernel,odroid-c1" (Meson8b)
-  - "tronfy,mxq" (Meson8b)
-
-  - "tronsmart,mxiii-plus" (Meson8m2)
-
-  - "amlogic,p200" (Meson gxbb)
-  - "amlogic,p201" (Meson gxbb)
-  - "friendlyarm,nanopi-k2" (Meson gxbb)
-  - "hardkernel,odroid-c2" (Meson gxbb)
-  - "nexbox,a95x" (Meson gxbb or Meson gxl s905x)
-  - "tronsmart,vega-s95-pro", "tronsmart,vega-s95" (Meson gxbb)
-  - "tronsmart,vega-s95-meta", "tronsmart,vega-s95" (Meson gxbb)
-  - "tronsmart,vega-s95-telos", "tronsmart,vega-s95" (Meson gxbb)
-  - "wetek,hub" (Meson gxbb)
-  - "wetek,play2" (Meson gxbb)
-
-  - "amlogic,p212" (Meson gxl s905x)
-  - "hwacom,amazetv" (Meson gxl s905x)
-  - "khadas,vim" (Meson gxl s905x)
-  - "libretech,cc" (Meson gxl s905x)
-
-  - "amlogic,p230" (Meson gxl s905d)
-  - "amlogic,p231" (Meson gxl s905d)
-
-  - "amlogic,p241" (Meson gxl s805x)
-
-  - "amlogic,p281" (Meson gxl s905w)
-  - "oranth,tx3-mini" (Meson gxl s905w)
-
-  - "amlogic,q200" (Meson gxm s912)
-  - "amlogic,q201" (Meson gxm s912)
-  - "khadas,vim2" (Meson gxm s912)
-  - "kingnovel,r-box-pro" (Meson gxm S912)
-  - "nexbox,a1" (Meson gxm s912)
-  - "tronsmart,vega-s96" (Meson gxm s912)
-
-  - "amlogic,s400" (Meson axg a113d)
diff --git a/Documentation/devicetree/bindings/arm/amlogic.yaml b/Documentation/devicetree/bindings/arm/amlogic.yaml
new file mode 100644
index 000000000000..6168fef53aa1
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/amlogic.yaml
@@ -0,0 +1,104 @@
+# SPDX-License-Identifier: None
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/bindings/arm/amlogic.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Amlogic MesonX device tree bindings
+
+maintainers:
+  - Neil Armstrong <narmstrong@baylibre.com>
+  - Carlo Caione <carlo@caione.org>
+description: |+
+  Work in progress statement:
+
+  Device tree files and bindings applying to Amlogic SoCs and boards are
+  considered "unstable". Any Amlogic device tree binding may change at
+  any time. Be sure to use a device tree binary and a kernel image
+  generated from the same source tree.
+
+  Please refer to Documentation/devicetree/bindings/ABI.txt for a definition of a
+  stable binding/ABI.
+
+properties:
+  $nodename:
+    const: '/'
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - geniatech,atv1200
+          - const: amlogic,meson6
+      - items:
+          - enum:
+              - minix,neo-x8
+          - const: amlogic,meson8
+      - items:
+          - enum:
+              - tronsmart,mxiii-plus
+          - const: amlogic,meson8m2
+      - items:
+          - enum:
+              - hardkernel,odroid-c1
+              - tronfy,mxq
+          - const: amlogic,meson8b
+      - items:
+          - enum:
+              - amlogic,p200
+              - amlogic,p201
+              - friendlyarm,nanopi-k2
+              - hardkernel,odroid-c2
+              - nexbox,a95x
+              - wetek,hub
+              - wetek,play2
+          - const: amlogic,meson-gxbb
+      - items:
+          - enum:
+              - tronsmart,vega-s95-pro
+              - tronsmart,vega-s95-meta
+              - tronsmart,vega-s95-telos
+          - const: tronsmart,vega-s95
+          - const: amlogic,meson-gxbb
+      - items:
+          - enum:
+              - amlogic,p241
+          - const: amlogic,s805x
+          - const: amlogic,meson-gxl
+      - items:
+          - enum:
+              - amlogic,p281
+              - oranth,tx3-mini
+          - const: amlogic,s905w
+          - const: amlogic,meson-gxl
+      - items:
+          - enum:
+              - amlogic,p212
+              - hwacom,amazetv
+              - khadas,vim
+              - libretech,cc
+              - nexbox,a95x
+          - const: amlogic,s905x
+          - const: amlogic,meson-gxl
+      - items:
+          - enum:
+              - amlogic,p230
+              - amlogic,p231
+          - const: amlogic,s905d
+          - const: amlogic,meson-gxl
+      - items:
+          - enum:
+              - amlogic,q200
+              - amlogic,q201
+              - khadas,vim2
+              - kingnovel,r-box-pro
+              - nexbox,a1
+              - tronsmart,vega-s96
+          - const: amlogic,s912
+          - const: amlogic,meson-gxm
+      - items:
+          - enum:
+              - amlogic,s400
+          - const: amlogic,a113d
+          - const: amlogic,meson-axg
+
+...
-- 
2.17.1
