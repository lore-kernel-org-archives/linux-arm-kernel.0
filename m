From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue,  5 Jan 2016 09:15:41 +1100
Subject: [PATCH] ARM: shmobile: r8a7793: move dmac nodes
Message-ID: <1451945741-17373-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move dmac nodes in the r8a7793 device tree to match their location
in the r8a7791 device tree to aid comparison between the device
trees of these similar SoCs.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

---
* This was the intention when the dmac nodes where added but
  somehow something went astray.
---
 arch/arm/boot/dts/r8a7793.dtsi | 124 ++++++++++++++++++++---------------------
 1 file changed, 62 insertions(+), 62 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7793.dtsi b/arch/arm/boot/dts/r8a7793.dtsi
index f9d92de4f65b..0ce7cc420c9d 100644
--- a/arch/arm/boot/dts/r8a7793.dtsi
+++ b/arch/arm/boot/dts/r8a7793.dtsi
@@ -239,6 +239,68 @@
 		power-domains = <&cpg_clocks>;
 	};
 
+	dmac0: dma-controller at e6700000 {
+		compatible = "renesas,dmac-r8a7793", "renesas,rcar-dmac";
+		reg = <0 0xe6700000 0 0x20000>;
+		interrupts = <0 197 IRQ_TYPE_LEVEL_HIGH
+			      0 200 IRQ_TYPE_LEVEL_HIGH
+			      0 201 IRQ_TYPE_LEVEL_HIGH
+			      0 202 IRQ_TYPE_LEVEL_HIGH
+			      0 203 IRQ_TYPE_LEVEL_HIGH
+			      0 204 IRQ_TYPE_LEVEL_HIGH
+			      0 205 IRQ_TYPE_LEVEL_HIGH
+			      0 206 IRQ_TYPE_LEVEL_HIGH
+			      0 207 IRQ_TYPE_LEVEL_HIGH
+			      0 208 IRQ_TYPE_LEVEL_HIGH
+			      0 209 IRQ_TYPE_LEVEL_HIGH
+			      0 210 IRQ_TYPE_LEVEL_HIGH
+			      0 211 IRQ_TYPE_LEVEL_HIGH
+			      0 212 IRQ_TYPE_LEVEL_HIGH
+			      0 213 IRQ_TYPE_LEVEL_HIGH
+			      0 214 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "error",
+				"ch0", "ch1", "ch2", "ch3",
+				"ch4", "ch5", "ch6", "ch7",
+				"ch8", "ch9", "ch10", "ch11",
+				"ch12", "ch13", "ch14";
+		clocks = <&mstp2_clks R8A7793_CLK_SYS_DMAC0>;
+		clock-names = "fck";
+		power-domains = <&cpg_clocks>;
+		#dma-cells = <1>;
+		dma-channels = <15>;
+	};
+
+	dmac1: dma-controller at e6720000 {
+		compatible = "renesas,dmac-r8a7793", "renesas,rcar-dmac";
+		reg = <0 0xe6720000 0 0x20000>;
+		interrupts = <0 220 IRQ_TYPE_LEVEL_HIGH
+			      0 216 IRQ_TYPE_LEVEL_HIGH
+			      0 217 IRQ_TYPE_LEVEL_HIGH
+			      0 218 IRQ_TYPE_LEVEL_HIGH
+			      0 219 IRQ_TYPE_LEVEL_HIGH
+			      0 308 IRQ_TYPE_LEVEL_HIGH
+			      0 309 IRQ_TYPE_LEVEL_HIGH
+			      0 310 IRQ_TYPE_LEVEL_HIGH
+			      0 311 IRQ_TYPE_LEVEL_HIGH
+			      0 312 IRQ_TYPE_LEVEL_HIGH
+			      0 313 IRQ_TYPE_LEVEL_HIGH
+			      0 314 IRQ_TYPE_LEVEL_HIGH
+			      0 315 IRQ_TYPE_LEVEL_HIGH
+			      0 316 IRQ_TYPE_LEVEL_HIGH
+			      0 317 IRQ_TYPE_LEVEL_HIGH
+			      0 318 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "error",
+				"ch0", "ch1", "ch2", "ch3",
+				"ch4", "ch5", "ch6", "ch7",
+				"ch8", "ch9", "ch10", "ch11",
+				"ch12", "ch13", "ch14";
+		clocks = <&mstp2_clks R8A7793_CLK_SYS_DMAC1>;
+		clock-names = "fck";
+		power-domains = <&cpg_clocks>;
+		#dma-cells = <1>;
+		dma-channels = <15>;
+	};
+
 	/* The memory map in the User's Manual maps the cores to bus numbers */
 	i2c0: i2c at e6508000 {
 		#address-cells = <1>;
@@ -358,68 +420,6 @@
 		reg = <0 0xe6060000 0 0x250>;
 	};
 
