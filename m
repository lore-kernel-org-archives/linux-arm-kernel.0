From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Tue, 04 Aug 2015 00:39:14 +0300
Subject: [PATCH v2 2/2] ARM: shmobile: r8a7794: add GPIO DT support
In-Reply-To: <6388101.Drn6rL87rl@wasted.cogentembedded.com>
References: <6388101.Drn6rL87rl@wasted.cogentembedded.com>
Message-ID: <2762710.QvQ3jKvG4A@wasted.cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Describe GPIO[0-6] controllers in the R8A7794 device tree.

Based on original patch by Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

---
Changes in version 2:
- fixed "gpio-ranges" property's last value for GPIO1/5/6;
- added Geert's ACK.

 arch/arm/boot/dts/r8a7794.dtsi |   84 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 84 insertions(+)

Index: renesas/arch/arm/boot/dts/r8a7794.dtsi
===================================================================
--- renesas.orig/arch/arm/boot/dts/r8a7794.dtsi
+++ renesas/arch/arm/boot/dts/r8a7794.dtsi
@@ -50,6 +50,90 @@
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
+	};
+
 	cmt0: timer at ffca0000 {
 		compatible = "renesas,cmt-48-gen2";
 		reg = <0 0xffca0000 0 0x1004>;
