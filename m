From: robh@kernel.org (Rob Herring)
Date: Fri,  5 Oct 2018 11:58:37 -0500
Subject: [PATCH 25/36] dt-bindings: arm: Convert Oxford Semi board/soc
 bindings to json-schema
In-Reply-To: <20181005165848.3474-1-robh@kernel.org>
References: <20181005165848.3474-1-robh@kernel.org>
Message-ID: <20181005165848.3474-26-robh@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert Oxford Semi SoC bindings to DT schema format using json-schema.

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Neil Armstrong <narmstrong@baylibre.com>
Cc: devicetree at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-oxnas at groups.io
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/arm/oxnas.txt         | 14 -----------
 .../devicetree/bindings/arm/oxnas.yaml        | 25 +++++++++++++++++++
 2 files changed, 25 insertions(+), 14 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/oxnas.txt
 create mode 100644 Documentation/devicetree/bindings/arm/oxnas.yaml

diff --git a/Documentation/devicetree/bindings/arm/oxnas.txt b/Documentation/devicetree/bindings/arm/oxnas.txt
deleted file mode 100644
index ac64e60f99f1..000000000000
--- a/Documentation/devicetree/bindings/arm/oxnas.txt
+++ /dev/null
@@ -1,14 +0,0 @@
-Oxford Semiconductor OXNAS SoCs Family device tree bindings
--------------------------------------------
-
-Boards with the OX810SE SoC shall have the following properties:
-  Required root node property:
-    compatible: "oxsemi,ox810se"
-
-Boards with the OX820 SoC shall have the following properties:
-  Required root node property:
-    compatible: "oxsemi,ox820"
-
-Board compatible values:
-  - "wd,mbwe" (OX810SE)
-  - "cloudengines,pogoplugv3" (OX820)
diff --git a/Documentation/devicetree/bindings/arm/oxnas.yaml b/Documentation/devicetree/bindings/arm/oxnas.yaml
new file mode 100644
index 000000000000..c847a5707417
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/oxnas.yaml
@@ -0,0 +1,25 @@
+# SPDX-License-Identifier: None
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/bindings/arm/oxnas.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Oxford Semiconductor OXNAS SoCs Family device tree bindings
+
+maintainers:
+  - Neil Armstrong <narmstrong@baylibre.com>
+
+properties:
+  $nodename:
+    const: '/'
+  compatible:
+    oneOf:
+      - items:
+        - enum:
+            - wd,mbwe
+        - const: oxsemi,ox810se
+
+      - items:
+        - enum:
+            - cloudengines,pogoplugv3
+        - const: oxsemi,ox820
-- 
2.17.1
