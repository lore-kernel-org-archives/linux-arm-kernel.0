From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 15 Mar 2016 09:26:34 +0900
Subject: [PATCH v2 2/2] ARM: dts: r8a7794: add CAN nodes to device tree
In-Reply-To: <1458001594-632-1-git-send-email-horms+renesas@verge.net.au>
References: <1458001594-632-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1458001594-632-3-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add CAN nodes to r8a7794 device tree.

Based on work by Sergei Shtylyov for the r8a7791 SoC.

Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2
* Added Reviewed-by from Geert Uytterhoeven
---
 arch/arm/boot/dts/r8a7794.dtsi | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7794.dtsi b/arch/arm/boot/dts/r8a7794.dtsi
index e7a3c792c97c..97181b228aa3 100644
--- a/arch/arm/boot/dts/r8a7794.dtsi
+++ b/arch/arm/boot/dts/r8a7794.dtsi
@@ -830,6 +830,28 @@
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
