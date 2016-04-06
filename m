From: Minghuan.Lian@nxp.com (Minghuan Lian)
Date: Wed, 6 Apr 2016 19:02:07 +0800
Subject: [PATCH] ARM: dts: ls1021a: add SCFG MSI dts node
Message-ID: <1459940527-26437-1-git-send-email-Minghuan.Lian@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add SCFG MSI dts node and add msi-parent property to PCIe dts node
that points to the corresponding MSI node.

Signed-off-by: Minghuan Lian <Minghuan.Lian@nxp.com>
---
 arch/arm/boot/dts/ls1021a.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/ls1021a.dtsi b/arch/arm/boot/dts/ls1021a.dtsi
index 726372d..c0dee50 100644
--- a/arch/arm/boot/dts/ls1021a.dtsi
+++ b/arch/arm/boot/dts/ls1021a.dtsi
@@ -119,6 +119,20 @@
 
 		};
 
+		msi1: msi-controller at 1570e00 {
+			compatible = "fsl,1s1021a-msi";
+			reg = <0x0 0x1570e00 0x0 0x8>;
+			msi-controller;
+			interrupts =  <GIC_SPI 179 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
+		msi2: msi-controller at 1570e08 {
+			compatible = "fsl,1s1021a-msi";
+			reg = <0x0 0x1570e08 0x0 0x8>;
+			msi-controller;
+			interrupts = <GIC_SPI 180 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
 		ifc: ifc at 1530000 {
 			compatible = "fsl,ifc", "simple-bus";
 			reg = <0x0 0x1530000 0x0 0x10000>;
@@ -587,6 +601,7 @@
 			bus-range = <0x0 0xff>;
 			ranges = <0x81000000 0x0 0x00000000 0x40 0x00010000 0x0 0x00010000   /* downstream I/O */
 				  0x82000000 0x0 0x40000000 0x40 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
+			msi-parent = <&msi1>;
 			#interrupt-cells = <1>;
 			interrupt-map-mask = <0 0 0 7>;
 			interrupt-map = <0000 0 0 1 &gic GIC_SPI 91  IRQ_TYPE_LEVEL_HIGH>,
@@ -609,6 +624,7 @@
 			bus-range = <0x0 0xff>;
 			ranges = <0x81000000 0x0 0x00000000 0x48 0x00010000 0x0 0x00010000   /* downstream I/O */
 				  0x82000000 0x0 0x40000000 0x48 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
+			msi-parent = <&msi2>;
 			#interrupt-cells = <1>;
 			interrupt-map-mask = <0 0 0 7>;
 			interrupt-map = <0000 0 0 1 &gic GIC_SPI 92  IRQ_TYPE_LEVEL_HIGH>,
-- 
1.9.1
