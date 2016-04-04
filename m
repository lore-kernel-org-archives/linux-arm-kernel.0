From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon,  4 Apr 2016 10:23:14 +0900
Subject: [PATCH 42/47] ARM: dts: r8a7794: add IIC clocks
In-Reply-To: <cover.1459732726.git.horms+renesas@verge.net.au>
References: <cover.1459732726.git.horms+renesas@verge.net.au>
Message-ID: <7b3cfd26d0e46147291e9a03a834d5821e982648.1459732726.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add IIC clocks to r8a7794 device tree.

Based on similar work for the r8a7790 by Wolfram Sang.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a7794.dtsi            | 9 ++++++---
 include/dt-bindings/clock/r8a7794-clock.h | 2 ++
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7794.dtsi b/arch/arm/boot/dts/r8a7794.dtsi
index e2a4b6bd16a0..78e0b8186e4a 100644
--- a/arch/arm/boot/dts/r8a7794.dtsi
+++ b/arch/arm/boot/dts/r8a7794.dtsi
@@ -1150,16 +1150,19 @@
 			compatible = "renesas,r8a7794-mstp-clocks", "renesas,cpg-mstp-clocks";
 			reg = <0 0xe615013c 0 4>, <0 0xe6150048 0 4>;
 			clocks = <&sd3_clk>, <&sd2_clk>, <&cpg_clocks R8A7794_CLK_SD0>,
-			         <&mmc0_clk>, <&rclk_clk>, <&hp_clk>, <&hp_clk>;
+				 <&mmc0_clk>, <&hp_clk>, <&hp_clk>, <&rclk_clk>,
+				 <&hp_clk>, <&hp_clk>;
 			#clock-cells = <1>;
 			clock-indices = <
 			        R8A7794_CLK_SDHI2 R8A7794_CLK_SDHI1 R8A7794_CLK_SDHI0
-				R8A7794_CLK_MMCIF0 R8A7794_CLK_CMT1
+				R8A7794_CLK_MMCIF0 R8A7794_CLK_IIC0
+				R8A7794_CLK_IIC1 R8A7794_CLK_CMT1
 				R8A7794_CLK_USBDMAC0 R8A7794_CLK_USBDMAC1
 			>;
 			clock-output-names =
 			        "sdhi2", "sdhi1", "sdhi0",
-				"mmcif0", "cmt1", "usbdmac0", "usbdmac1";
+				"mmcif0", "i2c6", "i2c7",
+				"cmt1", "usbdmac0", "usbdmac1";
 		};
 		mstp4_clks: mstp4_clks at e6150140 {
 			compatible = "renesas,r8a7794-mstp-clocks", "renesas,cpg-mstp-clocks";
diff --git a/include/dt-bindings/clock/r8a7794-clock.h b/include/dt-bindings/clock/r8a7794-clock.h
index 9703fbdb81c8..4d3ecd626c1f 100644
--- a/include/dt-bindings/clock/r8a7794-clock.h
+++ b/include/dt-bindings/clock/r8a7794-clock.h
@@ -57,6 +57,8 @@
 #define R8A7794_CLK_SDHI1		12
 #define R8A7794_CLK_SDHI0		14
 #define R8A7794_CLK_MMCIF0		15
+#define R8A7794_CLK_IIC0		18
+#define R8A7794_CLK_IIC1		23
 #define R8A7794_CLK_CMT1		29
 #define R8A7794_CLK_USBDMAC0		30
 #define R8A7794_CLK_USBDMAC1		31
-- 
2.1.4
