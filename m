From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 19 Nov 2015 17:05:29 -0800
Subject: [PATCH 22/29] ARM: shmobile: r8a7793: Add GPIO nodes to device tree
In-Reply-To: <cover.1447981420.git.horms+renesas@verge.net.au>
References: <cover.1447981420.git.horms+renesas@verge.net.au>
Message-ID: <d96011d07728f7d66edf634407d2919e7708c5c3.1447981420.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm+renesas@opensource.se>

Add r8a7793 GPIO device nodes that are assumed to be identical
to r8a7791. This matches the data sheet for GPIO and MSTP bits.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7793.dtsi | 121 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 118 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7793.dtsi b/arch/arm/boot/dts/r8a7793.dtsi
index aa9b64c14a09..36b6d4e67f34 100644
--- a/arch/arm/boot/dts/r8a7793.dtsi
+++ b/arch/arm/boot/dts/r8a7793.dtsi
@@ -57,6 +57,110 @@
 		interrupts = <1 9 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_HIGH)>;
 	};
 
+	gpio0: gpio at e6050000 {
+		compatible = "renesas,gpio-r8a7793", "renesas,gpio-rcar";
+		reg = <0 0xe6050000 0 0x50>;
+		interrupts = <0 4 IRQ_TYPE_LEVEL_HIGH>;
+		#gpio-cells = <2>;
+		gpio-controller;
+		gpio-ranges = <&pfc 0 0 32>;
+		#interrupt-cells = <2>;
+		interrupt-controller;
+		clocks = <&mstp9_clks R8A7793_CLK_GPIO0>;
+		power-domains = <&cpg_clocks>;
+	};
+
+	gpio1: gpio at e6051000 {
+		compatible = "renesas,gpio-r8a7793", "renesas,gpio-rcar";
+		reg = <0 0xe6051000 0 0x50>;
+		interrupts = <0 5 IRQ_TYPE_LEVEL_HIGH>;
+		#gpio-cells = <2>;
+		gpio-controller;
+		gpio-ranges = <&pfc 0 32 26>;
+		#interrupt-cells = <2>;
+		interrupt-controller;
+		clocks = <&mstp9_clks R8A7793_CLK_GPIO1>;
+		power-domains = <&cpg_clocks>;
+	};
+
+	gpio2: gpio at e6052000 {
+		compatible = "renesas,gpio-r8a7793", "renesas,gpio-rcar";
+		reg = <0 0xe6052000 0 0x50>;
+		interrupts = <0 6 IRQ_TYPE_LEVEL_HIGH>;
+		#gpio-cells = <2>;
+		gpio-controller;
+		gpio-ranges = <&pfc 0 64 32>;
+		#interrupt-cells = <2>;
+		interrupt-controller;
+		clocks = <&mstp9_clks R8A7793_CLK_GPIO2>;
+		power-domains = <&cpg_clocks>;
+	};
+
+	gpio3: gpio at e6053000 {
+		compatible = "renesas,gpio-r8a7793", "renesas,gpio-rcar";
+		reg = <0 0xe6053000 0 0x50>;
+		interrupts = <0 7 IRQ_TYPE_LEVEL_HIGH>;
+		#gpio-cells = <2>;
+		gpio-controller;
+		gpio-ranges = <&pfc 0 96 32>;
+		#interrupt-cells = <2>;
+		interrupt-controller;
+		clocks = <&mstp9_clks R8A7793_CLK_GPIO3>;
+		power-domains = <&cpg_clocks>;
+	};
+
+	gpio4: gpio at e6054000 {
+		compatible = "renesas,gpio-r8a7793", "renesas,gpio-rcar";
+		reg = <0 0xe6054000 0 0x50>;
+		interrupts = <0 8 IRQ_TYPE_LEVEL_HIGH>;
+		#gpio-cells = <2>;
+		gpio-controller;
+		gpio-ranges = <&pfc 0 128 32>;
+		#interrupt-cells = <2>;
+		interrupt-controller;
+		clocks = <&mstp9_clks R8A7793_CLK_GPIO4>;
+		power-domains = <&cpg_clocks>;
+	};
+
+	gpio5: gpio at e6055000 {
+		compatible = "renesas,gpio-r8a7793", "renesas,gpio-rcar";
+		reg = <0 0xe6055000 0 0x50>;
+		interrupts = <0 9 IRQ_TYPE_LEVEL_HIGH>;
+		#gpio-cells = <2>;
+		gpio-controller;
+		gpio-ranges = <&pfc 0 160 32>;
+		#interrupt-cells = <2>;
+		interrupt-controller;
+		clocks = <&mstp9_clks R8A7793_CLK_GPIO5>;
+		power-domains = <&cpg_clocks>;
+	};
+
+	gpio6: gpio at e6055400 {
+		compatible = "renesas,gpio-r8a7793", "renesas,gpio-rcar";
+		reg = <0 0xe6055400 0 0x50>;
+		interrupts = <0 10 IRQ_TYPE_LEVEL_HIGH>;
+		#gpio-cells = <2>;
+		gpio-controller;
+		gpio-ranges = <&pfc 0 192 32>;
+		#interrupt-cells = <2>;
+		interrupt-controller;
+		clocks = <&mstp9_clks R8A7793_CLK_GPIO6>;
+		power-domains = <&cpg_clocks>;
+	};
+
+	gpio7: gpio at e6055800 {
+		compatible = "renesas,gpio-r8a7793", "renesas,gpio-rcar";
+		reg = <0 0xe6055800 0 0x50>;
+		interrupts = <0 11 IRQ_TYPE_LEVEL_HIGH>;
+		#gpio-cells = <2>;
+		gpio-controller;
+		gpio-ranges = <&pfc 0 224 26>;
+		#interrupt-cells = <2>;
+		interrupt-controller;
+		clocks = <&mstp9_clks R8A7793_CLK_GPIO7>;
+		power-domains = <&cpg_clocks>;
+	};
+
 	thermal at e61f0000 {
 		compatible = "renesas,thermal-r8a7793", "renesas,rcar-thermal";
 		reg = <0 0xe61f0000 0 0x14>, <0 0xe61f0100 0 0x38>;
@@ -484,10 +588,21 @@
 		mstp9_clks: mstp9_clks at e6150994 {
 			compatible = "renesas,r8a7793-mstp-clocks", "renesas,cpg-mstp-clocks";
 			reg = <0 0xe6150994 0 4>, <0 0xe61509a4 0 4>;
-			clocks = <&cpg_clocks R8A7793_CLK_QSPI>;
+			clocks = <&cp_clk>, <&cp_clk>, <&cp_clk>, <&cp_clk>,
+				 <&cp_clk>, <&cp_clk>, <&cp_clk>, <&cp_clk>,
+				 <&cpg_clocks R8A7793_CLK_QSPI>;
 			#clock-cells = <1>;
-			clock-indices = <R8A7793_CLK_QSPI_MOD>;
-			clock-output-names = "qspi_mod";
+			clock-indices = <
+				R8A7793_CLK_GPIO7 R8A7793_CLK_GPIO6
+				R8A7793_CLK_GPIO5 R8A7793_CLK_GPIO4
+				R8A7793_CLK_GPIO3 R8A7793_CLK_GPIO2
+				R8A7793_CLK_GPIO1 R8A7793_CLK_GPIO0
+				R8A7793_CLK_QSPI_MOD
+			>;
+			clock-output-names =
+				"gpio7", "gpio6", "gpio5", "gpio4",
+				"gpio3", "gpio2", "gpio1", "gpio0",
+				"qspi_mod";
 		};
 	};
 
-- 
2.1.4
