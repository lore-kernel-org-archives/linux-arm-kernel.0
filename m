From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon,  4 Apr 2016 10:22:22 +0900
Subject: [PATCH 2/3] arm64: dts: r8a7795: Add CAN support
In-Reply-To: <cover.1459731817.git.horms+renesas@verge.net.au>
References: <cover.1459731817.git.horms+renesas@verge.net.au>
Message-ID: <308b7e4ba62e2ab60efcaf426cc219d591f0cd28.1459731817.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>

Adds CAN controller nodes for r8a7795.

Note: CAN channel register base address mentioned in R-Car Gen3 Hardware
User Manual v0.5E is incorrect. The corrected base addresses are:

CAN Channel 0 - 0xe6c30000
CAN Channel 1 - 0xe6c38000

Signed-off-by: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a7795.dtsi | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index 4049182e6608..a88f8d840c48 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -523,6 +523,36 @@
 			#size-cells = <0>;
 		};
 
+		can0: can at e6c30000 {
+			compatible = "renesas,can-r8a7795",
+				     "renesas,rcar-gen3-can";
+			reg = <0 0xe6c30000 0 0x1000>;
+			interrupts = <GIC_SPI 186 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 916>,
+			       <&cpg CPG_CORE R8A7795_CLK_CANFD>,
+			       <&can_clk>;
+			clock-names = "clkp1", "clkp2", "can_clk";
+			assigned-clocks = <&cpg CPG_CORE R8A7795_CLK_CANFD>;
+			assigned-clock-rates = <40000000>;
+			power-domains = <&cpg>;
+			status = "disabled";
+		};
+
+		can1: can at e6c38000 {
+			compatible = "renesas,can-r8a7795",
+				     "renesas,rcar-gen3-can";
+			reg = <0 0xe6c38000 0 0x1000>;
+			interrupts = <GIC_SPI 187 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 915>,
+			       <&cpg CPG_CORE R8A7795_CLK_CANFD>,
+			       <&can_clk>;
+			clock-names = "clkp1", "clkp2", "can_clk";
+			assigned-clocks = <&cpg CPG_CORE R8A7795_CLK_CANFD>;
+			assigned-clock-rates = <40000000>;
+			power-domains = <&cpg>;
+			status = "disabled";
+		};
+
 		hscif0: serial at e6540000 {
 			compatible = "renesas,hscif-r8a7795",
 				     "renesas,rcar-gen3-hscif",
-- 
2.1.4
