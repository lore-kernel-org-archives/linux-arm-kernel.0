From: robh@kernel.org (Rob Herring)
Date: Fri,  5 Oct 2018 11:58:32 -0500
Subject: [PATCH 20/36] dt-bindings: arm: Convert Calxeda board/soc bindings to
 json-schema
In-Reply-To: <20181005165848.3474-1-robh@kernel.org>
References: <20181005165848.3474-1-robh@kernel.org>
Message-ID: <20181005165848.3474-21-robh@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert Calxeda SoC bindings to DT schema format using json-schema.

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: devicetree at vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/arm/calxeda.txt       | 15 -------------
 .../devicetree/bindings/arm/calxeda.yaml      | 22 +++++++++++++++++++
 2 files changed, 22 insertions(+), 15 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/calxeda.txt
 create mode 100644 Documentation/devicetree/bindings/arm/calxeda.yaml

diff --git a/Documentation/devicetree/bindings/arm/calxeda.txt b/Documentation/devicetree/bindings/arm/calxeda.txt
deleted file mode 100644
index 25fcf96795ca..000000000000
--- a/Documentation/devicetree/bindings/arm/calxeda.txt
+++ /dev/null
@@ -1,15 +0,0 @@
-Calxeda Platforms Device Tree Bindings
------------------------------------------------
-
-Boards with Calxeda Cortex-A9 based ECX-1000 (Highbank) SOC shall have the
-following properties.
-
-Required root node properties:
-    - compatible = "calxeda,highbank";
-
-
-Boards with Calxeda Cortex-A15 based ECX-2000 SOC shall have the following
-properties.
-
-Required root node properties:
-    - compatible = "calxeda,ecx-2000";
diff --git a/Documentation/devicetree/bindings/arm/calxeda.yaml b/Documentation/devicetree/bindings/arm/calxeda.yaml
new file mode 100644
index 000000000000..bc5c69926c6e
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/calxeda.yaml
@@ -0,0 +1,22 @@
+# SPDX-License-Identifier: None
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/bindings/arm/calxeda.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Calxeda Platforms Device Tree Bindings
+
+maintainers:
+  - Rob Herring <robh@kernel.org>
+description: |+
+  Bindings for boards with Calxeda Cortex-A9 based ECX-1000 (Highbank) SOC
+  or Cortex-A15 based ECX-2000 SOCs
+
+properties:
+  $nodename:
+    const: '/'
+  compatible:
+    items:
+      - enum:
+          - calxeda,highbank
+          - calxeda,ecx-2000
-- 
2.17.1
