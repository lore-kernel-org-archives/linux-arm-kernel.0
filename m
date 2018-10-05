From: robh@kernel.org (Rob Herring)
Date: Fri,  5 Oct 2018 11:58:27 -0500
Subject: [PATCH 15/36] dt-bindings: arm: Convert Actions Semi bindings to
 jsonschema
In-Reply-To: <20181005165848.3474-1-robh@kernel.org>
References: <20181005165848.3474-1-robh@kernel.org>
Message-ID: <20181005165848.3474-16-robh@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert Actions Semi SoC bindings to DT schema format using json-schema.

Cc: "Andreas F?rber" <afaerber@suse.de>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel at lists.infradead.org
Cc: devicetree at vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/arm/actions.txt       | 56 -------------------
 .../devicetree/bindings/arm/actions.yaml      | 34 +++++++++++
 2 files changed, 34 insertions(+), 56 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/actions.txt
 create mode 100644 Documentation/devicetree/bindings/arm/actions.yaml

diff --git a/Documentation/devicetree/bindings/arm/actions.txt b/Documentation/devicetree/bindings/arm/actions.txt
deleted file mode 100644
index d54f33c4e0da..000000000000
--- a/Documentation/devicetree/bindings/arm/actions.txt
+++ /dev/null
@@ -1,56 +0,0 @@
-Actions Semi platforms device tree bindings
--------------------------------------------
-
-
-S500 SoC
-========
-
-Required root node properties:
-
- - compatible :  must contain "actions,s500"
-
-
-Modules:
-
-Root node property compatible must contain, depending on module:
-
- - LeMaker Guitar: "lemaker,guitar"
-
-
-Boards:
-
-Root node property compatible must contain, depending on board:
-
- - Allo.com Sparky: "allo,sparky"
- - Cubietech CubieBoard6: "cubietech,cubieboard6"
- - LeMaker Guitar Base Board rev. B: "lemaker,guitar-bb-rev-b", "lemaker,guitar"
-
-
-S700 SoC
-========
-
-Required root node properties:
-
-- compatible :  must contain "actions,s700"
-
-
-Boards:
-
-Root node property compatible must contain, depending on board:
-
- - Cubietech CubieBoard7: "cubietech,cubieboard7"
-
-
-S900 SoC
-========
-
-Required root node properties:
-
-- compatible :  must contain "actions,s900"
-
-
-Boards:
-
-Root node property compatible must contain, depending on board:
-
- - uCRobotics Bubblegum-96: "ucrobotics,bubblegum-96"
diff --git a/Documentation/devicetree/bindings/arm/actions.yaml b/Documentation/devicetree/bindings/arm/actions.yaml
new file mode 100644
index 000000000000..af9345a228b4
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/actions.yaml
@@ -0,0 +1,34 @@
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/arm/actions.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Actions Semi platforms device tree bindings
+
+maintainers:
+  - Andreas F?rber <afaerber@suse.de>
+
+description: |
+  The Actions Semi S500 is a quad-core ARM Cortex-A9 SoC. The Actions Semi
+  S900 is a quad-core ARM Cortex-A53 SoC.
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - lemaker,guitar-bb-rev-b
+          - enum:
+              - lemaker,guitar
+              - allo,sparky
+              - cubietech,cubieboard6
+          - const: actions,s500
+        minItems: 2
+        maxItems: 3
+        additionalItems: false
+      - items:
+          - const: cubietech,cubieboard7
+          - const: actions,s700
+      - items:
+          - const: ucrobotics,bubblegum-96
+          - const: actions,s900
-- 
2.17.1
