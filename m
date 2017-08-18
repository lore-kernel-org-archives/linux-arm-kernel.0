From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Fri, 18 Aug 2017 11:16:54 +0200
Subject: [PATCH v2 1/4] ARM: dts: r8a7790: Stop grouping clocks under a
 "clocks" subnode
In-Reply-To: <1503047817-29439-1-git-send-email-geert+renesas@glider.be>
References: <1503047817-29439-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1503047817-29439-2-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current practice is to not group clocks under a "clocks" subnode,
but just put them together with the other on-SoC devices.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a7790.dtsi | 137 ++++++++++++++++++++---------------------
 1 file changed, 66 insertions(+), 71 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index 5a31dfc0c3163d6c..70040c6c4ceac114 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -1061,77 +1061,72 @@
 		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 	};
 
-	clocks {
-		#address-cells = <2>;
-		#size-cells = <2>;
-		ranges;
-
-		/* External root clock */
-		extal_clk: extal {
-			compatible = "fixed-clock";
-			#clock-cells = <0>;
-			/* This value must be overriden by the board. */
-			clock-frequency = <0>;
-		};
-
-		/* External PCIe clock - can be overridden by the board */
-		pcie_bus_clk: pcie_bus {
-			compatible = "fixed-clock";
-			#clock-cells = <0>;
-			clock-frequency = <0>;
-		};
-
-		/*
-		 * The external audio clocks are configured as 0 Hz fixed frequency clocks by
-		 * default. Boards that provide audio clocks should override them.
-		 */
-		audio_clk_a: audio_clk_a {
-			compatible = "fixed-clock";
-			#clock-cells = <0>;
-			clock-frequency = <0>;
-		};
-		audio_clk_b: audio_clk_b {
-			compatible = "fixed-clock";
-			#clock-cells = <0>;
-			clock-frequency = <0>;
-		};
-		audio_clk_c: audio_clk_c {
-			compatible = "fixed-clock";
-			#clock-cells = <0>;
-			clock-frequency = <0>;
-		};
-
-		/* External SCIF clock */
-		scif_clk: scif {
-			compatible = "fixed-clock";
-			#clock-cells = <0>;
-			/* This value must be overridden by the board. */
-			clock-frequency = <0>;
-		};
-
-		/* External USB clock - can be overridden by the board */
-		usb_extal_clk: usb_extal {
-			compatible = "fixed-clock";
-			#clock-cells = <0>;
-			clock-frequency = <48000000>;
-		};
-
-		/* External CAN clock */
-		can_clk: can {
-			compatible = "fixed-clock";
-			#clock-cells = <0>;
-			/* This value must be overridden by the board. */
-			clock-frequency = <0>;
-		};
-
-		cpg: clock-controller at e6150000 {
-			compatible = "renesas,r8a7790-cpg-mssr";
-			reg = <0 0xe6150000 0 0x1000>;
-			clocks = <&extal_clk>, <&usb_extal_clk>;
-			clock-names = "extal", "usb_extal";
-			#clock-cells = <2>;
-			#power-domain-cells = <0>;
-		};
+	/* External root clock */
+	extal_clk: extal {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		/* This value must be overridden by the board. */
+		clock-frequency = <0>;
+	};
+
+	/* External PCIe clock - can be overridden by the board */
+	pcie_bus_clk: pcie_bus {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <0>;
+	};
+
+	/*
+	 * The external audio clocks are configured as 0 Hz fixed frequency
+	 * clocks by default.
+	 * Boards that provide audio clocks should override them.
+	 */
+	audio_clk_a: audio_clk_a {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <0>;
+	};
+	audio_clk_b: audio_clk_b {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <0>;
+	};
+	audio_clk_c: audio_clk_c {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <0>;
+	};
+
+	/* External SCIF clock */
+	scif_clk: scif {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		/* This value must be overridden by the board. */
+		clock-frequency = <0>;
+	};
+
+	/* External USB clock - can be overridden by the board */
+	usb_extal_clk: usb_extal {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <48000000>;
+	};
+
+	/* External CAN clock */
+	can_clk: can {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		/* This value must be overridden by the board. */
+		clock-frequency = <0>;
+	};
+
+	cpg: clock-controller at e6150000 {
+		compatible = "renesas,r8a7790-cpg-mssr";
+		reg = <0 0xe6150000 0 0x1000>;
+		clocks = <&extal_clk>, <&usb_extal_clk>;
+		clock-names = "extal", "usb_extal";
+		#clock-cells = <2>;
+		#power-domain-cells = <0>;
 	};
 
 	prr: chipid at ff000044 {
-- 
2.7.4
