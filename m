From: robh@kernel.org (Rob Herring)
Date: Fri,  5 Oct 2018 11:58:43 -0500
Subject: [PATCH 31/36] dt-bindings: arm: Convert SPEAr board/soc bindings to
 json-schema
In-Reply-To: <20181005165848.3474-1-robh@kernel.org>
References: <20181005165848.3474-1-robh@kernel.org>
Message-ID: <20181005165848.3474-32-robh@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert SPEAr SoC bindings to DT schema format using json-schema.

Cc: Viresh Kumar <vireshk@kernel.org>
Cc: Shiraz Hashim <shiraz.linux.kernel@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: devicetree at vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/arm/spear.txt         | 26 -------------------
 .../devicetree/bindings/arm/spear.yaml        | 25 ++++++++++++++++++
 2 files changed, 25 insertions(+), 26 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/spear.txt
 create mode 100644 Documentation/devicetree/bindings/arm/spear.yaml

diff --git a/Documentation/devicetree/bindings/arm/spear.txt b/Documentation/devicetree/bindings/arm/spear.txt
deleted file mode 100644
index 0d42949df6c2..000000000000
--- a/Documentation/devicetree/bindings/arm/spear.txt
+++ /dev/null
@@ -1,26 +0,0 @@
-ST SPEAr Platforms Device Tree Bindings
----------------------------------------
-
-Boards with the ST SPEAr600 SoC shall have the following properties:
-Required root node property:
-compatible = "st,spear600";
-
-Boards with the ST SPEAr300 SoC shall have the following properties:
-Required root node property:
-compatible = "st,spear300";
-
-Boards with the ST SPEAr310 SoC shall have the following properties:
-Required root node property:
-compatible = "st,spear310";
-
-Boards with the ST SPEAr320 SoC shall have the following properties:
-Required root node property:
-compatible = "st,spear320";
-
-Boards with the ST SPEAr1310 SoC shall have the following properties:
-Required root node property:
-compatible = "st,spear1310";
-
-Boards with the ST SPEAr1340 SoC shall have the following properties:
-Required root node property:
-compatible = "st,spear1340";
diff --git a/Documentation/devicetree/bindings/arm/spear.yaml b/Documentation/devicetree/bindings/arm/spear.yaml
new file mode 100644
index 000000000000..6ce8ef979390
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/spear.yaml
@@ -0,0 +1,25 @@
+# SPDX-License-Identifier: None
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/bindings/arm/spear.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ST SPEAr Platforms Device Tree Bindings
+
+maintainers:
+  - Viresh Kumar <vireshk@kernel.org>
+  - Stefan Roese <sr@denx.de>
+
+properties:
+  $nodename:
+    const: '/'
+  compatible:
+    items:
+      - enum:
+          - st,spear600
+          - st,spear300
+          - st,spear310
+          - st,spear320
+          - st,spear1310
+          - st,spear1340
+...
-- 
2.17.1
