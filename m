From: robh@kernel.org (Rob Herring)
Date: Fri,  5 Oct 2018 11:58:16 -0500
Subject: [PATCH 04/36] dt-bindings: arm: fsl: Move DCFG and SCFG bindings to
 their own docs
In-Reply-To: <20181005165848.3474-1-robh@kernel.org>
References: <20181005165848.3474-1-robh@kernel.org>
Message-ID: <20181005165848.3474-5-robh@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In preparation to convert board-level bindings to json-schema, move
various misc SoC bindings out to their own file.

Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: devicetree at vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../arm/freescale/fsl,layerscape-dcfg.txt     | 19 +++++++++
 .../arm/freescale/fsl,layerscape-scfg.txt     | 19 +++++++++
 Documentation/devicetree/bindings/arm/fsl.txt | 39 -------------------
 3 files changed, 38 insertions(+), 39 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/freescale/fsl,layerscape-dcfg.txt
 create mode 100644 Documentation/devicetree/bindings/arm/freescale/fsl,layerscape-scfg.txt

diff --git a/Documentation/devicetree/bindings/arm/freescale/fsl,layerscape-dcfg.txt b/Documentation/devicetree/bindings/arm/freescale/fsl,layerscape-dcfg.txt
new file mode 100644
index 000000000000..b5cb374dc47d
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/freescale/fsl,layerscape-dcfg.txt
@@ -0,0 +1,19 @@
+Freescale DCFG
+
+DCFG is the device configuration unit, that provides general purpose
+configuration and status for the device. Such as setting the secondary
+core start address and release the secondary core from holdoff and startup.
+
+Required properties:
+  - compatible: Should contain a chip-specific compatible string,
+	Chip-specific strings are of the form "fsl,<chip>-dcfg",
+	The following <chip>s are known to be supported:
+	ls1012a, ls1021a, ls1043a, ls1046a, ls2080a.
+
+  - reg : should contain base address and length of DCFG memory-mapped registers
+
+Example:
+	dcfg: dcfg at 1ee0000 {
+		compatible = "fsl,ls1021a-dcfg";
+		reg = <0x0 0x1ee0000 0x0 0x10000>;
+	};
diff --git a/Documentation/devicetree/bindings/arm/freescale/fsl,layerscape-scfg.txt b/Documentation/devicetree/bindings/arm/freescale/fsl,layerscape-scfg.txt
new file mode 100644
index 000000000000..0ab67b0b216d
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/freescale/fsl,layerscape-scfg.txt
@@ -0,0 +1,19 @@
+Freescale SCFG
+
+SCFG is the supplemental configuration unit, that provides SoC specific
+configuration and status registers for the chip. Such as getting PEX port
+status.
+
+Required properties:
+  - compatible: Should contain a chip-specific compatible string,
+	Chip-specific strings are of the form "fsl,<chip>-scfg",
+	The following <chip>s are known to be supported:
+	ls1012a, ls1021a, ls1043a, ls1046a, ls2080a.
+
+  - reg: should contain base address and length of SCFG memory-mapped registers
+
+Example:
+	scfg: scfg at 1570000 {
+		compatible = "fsl,ls1021a-scfg";
+		reg = <0x0 0x1570000 0x0 0x10000>;
+	};
diff --git a/Documentation/devicetree/bindings/arm/fsl.txt b/Documentation/devicetree/bindings/arm/fsl.txt
index 8a1baa2b9723..1e775aaa5c5b 100644
--- a/Documentation/devicetree/bindings/arm/fsl.txt
+++ b/Documentation/devicetree/bindings/arm/fsl.txt
@@ -101,45 +101,6 @@ Freescale LS1021A Platform Device Tree Bindings
 Required root node compatible properties:
   - compatible = "fsl,ls1021a";
 
-Freescale SoC-specific Device Tree Bindings
--------------------------------------------
-
-Freescale SCFG
-  SCFG is the supplemental configuration unit, that provides SoC specific
-configuration and status registers for the chip. Such as getting PEX port
-status.
-  Required properties:
-  - compatible: Should contain a chip-specific compatible string,
-	Chip-specific strings are of the form "fsl,<chip>-scfg",
-	The following <chip>s are known to be supported:
-	ls1012a, ls1021a, ls1043a, ls1046a, ls2080a.
-
-  - reg: should contain base address and length of SCFG memory-mapped registers
-
-Example:
-	scfg: scfg at 1570000 {
-		compatible = "fsl,ls1021a-scfg";
-		reg = <0x0 0x1570000 0x0 0x10000>;
-	};
-
-Freescale DCFG
-  DCFG is the device configuration unit, that provides general purpose
-configuration and status for the device. Such as setting the secondary
-core start address and release the secondary core from holdoff and startup.
-  Required properties:
-  - compatible: Should contain a chip-specific compatible string,
-	Chip-specific strings are of the form "fsl,<chip>-dcfg",
-	The following <chip>s are known to be supported:
-	ls1012a, ls1021a, ls1043a, ls1046a, ls2080a.
-
-  - reg : should contain base address and length of DCFG memory-mapped registers
-
-Example:
-	dcfg: dcfg at 1ee0000 {
-		compatible = "fsl,ls1021a-dcfg";
-		reg = <0x0 0x1ee0000 0x0 0x10000>;
-	};
-
 Freescale ARMv8 based Layerscape SoC family Device Tree Bindings
 ----------------------------------------------------------------
 
-- 
2.17.1
