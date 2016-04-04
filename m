From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon,  4 Apr 2016 10:23:11 +0900
Subject: [PATCH 39/47] ARM: dts: r8a7794: add CAN nodes to device tree
In-Reply-To: <cover.1459732726.git.horms+renesas@verge.net.au>
References: <cover.1459732726.git.horms+renesas@verge.net.au>
Message-ID: <9ec604b952b8f5f2d0fecf0cdc4586642bf6da70.1459732726.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add CAN nodes to r8a7794 device tree.

Based on work by Sergei Shtylyov for the r8a7791 SoC.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>
---
 arch/arm/boot/dts/r8a7794.dtsi | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7794.dtsi b/arch/arm/boot/dts/r8a7794.dtsi
index 840971ce48f2..e2a4b6bd16a0 100644
--- a/arch/arm/boot/dts/r8a7794.dtsi
+++ b/arch/arm/boot/dts/r8a7794.dtsi
@@ -859,6 +859,28 @@
 		};
 	};
 
+	can0: can at e6e80000 {
+		compatible = "renesas,can-r8a7794", "renesas,rcar-gen2-can";
+		reg = <0 0xe6e80000 0 0x1000>;
+		interrupts = <GIC_SPI 186 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp9_clks R8A7794_CLK_RCAN0>,
+			 <&cpg_clocks R8A7794_CLK_RCAN>, <&can_clk>;
+		clock-names = "clkp1", "clkp2", "can_clk";
+		power-domains = <&cpg_clocks>;
+		status = "disabled";
+	};
+
+	can1: can at e6e88000 {
+		compatible = "renesas,can-r8a7794", "renesas,rcar-gen2-can";
+		reg = <0 0xe6e88000 0 0x1000>;
+		interrupts = <GIC_SPI 187 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp9_clks R8A7794_CLK_RCAN1>,
+			 <&cpg_clocks R8A7794_CLK_RCAN>, <&can_clk>;
+		clock-names = "clkp1", "clkp2", "can_clk";
+		power-domains = <&cpg_clocks>;
+		status = "disabled";
+	};
+
 	clocks {
 		#address-cells = <2>;
 		#size-cells = <2>;
-- 
2.1.4
