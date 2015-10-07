From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  7 Oct 2015 10:57:40 +0900
Subject: [PATCH 03/28] ARM: shmobile: r8a7794: add GPIO DT support
In-Reply-To: <cover.1444182812.git.horms+renesas@verge.net.au>
References: <cover.1444182812.git.horms+renesas@verge.net.au>
Message-ID: <e8f5de3bea9e01fd1390d64bc915a11df919b3fe.1444182812.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Describe GPIO[0-6] controllers in the R8A7794 device tree.

Based on original patch by Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7794.dtsi | 91 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 91 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7794.dtsi b/arch/arm/boot/dts/r8a7794.dtsi
index b6db773b9e55..e9fab31e0709 100644
--- a/arch/arm/boot/dts/r8a7794.dtsi
+++ b/arch/arm/boot/dts/r8a7794.dtsi
@@ -50,6 +50,97 @@
 		interrupts = <1 9 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_HIGH)>;
 	};
 
+	gpio0: gpio at e6050000 {
+		compatible = "renesas,gpio-r8a7794", "renesas,gpio-rcar";
+		reg = <0 0xe6050000 0 0x50>;
+		interrupts = <0 4 IRQ_TYPE_LEVEL_HIGH>;
+		#gpio-cells = <2>;
+		gpio-controller;
+		gpio-ranges = <&pfc 0 0 32>;
+		#interrupt-cells = <2>;
+		interrupt-controller;
+		clocks = <&mstp9_clks R8A7794_CLK_GPIO0>;
+		power-domains = <&cpg_clocks>;
+	};
+
+	gpio1: gpio at e6051000 {
+		compatible = "renesas,gpio-r8a7794", "renesas,gpio-rcar";
+		reg = <0 0xe6051000 0 0x50>;
+		interrupts = <0 5 IRQ_TYPE_LEVEL_HIGH>;
+		#gpio-cells = <2>;
+		gpio-controller;
+		gpio-ranges = <&pfc 0 32 26>;
+		#interrupt-cells = <2>;
+		interrupt-controller;
+		clocks = <&mstp9_clks R8A7794_CLK_GPIO1>;
+		power-domains = <&cpg_clocks>;
+	};
+
+	gpio2: gpio at e6052000 {
+		compatible = "renesas,gpio-r8a7794", "renesas,gpio-rcar";
+		reg = <0 0xe6052000 0 0x50>;
+		interrupts = <0 6 IRQ_TYPE_LEVEL_HIGH>;
+		#gpio-cells = <2>;
+		gpio-controller;
+		gpio-ranges = <&pfc 0 64 32>;
+		#interrupt-cells = <2>;
+		interrupt-controller;
+		clocks = <&mstp9_clks R8A7794_CLK_GPIO2>;
+		power-domains = <&cpg_clocks>;
+	};
+
+	gpio3: gpio at e6053000 {
+		compatible = "renesas,gpio-r8a7794", "renesas,gpio-rcar";
+		reg = <0 0xe6053000 0 0x50>;
+		interrupts = <0 7 IRQ_TYPE_LEVEL_HIGH>;
+		#gpio-cells = <2>;
+		gpio-controller;
+		gpio-ranges = <&pfc 0 96 32>;
+		#interrupt-cells = <2>;
+		interrupt-controller;
+		clocks = <&mstp9_clks R8A7794_CLK_GPIO3>;
+		power-domains = <&cpg_clocks>;
+	};
+
+	gpio4: gpio at e6054000 {
+		compatible = "renesas,gpio-r8a7794", "renesas,gpio-rcar";
+		reg = <0 0xe6054000 0 0x50>;
+		interrupts = <0 8 IRQ_TYPE_LEVEL_HIGH>;
+		#gpio-cells = <2>;
+		gpio-controller;
+		gpio-ranges = <&pfc 0 128 32>;
+		#interrupt-cells = <2>;
+		interrupt-controller;
+		clocks = <&mstp9_clks R8A7794_CLK_GPIO4>;
+		power-domains = <&cpg_clocks>;
+	};
+
+	gpio5: gpio at e6055000 {
+		compatible = "renesas,gpio-r8a7794", "renesas,gpio-rcar";
+		reg = <0 0xe6055000 0 0x50>;
+		interrupts = <0 9 IRQ_TYPE_LEVEL_HIGH>;
+		#gpio-cells = <2>;
+		gpio-controller;
+		gpio-ranges = <&pfc 0 160 28>;
+		#interrupt-cells = <2>;
+		interrupt-controller;
+		clocks = <&mstp9_clks R8A7794_CLK_GPIO5>;
+		power-domains = <&cpg_clocks>;
+	};
+
+	gpio6: gpio at e6055400 {
+		compatible = "renesas,gpio-r8a7794", "renesas,gpio-rcar";
+		reg = <0 0xe6055400 0 0x50>;
+		interrupts = <0 10 IRQ_TYPE_LEVEL_HIGH>;
+		#gpio-cells = <2>;
+		gpio-controller;
+		gpio-ranges = <&pfc 0 192 26>;
+		#interrupt-cells = <2>;
+		interrupt-controller;
+		clocks = <&mstp9_clks R8A7794_CLK_GPIO6>;
+		power-domains = <&cpg_clocks>;
+	};
+
 	cmt0: timer at ffca0000 {
 		compatible = "renesas,cmt-48-gen2";
 		reg = <0 0xffca0000 0 0x1004>;
-- 
2.1.4
