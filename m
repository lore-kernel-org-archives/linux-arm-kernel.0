From: robh@kernel.org (Rob Herring)
Date: Fri,  5 Oct 2018 11:58:46 -0500
Subject: [PATCH 34/36] dt-bindings: arm: Convert VIA board/soc bindings to
 json-schema
In-Reply-To: <20181005165848.3474-1-robh@kernel.org>
References: <20181005165848.3474-1-robh@kernel.org>
Message-ID: <20181005165848.3474-35-robh@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert VIA SoC bindings to DT schema format using json-schema.

Cc: Tony Prisk <linux@prisktech.co.nz>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: devicetree at vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/arm/vt8500.txt        | 22 ------------------
 .../devicetree/bindings/arm/vt8500.yaml       | 23 +++++++++++++++++++
 2 files changed, 23 insertions(+), 22 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/vt8500.txt
 create mode 100644 Documentation/devicetree/bindings/arm/vt8500.yaml

diff --git a/Documentation/devicetree/bindings/arm/vt8500.txt b/Documentation/devicetree/bindings/arm/vt8500.txt
deleted file mode 100644
index 87dc1ddf4770..000000000000
--- a/Documentation/devicetree/bindings/arm/vt8500.txt
+++ /dev/null
@@ -1,22 +0,0 @@
-VIA/Wondermedia VT8500 Platforms Device Tree Bindings
----------------------------------------
-
-Boards with the VIA VT8500 SoC shall have the following properties:
-Required root node property:
-compatible = "via,vt8500";
-
-Boards with the Wondermedia WM8505 SoC shall have the following properties:
-Required root node property:
-compatible = "wm,wm8505";
-
-Boards with the Wondermedia WM8650 SoC shall have the following properties:
-Required root node property:
-compatible = "wm,wm8650";
-
-Boards with the Wondermedia WM8750 SoC shall have the following properties:
-Required root node property:
-compatible = "wm,wm8750";
-
-Boards with the Wondermedia WM8850 SoC shall have the following properties:
-Required root node property:
-compatible = "wm,wm8850";
diff --git a/Documentation/devicetree/bindings/arm/vt8500.yaml b/Documentation/devicetree/bindings/arm/vt8500.yaml
new file mode 100644
index 000000000000..6e07775b160f
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/vt8500.yaml
@@ -0,0 +1,23 @@
+# SPDX-License-Identifier: None
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/bindings/arm/vt8500.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: VIA/Wondermedia VT8500 Platforms Device Tree Bindings
+
+maintainers:
+  - Tony Prisk <linux@prisktech.co.nz>
+description: test
+
+properties:
+  $nodename:
+    const: '/'
+  compatible:
+    items:
+      - enum:
+          - via,vt8500
+          - wm,wm8505
+          - wm,wm8650
+          - wm,wm8750
+          - wm,wm8850
-- 
2.17.1
