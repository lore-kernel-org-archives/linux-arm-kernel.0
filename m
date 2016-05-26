From: po.liu@nxp.com (Po Liu)
Date: Thu, 26 May 2016 13:59:09 +0800
Subject: [PATCH 1/2] freescale/dts: add pcie aer interrupt-name property in
 the dts
Message-ID: <1464242349-15323-1-git-send-email-po.liu@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Freescale some platforms aer interrupt was not MSI/MSI-X/INTx
but using interrupt line independently. This patch add a "aer"
interrupt-names for aer interrupt.

Signed-off-by: Po Liu <po.liu@nxp.com>
---
 .../devicetree/bindings/pci/layerscape-pci.txt         |  2 +-
 arch/arm/boot/dts/ls1021a.dtsi                         |  6 ++++--
 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi         | 18 +++++++++---------
 arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi         | 16 ++++++++--------
 4 files changed, 22 insertions(+), 20 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/layerscape-pci.txt b/Documentation/devicetree/bindings/pci/layerscape-pci.txt
index ef683b2..858b407 100644
--- a/Documentation/devicetree/bindings/pci/layerscape-pci.txt
+++ b/Documentation/devicetree/bindings/pci/layerscape-pci.txt
@@ -19,7 +19,7 @@ Required properties:
 - interrupts: A list of interrupt outputs of the controller. Must contain an
   entry for each entry in the interrupt-names property.
 - interrupt-names: Must include the following entries:
-  "intr": The interrupt that is asserted for controller interrupts
+  "aer" : The interrupt that is asserted for aer interrupts
 - fsl,pcie-scfg: Must include two entries.
   The first entry must be a link to the SCFG device node
   The second entry must be '0' or '1' based on physical PCIe controller index.
diff --git a/arch/arm/boot/dts/ls1021a.dtsi b/arch/arm/boot/dts/ls1021a.dtsi
index 5ae8e92..b638697 100644
--- a/arch/arm/boot/dts/ls1021a.dtsi
+++ b/arch/arm/boot/dts/ls1021a.dtsi
@@ -633,7 +633,8 @@
 			reg = <0x00 0x03400000 0x0 0x00010000   /* controller registers */
 			       0x40 0x00000000 0x0 0x00002000>; /* configuration space */
 			reg-names = "regs", "config";
-			interrupts = <GIC_SPI 177 IRQ_TYPE_LEVEL_HIGH>; /* controller interrupt */
+			interrupts = <GIC_SPI 183 IRQ_TYPE_LEVEL_HIGH>; /* aer interrupt */
+			interrupt-names = "aer";
 			fsl,pcie-scfg = <&scfg 0>;
 			#address-cells = <3>;
 			#size-cells = <2>;
@@ -656,7 +657,8 @@
 			reg = <0x00 0x03500000 0x0 0x00010000   /* controller registers */
 			       0x48 0x00000000 0x0 0x00002000>; /* configuration space */
 			reg-names = "regs", "config";
-			interrupts = <GIC_SPI 178 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>; /* aer interrupt */
+			interrupt-names = "aer";
 			fsl,pcie-scfg = <&scfg 1>;
 			#address-cells = <3>;
 			#size-cells = <2>;
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
index de0323b..4beb760 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
@@ -473,9 +473,9 @@
 			reg = <0x00 0x03400000 0x0 0x00100000   /* controller registers */
 			       0x40 0x00000000 0x0 0x00002000>; /* configuration space */
 			reg-names = "regs", "config";
-			interrupts = <0 118 0x4>, /* controller interrupt */
-				     <0 117 0x4>; /* PME interrupt */
-			interrupt-names = "intr", "pme";
+			interrupts = <0 117 0x4>, /* PME interrupt */
+					 <0 118 0x4>; /* aer interrupt */
+			interrupt-names = "pme", "aer";
 			#address-cells = <3>;
 			#size-cells = <2>;
 			device_type = "pci";
@@ -497,9 +497,9 @@
 			reg = <0x00 0x03500000 0x0 0x00100000   /* controller registers */
 			       0x48 0x00000000 0x0 0x00002000>; /* configuration space */
 			reg-names = "regs", "config";
-			interrupts = <0 128 0x4>,
-				     <0 127 0x4>;
-			interrupt-names = "intr", "pme";
+			interrupts = <0 127 0x4>,
+					 <0 128 0x4>;
+			interrupt-names = "pme", "aer";
 			#address-cells = <3>;
 			#size-cells = <2>;
 			device_type = "pci";
@@ -521,9 +521,9 @@
 			reg = <0x00 0x03600000 0x0 0x00100000   /* controller registers */
 			       0x50 0x00000000 0x0 0x00002000>; /* configuration space */
 			reg-names = "regs", "config";
-			interrupts = <0 162 0x4>,
-				     <0 161 0x4>;
-			interrupt-names = "intr", "pme";
+			interrupts = <0 161 0x4>,
+					 <0 162 0x4>;
+			interrupt-names = "pme", "aer";
 			#address-cells = <3>;
 			#size-cells = <2>;
 			device_type = "pci";
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi
index 3187c82..6edf24b 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi
@@ -559,8 +559,8 @@
 			reg = <0x00 0x03400000 0x0 0x00100000   /* controller registers */
 			       0x10 0x00000000 0x0 0x00002000>; /* configuration space */
 			reg-names = "regs", "config";
-			interrupts = <0 108 0x4>; /* Level high type */
-			interrupt-names = "intr";
+			interrupts = <0 108 0x4>; /* aer interrupt */
+			interrupt-names = "aer";
 			#address-cells = <3>;
 			#size-cells = <2>;
 			device_type = "pci";
@@ -583,8 +583,8 @@
 			reg = <0x00 0x03500000 0x0 0x00100000   /* controller registers */
 			       0x12 0x00000000 0x0 0x00002000>; /* configuration space */
 			reg-names = "regs", "config";
-			interrupts = <0 113 0x4>; /* Level high type */
-			interrupt-names = "intr";
+			interrupts = <0 113 0x4>; /* aer interrupt */
+			interrupt-names = "aer";
 			#address-cells = <3>;
 			#size-cells = <2>;
 			device_type = "pci";
@@ -607,8 +607,8 @@
 			reg = <0x00 0x03600000 0x0 0x00100000   /* controller registers */
 			       0x14 0x00000000 0x0 0x00002000>; /* configuration space */
 			reg-names = "regs", "config";
-			interrupts = <0 118 0x4>; /* Level high type */
-			interrupt-names = "intr";
+			interrupts = <0 118 0x4>; /* aer interrupt */
+			interrupt-names = "aer";
 			#address-cells = <3>;
 			#size-cells = <2>;
 			device_type = "pci";
@@ -631,8 +631,8 @@
 			reg = <0x00 0x03700000 0x0 0x00100000   /* controller registers */
 			       0x16 0x00000000 0x0 0x00002000>; /* configuration space */
 			reg-names = "regs", "config";
-			interrupts = <0 123 0x4>; /* Level high type */
-			interrupt-names = "intr";
+			interrupts = <0 123 0x4>; /* aer interrupt */
+			interrupt-names = "aer";
 			#address-cells = <3>;
 			#size-cells = <2>;
 			device_type = "pci";
-- 
2.1.0.27.g96db324
