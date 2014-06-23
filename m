From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 23 Jun 2014 11:28:13 +0900
Subject: [PATCH 04/29] ARM: shmobile: r8a7791: add USB3.0 clocks to device tree
In-Reply-To: <cover.1403487225.git.horms+renesas@verge.net.au>
References: <cover.1403487225.git.horms+renesas@verge.net.au>
Message-ID: <308f306283894a0d3eeee7d1030289e4e668d49d.1403487225.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7791.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index 8d7ffae..2c27e36 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -758,15 +758,15 @@
 			compatible = "renesas,r8a7791-mstp-clocks", "renesas,cpg-mstp-clocks";
 			reg = <0 0xe615013c 0 4>, <0 0xe6150048 0 4>;
 			clocks = <&cp_clk>, <&sd2_clk>, <&sd1_clk>, <&cpg_clocks R8A7791_CLK_SD0>,
-				 <&mmc0_clk>, <&hp_clk>, <&hp_clk>, <&rclk_clk>;
+				 <&mmc0_clk>, <&hp_clk>, <&hp_clk>, <&mp_clk>, <&rclk_clk>;
 			#clock-cells = <1>;
 			renesas,clock-indices = <
 				R8A7791_CLK_TPU0 R8A7791_CLK_SDHI2 R8A7791_CLK_SDHI1 R8A7791_CLK_SDHI0
-				R8A7791_CLK_MMCIF0 R8A7791_CLK_IIC0 R8A7791_CLK_IIC1 R8A7791_CLK_CMT1
+				R8A7791_CLK_MMCIF0 R8A7791_CLK_IIC0 R8A7791_CLK_IIC1 R8A7791_CLK_SSUSB R8A7791_CLK_CMT1
 			>;
 			clock-output-names =
 				"tpu0", "sdhi2", "sdhi1", "sdhi0",
-				"mmcif0", "i2c7", "i2c8", "cmt1";
+				"mmcif0", "i2c7", "i2c8", "ssusb", "cmt1";
 		};
 		mstp5_clks: mstp5_clks at e6150144 {
 			compatible = "renesas,r8a7791-mstp-clocks", "renesas,cpg-mstp-clocks";
-- 
2.0.0.rc2
