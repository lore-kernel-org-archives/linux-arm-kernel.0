From: robh@kernel.org (Rob Herring)
Date: Fri,  5 Oct 2018 11:58:36 -0500
Subject: [PATCH 24/36] dt-bindings: arm: Convert TI nspire board/soc bindings
 to json-schema
In-Reply-To: <20181005165848.3474-1-robh@kernel.org>
References: <20181005165848.3474-1-robh@kernel.org>
Message-ID: <20181005165848.3474-25-robh@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert TI NSpire SoC bindings to DT schema format using json-schema.

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: devicetree at vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/arm/nspire.txt        | 14 -----------
 .../devicetree/bindings/arm/ti/nspire.yaml    | 24 +++++++++++++++++++
 2 files changed, 24 insertions(+), 14 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/nspire.txt
 create mode 100644 Documentation/devicetree/bindings/arm/ti/nspire.yaml

diff --git a/Documentation/devicetree/bindings/arm/nspire.txt b/Documentation/devicetree/bindings/arm/nspire.txt
deleted file mode 100644
index 4d08518bd176..000000000000
--- a/Documentation/devicetree/bindings/arm/nspire.txt
+++ /dev/null
@@ -1,14 +0,0 @@
-TI-NSPIRE calculators
-
-Required properties:
-- compatible: Compatible property value should contain "ti,nspire".
-	CX models should have "ti,nspire-cx"
-	Touchpad models should have "ti,nspire-tp"
-	Clickpad models should have "ti,nspire-clp"
-
-Example:
-
-/ {
-	model = "TI-NSPIRE CX";
-	compatible = "ti,nspire-cx";
-	...
diff --git a/Documentation/devicetree/bindings/arm/ti/nspire.yaml b/Documentation/devicetree/bindings/arm/ti/nspire.yaml
new file mode 100644
index 000000000000..882f79f95942
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/ti/nspire.yaml
@@ -0,0 +1,24 @@
+# SPDX-License-Identifier: None
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/bindings/arm/nspire.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: TI-NSPIRE calculators
+
+maintainers:
+  - Daniel Tang <dt.tangr@gmail.com>
+
+properties:
+  $nodename:
+    const: '/'
+  compatible:
+    items:
+      - enum:
+          # CX models
+          - ti,nspire-cx
+          # Touchpad models
+          - ti,nspire-tp
+          # Clickpad models
+          - ti,nspire-clp
+...
-- 
2.17.1
