From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 23 Apr 2014 10:25:57 +0900
Subject: [PATCH 29/33] ARM: shmobile: r8a7790: add IIC(B) clocks to dtsi
In-Reply-To: <cover.1398216022.git.horms+renesas@verge.net.au>
References: <cover.1398216022.git.horms+renesas@verge.net.au>
Message-ID: <17465149d8a1a3b7a00f02796d7d364522d0383b.1398216022.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wolfram Sang <wsa@sang-engineering.com>

Signed-off-by: Wolfram Sang <wsa@sang-engineering.com>
[horms+renesas at verge.net.au resolved conflicts]
[horms+renesas at verge.net.au consistently use space as separator]
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7790.dtsi | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index c4b9ff7..79855e3 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -702,18 +702,19 @@
 		mstp3_clks: mstp3_clks at e615013c {
 			compatible = "renesas,r8a7790-mstp-clocks", "renesas,cpg-mstp-clocks";
 			reg = <0 0xe615013c 0 4>, <0 0xe6150048 0 4>;
-			clocks = <&cp_clk>, <&mmc1_clk>, <&sd3_clk>, <&sd2_clk>,
-				 <&cpg_clocks R8A7790_CLK_SD1>, <&cpg_clocks R8A7790_CLK_SD0>,
-				 <&mmc0_clk>, <&rclk_clk>;
+			clocks = <&hp_clk>, <&cp_clk>, <&mmc1_clk>, <&sd3_clk>,
+				 <&sd2_clk>, <&cpg_clocks R8A7790_CLK_SD1>, <&cpg_clocks R8A7790_CLK_SD0>, <&mmc0_clk>,
+				 <&hp_clk>, <&hp_clk>, <&rclk_clk>;
 			#clock-cells = <1>;
 			renesas,clock-indices = <
-				R8A7790_CLK_TPU0 R8A7790_CLK_MMCIF1 R8A7790_CLK_SDHI3
-				R8A7790_CLK_SDHI2 R8A7790_CLK_SDHI1 R8A7790_CLK_SDHI0
-				R8A7790_CLK_MMCIF0 R8A7790_CLK_CMT1
+				R8A7790_CLK_IIC2 R8A7790_CLK_TPU0 R8A7790_CLK_MMCIF1 R8A7790_CLK_SDHI3
+				R8A7790_CLK_SDHI2 R8A7790_CLK_SDHI1 R8A7790_CLK_SDHI0 R8A7790_CLK_MMCIF0
+				R8A7790_CLK_IIC0 R8A7790_CLK_IIC1 R8A7790_CLK_CMT1
 			>;
 			clock-output-names =
-				"tpu0", "mmcif1", "sdhi3", "sdhi2",
-				"sdhi1", "sdhi0", "mmcif0", "cmt1";
+				"iic2", "tpu0", "mmcif1", "sdhi3",
+				"sdhi2", "sdhi1", "sdhi0", "mmcif0",
+				"iic0", "iic1", "cmt1";
 		};
 		mstp5_clks: mstp5_clks at e6150144 {
 			compatible = "renesas,r8a7790-mstp-clocks", "renesas,cpg-mstp-clocks";
@@ -757,16 +758,16 @@
 		mstp9_clks: mstp9_clks at e6150994 {
 			compatible = "renesas,r8a7790-mstp-clocks", "renesas,cpg-mstp-clocks";
 			reg = <0 0xe6150994 0 4>, <0 0xe61509a4 0 4>;
-			clocks = <&p_clk>, <&p_clk>, <&cpg_clocks R8A7790_CLK_QSPI>,
+			clocks = <&p_clk>, <&p_clk>, <&cpg_clocks R8A7790_CLK_QSPI>, <&cp_clk>,
 				 <&hp_clk>, <&hp_clk>, <&hp_clk>, <&hp_clk>;
 			#clock-cells = <1>;
 			renesas,clock-indices = <
-				R8A7790_CLK_RCAN1 R8A7790_CLK_RCAN0 R8A7790_CLK_QSPI_MOD
-				R8A7790_CLK_I2C3 R8A7790_CLK_I2C2 R8A7790_CLK_I2C1
-				R8A7790_CLK_I2C0
+				R8A7790_CLK_RCAN1 R8A7790_CLK_RCAN0 R8A7790_CLK_QSPI_MOD R8A7790_CLK_IICDVFS
+				R8A7790_CLK_I2C3 R8A7790_CLK_I2C2 R8A7790_CLK_I2C1 R8A7790_CLK_I2C0
 			>;
 			clock-output-names =
-				"rcan1", "rcan0", "qspi_mod", "i2c3", "i2c2", "i2c1", "i2c0";
+				"rcan1", "rcan0", "qspi_mod", "iic3",
+				"i2c3", "i2c2", "i2c1", "i2c0";
 		};
 	};
 
-- 
1.8.5.2
