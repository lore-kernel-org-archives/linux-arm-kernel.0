From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 29 Dec 2014 10:43:53 +0900
Subject: [PATCH 22/30] ARM: shmobile: r8a7794: Add MMCIF clock to device tree
In-Reply-To: <cover.1419812185.git.horms+renesas@verge.net.au>
References: <cover.1419812185.git.horms+renesas@verge.net.au>
Message-ID: <deac150c2d141c16c4814972c25c2a3aacae8d57.1419812186.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shinobu Uehara <shinobu.uehara.xc@renesas.com>

Signed-off-by: Shinobu Uehara <shinobu.uehara.xc@renesas.com>
[horms: omitted device node; only add clock]
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7794.dtsi            | 15 +++++++++++----
 include/dt-bindings/clock/r8a7794-clock.h |  1 +
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7794.dtsi b/arch/arm/boot/dts/r8a7794.dtsi
index c376676..8f78da5 100644
--- a/arch/arm/boot/dts/r8a7794.dtsi
+++ b/arch/arm/boot/dts/r8a7794.dtsi
@@ -308,6 +308,13 @@
 			#clock-cells = <0>;
 			clock-output-names = "sd2";
 		};
+		mmc0_clk: mmc0_clk at e6150240 {
+			compatible = "renesas,r8a7794-div6-clock", "renesas,cpg-div6-clock";
+			reg = <0 0xe6150240 0 4>;
+			clocks = <&pll1_div2_clk>;
+			#clock-cells = <0>;
+			clock-output-names = "mmc0";
+		};
 
 		/* Fixed factor clocks */
 		pll1_div2_clk: pll1_div2_clk {
@@ -512,16 +519,16 @@
 			compatible = "renesas,r8a7794-mstp-clocks", "renesas,cpg-mstp-clocks";
 			reg = <0 0xe615013c 0 4>, <0 0xe6150048 0 4>;
 			clocks = <&sd2_clk>, <&sd1_clk>, <&cpg_clocks R8A7794_CLK_SD0>,
-			         <&rclk_clk>, <&hp_clk>, <&hp_clk>;
+			         <&mmc0_clk>, <&rclk_clk>, <&hp_clk>, <&hp_clk>;
 			#clock-cells = <1>;
 			clock-indices = <
 			        R8A7794_CLK_SDHI2 R8A7794_CLK_SDHI1 R8A7794_CLK_SDHI0
-				R8A7794_CLK_CMT1 R8A7794_CLK_USBDMAC0
-				R8A7794_CLK_USBDMAC1
+				R8A7794_CLK_MMCIF0 R8A7794_CLK_CMT1
+				R8A7794_CLK_USBDMAC0 R8A7794_CLK_USBDMAC1
 			>;
 			clock-output-names =
 			        "sdhi2", "sdhi1", "sdhi0",
-				"cmt1", "usbdmac0", "usbdmac1";
+				"mmcif0", "cmt1", "usbdmac0", "usbdmac1";
 		};
 		mstp7_clks: mstp7_clks at e615014c {
 			compatible = "renesas,r8a7794-mstp-clocks", "renesas,cpg-mstp-clocks";
diff --git a/include/dt-bindings/clock/r8a7794-clock.h b/include/dt-bindings/clock/r8a7794-clock.h
index ccd5667..d633230 100644
--- a/include/dt-bindings/clock/r8a7794-clock.h
+++ b/include/dt-bindings/clock/r8a7794-clock.h
@@ -55,6 +55,7 @@
 #define R8A7794_CLK_SDHI2		11
 #define R8A7794_CLK_SDHI1		12
 #define R8A7794_CLK_SDHI0		14
+#define R8A7794_CLK_MMCIF0		15
 #define R8A7794_CLK_CMT1		29
 #define R8A7794_CLK_USBDMAC0		30
 #define R8A7794_CLK_USBDMAC1		31
-- 
2.1.3
