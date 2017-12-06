From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  6 Dec 2017 11:22:27 +0100
Subject: [PATCH 32/61] ARM: dts: r8a7745: Add CAN[01] SoC support
In-Reply-To: <cover.1512555546.git.horms+renesas@verge.net.au>
References: <cover.1512555546.git.horms+renesas@verge.net.au>
Message-ID: <85d3122659be310c632ef1908532157ce82900ee.1512555546.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

Add the definitions for can0 and can1 to the SoC .dtsi.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7745.dtsi | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7745.dtsi b/arch/arm/boot/dts/r8a7745.dtsi
index 53eb1ce446a4..52f13246fc8a 100644
--- a/arch/arm/boot/dts/r8a7745.dtsi
+++ b/arch/arm/boot/dts/r8a7745.dtsi
@@ -1049,6 +1049,34 @@
 				#phy-cells = <1>;
 			};
 		};
+
+		can0: can at e6e80000 {
+			compatible = "renesas,can-r8a7745",
+				     "renesas,rcar-gen2-can";
+			reg = <0 0xe6e80000 0 0x1000>;
+			interrupts = <GIC_SPI 186 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 916>,
+				 <&cpg CPG_CORE R8A7745_CLK_RCAN>,
+				 <&can_clk>;
+			clock-names = "clkp1", "clkp2", "can_clk";
+			power-domains = <&sysc R8A7745_PD_ALWAYS_ON>;
+			resets = <&cpg 916>;
+			status = "disabled";
+		};
+
+		can1: can at e6e88000 {
+			compatible = "renesas,can-r8a7745",
+				     "renesas,rcar-gen2-can";
+			reg = <0 0xe6e88000 0 0x1000>;
+			interrupts = <GIC_SPI 187 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 915>,
+				 <&cpg CPG_CORE R8A7745_CLK_RCAN>,
+				 <&can_clk>;
+			clock-names = "clkp1", "clkp2", "can_clk";
+			power-domains = <&sysc R8A7745_PD_ALWAYS_ON>;
+			resets = <&cpg 915>;
+			status = "disabled";
+		};
 	};
 
 	/* External root clock */
@@ -1066,6 +1094,14 @@
 		clock-frequency = <48000000>;
 	};
 
+	/* External CAN clock */
+	can_clk: can {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		/* This value must be overridden by the board. */
+		clock-frequency = <0>;
+	};
+
 	/* External SCIF clock */
 	scif_clk: scif {
 		compatible = "fixed-clock";
-- 
2.11.0
