From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 26 Feb 2015 15:21:25 +0900
Subject: [PATCH 28/32] ARM: shmobile: r8a7791: add CAN DT support
In-Reply-To: <cover.1424849129.git.horms+renesas@verge.net.au>
References: <cover.1424849129.git.horms+renesas@verge.net.au>
Message-ID: <3cf0188461def8f732fefce3975cab0189220574.1424849129.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Define the generic R8A7791 parts of the CAN0/1 device nodes.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7791.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index 1ebffef..ff49b95 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -816,6 +816,26 @@
 		};
 	};
 
+	can0: can at e6e80000 {
+		compatible = "renesas,can-r8a7791";
+		reg = <0 0xe6e80000 0 0x1000>;
+		interrupts = <0 186 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp9_clks R8A7791_CLK_RCAN0>,
+			 <&cpg_clocks R8A7791_CLK_RCAN>, <&can_clk>;
+		clock-names = "clkp1", "clkp2", "can_clk";
+		status = "disabled";
+	};
+
+	can1: can at e6e88000 {
+		compatible = "renesas,can-r8a7791";
+		reg = <0 0xe6e88000 0 0x1000>;
+		interrupts = <0 187 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp9_clks R8A7791_CLK_RCAN1>,
+			 <&cpg_clocks R8A7791_CLK_RCAN>, <&can_clk>;
+		clock-names = "clkp1", "clkp2", "can_clk";
+		status = "disabled";
+	};
+
 	clocks {
 		#address-cells = <2>;
 		#size-cells = <2>;
-- 
2.1.4
