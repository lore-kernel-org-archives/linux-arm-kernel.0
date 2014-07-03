From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Thu, 3 Jul 2014 23:38:42 +0400
Subject: [PATCH v2 1/2] ARM: shmobile: r8a7791: add CAN DT support
In-Reply-To: <201407032337.03509.sergei.shtylyov@cogentembedded.com>
References: <201407032337.03509.sergei.shtylyov@cogentembedded.com>
Message-ID: <201407032338.43409.sergei.shtylyov@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define the generic R8A7791 parts of the CAN0/1 device nodes.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
Changes in version 2:
- fixed the "compatible" property in the CAN device nodes.

 arch/arm/boot/dts/r8a7791.dtsi |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)

Index: renesas/arch/arm/boot/dts/r8a7791.dtsi
===================================================================
--- renesas.orig/arch/arm/boot/dts/r8a7791.dtsi
+++ renesas/arch/arm/boot/dts/r8a7791.dtsi
@@ -518,6 +518,22 @@
 		status = "disabled";
 	};
 
+	can0: can at e6e80000 {
+		compatible = "renesas,can-r8a7791";
+		reg = <0 0xe6e80000 0 0x1000>;
+		interrupts = <0 186 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp9_clks R8A7791_CLK_RCAN0>;
+		status = "disabled";
+	};
+
+	can1: can at e6e88000 {
+		compatible = "renesas,can-r8a7791";
+		reg = <0 0xe6e88000 0 0x1000>;
+		interrupts = <0 187 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp9_clks R8A7791_CLK_RCAN1>;
+		status = "disabled";
+	};
+
 	clocks {
 		#address-cells = <2>;
 		#size-cells = <2>;
