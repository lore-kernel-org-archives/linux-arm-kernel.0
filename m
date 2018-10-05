From: robh@kernel.org (Rob Herring)
Date: Fri,  5 Oct 2018 11:58:39 -0500
Subject: [PATCH 27/36] dt-bindings: arm: Convert Realtek board/soc bindings to
 json-schema
In-Reply-To: <20181005165848.3474-1-robh@kernel.org>
References: <20181005165848.3474-1-robh@kernel.org>
Message-ID: <20181005165848.3474-28-robh@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert Realtek SoC bindings to DT schema format using json-schema.

Cc: "Andreas F?rber" <afaerber@suse.de>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel at lists.infradead.org
Cc: devicetree at vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/arm/realtek.txt       | 22 ----------------
 .../devicetree/bindings/arm/realtek.yaml      | 25 +++++++++++++++++++
 2 files changed, 25 insertions(+), 22 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/realtek.txt
 create mode 100644 Documentation/devicetree/bindings/arm/realtek.yaml

diff --git a/Documentation/devicetree/bindings/arm/realtek.txt b/Documentation/devicetree/bindings/arm/realtek.txt
deleted file mode 100644
index 95839e19ae92..000000000000
--- a/Documentation/devicetree/bindings/arm/realtek.txt
+++ /dev/null
@@ -1,22 +0,0 @@
-Realtek platforms device tree bindings
---------------------------------------
-
-
-RTD1295 SoC
-===========
-
-Required root node properties:
-
- - compatible :  must contain "realtek,rtd1295"
-
-
-Root node property compatible must contain, depending on board:
-
- - MeLE V9: "mele,v9"
- - ProBox2 AVA: "probox2,ava"
- - Zidoo X9S: "zidoo,x9s"
-
-
-Example:
-
-    compatible = "zidoo,x9s", "realtek,rtd1295";
diff --git a/Documentation/devicetree/bindings/arm/realtek.yaml b/Documentation/devicetree/bindings/arm/realtek.yaml
new file mode 100644
index 000000000000..9e3bb3249c77
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/realtek.yaml
@@ -0,0 +1,25 @@
+# SPDX-License-Identifier: None
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/bindings/arm/realtek.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Realtek platforms device tree bindings
+
+maintainers:
+  - Andreas F?rber <afaerber@suse.de>
+
+description: |+
+  RTD1295 SoC
+
+properties:
+  $nodename:
+    const: '/'
+  compatible:
+    items:
+      - enum:
+          - mele,v9
+          - probox2,ava
+          - zidoo,x9s
+      - const: realtek,rtd1295
+...
-- 
2.17.1