-	dmac0: dma-controller at e6700000 {
-		compatible = "renesas,dmac-r8a7793", "renesas,rcar-dmac";
-		reg = <0 0xe6700000 0 0x20000>;
-		interrupts = <0 197 IRQ_TYPE_LEVEL_HIGH
-			      0 200 IRQ_TYPE_LEVEL_HIGH
-			      0 201 IRQ_TYPE_LEVEL_HIGH
-			      0 202 IRQ_TYPE_LEVEL_HIGH
-			      0 203 IRQ_TYPE_LEVEL_HIGH
-			      0 204 IRQ_TYPE_LEVEL_HIGH
-			      0 205 IRQ_TYPE_LEVEL_HIGH
-			      0 206 IRQ_TYPE_LEVEL_HIGH
-			      0 207 IRQ_TYPE_LEVEL_HIGH
-			      0 208 IRQ_TYPE_LEVEL_HIGH
-			      0 209 IRQ_TYPE_LEVEL_HIGH
-			      0 210 IRQ_TYPE_LEVEL_HIGH
-			      0 211 IRQ_TYPE_LEVEL_HIGH
-			      0 212 IRQ_TYPE_LEVEL_HIGH
-			      0 213 IRQ_TYPE_LEVEL_HIGH
-			      0 214 IRQ_TYPE_LEVEL_HIGH>;
-		interrupt-names = "error",
-				"ch0", "ch1", "ch2", "ch3",
-				"ch4", "ch5", "ch6", "ch7",
-				"ch8", "ch9", "ch10", "ch11",
-				"ch12", "ch13", "ch14";
-		clocks = <&mstp2_clks R8A7793_CLK_SYS_DMAC0>;
-		clock-names = "fck";
-		power-domains = <&cpg_clocks>;
-		#dma-cells = <1>;
-		dma-channels = <15>;
-	};
-
-	dmac1: dma-controller at e6720000 {
-		compatible = "renesas,dmac-r8a7793", "renesas,rcar-dmac";
-		reg = <0 0xe6720000 0 0x20000>;
-		interrupts = <0 220 IRQ_TYPE_LEVEL_HIGH
-			      0 216 IRQ_TYPE_LEVEL_HIGH
-			      0 217 IRQ_TYPE_LEVEL_HIGH
-			      0 218 IRQ_TYPE_LEVEL_HIGH
-			      0 219 IRQ_TYPE_LEVEL_HIGH
-			      0 308 IRQ_TYPE_LEVEL_HIGH
-			      0 309 IRQ_TYPE_LEVEL_HIGH
-			      0 310 IRQ_TYPE_LEVEL_HIGH
-			      0 311 IRQ_TYPE_LEVEL_HIGH
-			      0 312 IRQ_TYPE_LEVEL_HIGH
-			      0 313 IRQ_TYPE_LEVEL_HIGH
-			      0 314 IRQ_TYPE_LEVEL_HIGH
-			      0 315 IRQ_TYPE_LEVEL_HIGH
-			      0 316 IRQ_TYPE_LEVEL_HIGH
-			      0 317 IRQ_TYPE_LEVEL_HIGH
-			      0 318 IRQ_TYPE_LEVEL_HIGH>;
-		interrupt-names = "error",
-				"ch0", "ch1", "ch2", "ch3",
-				"ch4", "ch5", "ch6", "ch7",
-				"ch8", "ch9", "ch10", "ch11",
-				"ch12", "ch13", "ch14";
-		clocks = <&mstp2_clks R8A7793_CLK_SYS_DMAC1>;
-		clock-names = "fck";
-		power-domains = <&cpg_clocks>;
-		#dma-cells = <1>;
-		dma-channels = <15>;
-	};
-
 	scifa0: serial at e6c40000 {
 		compatible = "renesas,scifa-r8a7793", "renesas,scifa";
 		reg = <0 0xe6c40000 0 64>;
-- 
2.1.4
