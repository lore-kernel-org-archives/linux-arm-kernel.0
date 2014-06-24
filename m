From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Tue, 24 Jun 2014 22:10:05 +0400
Subject: [PATCH v4 1/3] ARM: shmobile: r8a7791: add internal PCI bridge nodes
In-Reply-To: <201406242207.32790.sergei.shtylyov@cogentembedded.com>
References: <201406242207.32790.sergei.shtylyov@cogentembedded.com>
Message-ID: <201406242210.06194.sergei.shtylyov@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add device nodes for the R8A7791 internal PCI bridge devices.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
Changes in version 4:
- added "device_type" and "ranges" properties to the PCI bridge nodes;
- removed "0x" prefix from zero values in the "reg" properties.

Changes in version 3:
- refreshed the patch.

Changes in version 2:
- added interrupt-related properties to the PCI device nodes;
- refreshed the patch.

 arch/arm/boot/dts/r8a7791.dtsi |   40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

Index: renesas/arch/arm/boot/dts/r8a7791.dtsi
===================================================================
--- renesas.orig/arch/arm/boot/dts/r8a7791.dtsi
+++ renesas/arch/arm/boot/dts/r8a7791.dtsi
@@ -961,6 +961,46 @@
 		status = "disabled";
 	};
 
+	pci0: pci at ee090000 {
+		compatible = "renesas,pci-r8a7791";
+		device_type = "pci";
+		clocks = <&mstp7_clks R8A7791_CLK_EHCI>;
+		reg = <0 0xee090000 0 0xc00>,
+		      <0 0xee080000 0 0x1100>;
+		interrupts = <0 108 IRQ_TYPE_LEVEL_HIGH>;
+		status = "disabled";
+
+		bus-range = <0 0>;
+		#address-cells = <3>;
+		#size-cells = <2>;
+		#interrupt-cells = <1>;
+		ranges = <0x02000000 0 0xee080000 0 0xee080000 0 0x00010000>;
+		interrupt-map-mask = <0xff00 0 0 0x7>;
+		interrupt-map = <0x0000 0 0 1 &gic 0 108 IRQ_TYPE_LEVEL_HIGH
+			      	 0x0800 0 0 1 &gic 0 108 IRQ_TYPE_LEVEL_HIGH
+			      	 0x1000 0 0 2 &gic 0 108 IRQ_TYPE_LEVEL_HIGH>;
+	};
+
+	pci1: pci at ee0d0000 {
+		compatible = "renesas,pci-r8a7791";
+		device_type = "pci";
+		clocks = <&mstp7_clks R8A7791_CLK_EHCI>;
+		reg = <0 0xee0d0000 0 0xc00>,
+		      <0 0xee0c0000 0 0x1100>;
+		interrupts = <0 113 IRQ_TYPE_LEVEL_HIGH>;
+		status = "disabled";
+
+		bus-range = <1 1>;
+		#address-cells = <3>;
+		#size-cells = <2>;
+		#interrupt-cells = <1>;
+		ranges = <0x02000000 0 0xee0c0000 0 0xee0c0000 0 0x00010000>;
+		interrupt-map-mask = <0xff00 0 0 0x7>;
+		interrupt-map = <0x0000 0 0 1 &gic 0 113 IRQ_TYPE_LEVEL_HIGH
+			      	 0x0800 0 0 1 &gic 0 113 IRQ_TYPE_LEVEL_HIGH
+			      	 0x1000 0 0 2 &gic 0 113 IRQ_TYPE_LEVEL_HIGH>;
+	};
+
 	pciec: pcie at fe000000 {
 		compatible = "renesas,pcie-r8a7791";
 		reg = <0 0xfe000000 0 0x80000>;
