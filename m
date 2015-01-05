From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Tue, 06 Jan 2015 00:34:42 +0300
Subject: [PATCH v2 2/2] ARM: shmobile: r8a7790: add CAN DT support
In-Reply-To: <28994794.h3WeokSSG3@wasted.cogentembedded.com>
References: <28994794.h3WeokSSG3@wasted.cogentembedded.com>
Message-ID: <2103349.lorm0h2Cbt@wasted.cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define the generic R8A7790 parts of the CAN0/1 device nodes.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

---
Changes in version 2:
- fixed whitespace errors/warnings given by checkpatch.pl;
- added Geert's ACK.

 arch/arm/boot/dts/r8a7790.dtsi |   20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

Index: renesas/arch/arm/boot/dts/r8a7790.dtsi
===================================================================
--- renesas.orig/arch/arm/boot/dts/r8a7790.dtsi
+++ renesas/arch/arm/boot/dts/r8a7790.dtsi
@@ -792,6 +792,26 @@
 		};
 	};
 
+	can0: can at e6e80000 {
+		compatible = "renesas,can-r8a7790";
+		reg = <0 0xe6e80000 0 0x1000>;
+		interrupts = <0 186 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp9_clks R8A7790_CLK_RCAN0>,
+			 <&cpg_clocks R8A7790_CLK_RCAN>, <&can_clk>;
+		clock-names = "clkp1", "clkp2", "can_clk";
+		status = "disabled";
+	};
+
+	can1: can at e6e88000 {
+		compatible = "renesas,can-r8a7790";
+		reg = <0 0xe6e88000 0 0x1000>;
+		interrupts = <0 187 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp9_clks R8A7790_CLK_RCAN1>,
+			 <&cpg_clocks R8A7790_CLK_RCAN>, <&can_clk>;
+		clock-names = "clkp1", "clkp2", "can_clk";
+		status = "disabled";
+	};
+
 	clocks {
 		#address-cells = <2>;
 		#size-cells = <2>;
