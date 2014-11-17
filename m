From: yoshihiro.shimoda.uh@renesas.com (Yoshihiro Shimoda)
Date: Mon, 17 Nov 2014 18:25:25 +0900
Subject: [PATCH] ARM: shmobile: r8a7791: add USBDMAC{0,1} clocks to device tree
Message-ID: <5469BF05.2010103@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 At the moment, usb-dmac driver for r8a7791 doesn't exist. But I would like
 to enable these clock settings for future development.

 arch/arm/boot/dts/r8a7791.dtsi |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index ba18030..d1d77d7 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -1108,16 +1108,19 @@
 			compatible = "renesas,r8a7791-mstp-clocks", "renesas,cpg-mstp-clocks";
 			reg = <0 0xe615013c 0 4>, <0 0xe6150048 0 4>;
 			clocks = <&cp_clk>, <&sd2_clk>, <&sd1_clk>, <&cpg_clocks R8A7791_CLK_SD0>,
-				 <&mmc0_clk>, <&hp_clk>, <&mp_clk>, <&hp_clk>, <&mp_clk>, <&rclk_clk>;
+				 <&mmc0_clk>, <&hp_clk>, <&mp_clk>, <&hp_clk>, <&mp_clk>, <&rclk_clk>,
+				 <&hp_clk>, <&hp_clk>;
 			#clock-cells = <1>;
 			renesas,clock-indices = <
 				R8A7791_CLK_TPU0 R8A7791_CLK_SDHI2 R8A7791_CLK_SDHI1 R8A7791_CLK_SDHI0
 				R8A7791_CLK_MMCIF0 R8A7791_CLK_IIC0 R8A7791_CLK_PCIEC R8A7791_CLK_IIC1
 				R8A7791_CLK_SSUSB R8A7791_CLK_CMT1
+				R8A7791_CLK_USBDMAC0 R8A7791_CLK_USBDMAC1
 			>;
 			clock-output-names =
 				"tpu0", "sdhi2", "sdhi1", "sdhi0",
-				"mmcif0", "i2c7", "pciec", "i2c8", "ssusb", "cmt1";
+				"mmcif0", "i2c7", "pciec", "i2c8", "ssusb", "cmt1",
+				"usbdmac0", "usbdmac1";
 		};
 		mstp5_clks: mstp5_clks at e6150144 {
 			compatible = "renesas,r8a7791-mstp-clocks", "renesas,cpg-mstp-clocks";
-- 
1.7.9.5
