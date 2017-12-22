From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 22 Dec 2017 11:29:16 +0100
Subject: [PATCH 05/11] arm64: dts: renesas: r8a7796: sort subnodes of root
 node alphabetically
In-Reply-To: <cover.1513936760.git.horms+renesas@verge.net.au>
References: <cover.1513936760.git.horms+renesas@verge.net.au>
Message-ID: <9d51ffc55dc1762a6300eaffd270c0aadd7b353b.1513936761.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sort root sub-nodes alphabetically for allow for easier maintenance
of this file.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm64/boot/dts/renesas/r8a7796.dtsi | 66 ++++++++++++++++----------------
 1 file changed, 33 insertions(+), 33 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a7796.dtsi b/arch/arm64/boot/dts/renesas/r8a7796.dtsi
index cc0cca7c0494..c1b0d0344329 100644
--- a/arch/arm64/boot/dts/renesas/r8a7796.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7796.dtsi
@@ -30,9 +30,34 @@
 		i2c7 = &i2c_dvfs;
 	};
 
-	psci {
-		compatible = "arm,psci-1.0", "arm,psci-0.2";
-		method = "smc";
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
+
+	audio_clk_b: audio_clk_b {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <0>;
+	};
+
+	audio_clk_c: audio_clk_c {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <0>;
+	};
+
+	/* External CAN clock - to be overridden by boards that provide it */
+	can_clk: can {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <0>;
 	};
 
 	cpus {
@@ -122,34 +147,16 @@
 		clock-frequency = <0>;
 	};
 
-	/*
-	 * The external audio clocks are configured as 0 Hz fixed frequency
-	 * clocks by default.
-	 * Boards that provide audio clocks should override them.
-	 */
-	audio_clk_a: audio_clk_a {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		clock-frequency = <0>;
-	};
-
-	audio_clk_b: audio_clk_b {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		clock-frequency = <0>;
-	};
-
-	audio_clk_c: audio_clk_c {
+	/* External PCIe clock - can be overridden by the board */
+	pcie_bus_clk: pcie_bus {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
 		clock-frequency = <0>;
 	};
 
-	/* External CAN clock - to be overridden by boards that provide it */
-	can_clk: can {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		clock-frequency = <0>;
+	psci {
+		compatible = "arm,psci-1.0", "arm,psci-0.2";
+		method = "smc";
 	};
 
 	/* External SCIF clock - to be overridden by boards that provide it */
@@ -159,13 +166,6 @@
 		clock-frequency = <0>;
 	};
 
-	/* External PCIe clock - can be overridden by the board */
-	pcie_bus_clk: pcie_bus {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		clock-frequency = <0>;
-	};
-
 	soc {
 		compatible = "simple-bus";
 		interrupt-parent = <&gic>;
-- 
2.11.0
