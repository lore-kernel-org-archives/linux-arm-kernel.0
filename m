From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Wed, 21 May 2014 00:12:30 +0400
Subject: [PATCH v3 1/2] ARM: shmobile: r8a7790: add internal PCI bridge nodes
In-Reply-To: <201405210008.15145.sergei.shtylyov@cogentembedded.com>
References: <201405210008.15145.sergei.shtylyov@cogentembedded.com>
Message-ID: <201405210012.31347.sergei.shtylyov@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ben Dooks <ben.dooks@codethink.co.uk>

Add device nodes for the R8A7790 internal PCI bridge devices.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
Reviewed-by: Ian Molton <ian.molton@codethink.co.uk>
[Sergei: added interrupt-related properties to the PCI bridge nodes]
Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
Changes in version 3:
- added interrupt-related properties to the PCI bridge nodes;
- refreshed the patch.

Changes in version 2:
- reworded summary (fixing typo) and changelog;
- removed extra spaces before {;
- refreshed the patch.

 arch/arm/boot/dts/r8a7790.dtsi |   54 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

Index: renesas/arch/arm/boot/dts/r8a7790.dtsi
===================================================================
--- renesas.orig/arch/arm/boot/dts/r8a7790.dtsi
+++ renesas/arch/arm/boot/dts/r8a7790.dtsi
@@ -876,4 +876,58 @@
 		#size-cells = <0>;
 		status = "disabled";
 	};
+
+	pci0: pci at ee090000 {
+		compatible = "renesas,pci-r8a7790";
+		clocks = <&mstp7_clks R8A7790_CLK_EHCI>;
+		reg = <0x0 0xee090000 0x0 0xc00>,
+		      <0x0 0xee080000 0x0 0x1100>;
+		interrupts = <0 108 IRQ_TYPE_LEVEL_HIGH>;
+		status = "disabled";
+
+		bus-range = <0 0>;
+		#address-cells = <3>;
+		#size-cells = <2>;
+		#interrupt-cells = <1>;
+		interrupt-map-mask = <0xff00 0 0 0x7>;
+		interrupt-map = <0x0000 0 0 1 &gic 0 108 IRQ_TYPE_LEVEL_HIGH
+			      	 0x0800 0 0 1 &gic 0 108 IRQ_TYPE_LEVEL_HIGH
+			      	 0x1000 0 0 2 &gic 0 108 IRQ_TYPE_LEVEL_HIGH>;
+	};
+
+	pci1: pci at ee0b0000 {
+		compatible = "renesas,pci-r8a7790";
+		clocks = <&mstp7_clks R8A7790_CLK_EHCI>;
+		reg = <0x0 0xee0b0000 0x0 0xc00>,
+		      <0x0 0xee0a0000 0x0 0x1100>;
+		interrupts = <0 112 IRQ_TYPE_LEVEL_HIGH>;
+		status = "disabled";
+
+		bus-range = <1 1>;
+		#address-cells = <3>;
+		#size-cells = <2>;
+		#interrupt-cells = <1>;
+		interrupt-map-mask = <0xff00 0 0 0x7>;
+		interrupt-map = <0x0000 0 0 1 &gic 0 112 IRQ_TYPE_LEVEL_HIGH
+			      	 0x0800 0 0 1 &gic 0 112 IRQ_TYPE_LEVEL_HIGH
+			      	 0x1000 0 0 2 &gic 0 112 IRQ_TYPE_LEVEL_HIGH>;
+	};
+
+	pci2: pci at ee0d0000 {
+		compatible = "renesas,pci-r8a7790";
+		clocks = <&mstp7_clks R8A7790_CLK_EHCI>;
+		reg = <0x0 0xee0d0000 0x0 0xc00>,
+		      <0x0 0xee0c0000 0x0 0x1100>;
+		interrupts = <0 113 IRQ_TYPE_LEVEL_HIGH>;
+		status = "disabled";
+
+		bus-range = <2 2>;
+		#address-cells = <3>;
+		#size-cells = <2>;
+		#interrupt-cells = <1>;
+		interrupt-map-mask = <0xff00 0 0 0x7>;
+		interrupt-map = <0x0000 0 0 1 &gic 0 113 IRQ_TYPE_LEVEL_HIGH
+			      	 0x0800 0 0 1 &gic 0 113 IRQ_TYPE_LEVEL_HIGH
+			      	 0x1000 0 0 2 &gic 0 113 IRQ_TYPE_LEVEL_HIGH>;
+	};
 };
