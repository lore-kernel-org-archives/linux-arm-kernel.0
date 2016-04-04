From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon,  4 Apr 2016 10:22:35 +0900
Subject: [PATCH 03/47] ARM: dts: r8a7790: Add SCIF2 clock
In-Reply-To: <cover.1459732726.git.horms+renesas@verge.net.au>
References: <cover.1459732726.git.horms+renesas@verge.net.au>
Message-ID: <a76e76e582d02e7be37cef51ab8815d27262dfe0.1459732726.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Based on Rev. 2.00 of the R-Car Gen2 datasheet.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7790.dtsi            | 6 +++---
 include/dt-bindings/clock/r8a7790-clock.h | 1 +
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index 0967f231f4f4..cc4974a348d9 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -1334,19 +1334,19 @@
 		mstp3_clks: mstp3_clks at e615013c {
 			compatible = "renesas,r8a7790-mstp-clocks", "renesas,cpg-mstp-clocks";
 			reg = <0 0xe615013c 0 4>, <0 0xe6150048 0 4>;
-			clocks = <&hp_clk>, <&cp_clk>, <&mmc1_clk>, <&sd3_clk>,
+			clocks = <&hp_clk>, <&cp_clk>, <&mmc1_clk>, <&p_clk>, <&sd3_clk>,
 				 <&sd2_clk>, <&cpg_clocks R8A7790_CLK_SD1>, <&cpg_clocks R8A7790_CLK_SD0>, <&mmc0_clk>,
 				 <&hp_clk>, <&mp_clk>, <&hp_clk>, <&mp_clk>, <&rclk_clk>,
 				 <&hp_clk>, <&hp_clk>;
 			#clock-cells = <1>;
 			clock-indices = <
-				R8A7790_CLK_IIC2 R8A7790_CLK_TPU0 R8A7790_CLK_MMCIF1 R8A7790_CLK_SDHI3
+				R8A7790_CLK_IIC2 R8A7790_CLK_TPU0 R8A7790_CLK_MMCIF1 R8A7790_CLK_SCIF2 R8A7790_CLK_SDHI3
 				R8A7790_CLK_SDHI2 R8A7790_CLK_SDHI1 R8A7790_CLK_SDHI0 R8A7790_CLK_MMCIF0
 				R8A7790_CLK_IIC0 R8A7790_CLK_PCIEC R8A7790_CLK_IIC1 R8A7790_CLK_SSUSB R8A7790_CLK_CMT1
 				R8A7790_CLK_USBDMAC0 R8A7790_CLK_USBDMAC1
 			>;
 			clock-output-names =
-				"iic2", "tpu0", "mmcif1", "sdhi3",
+				"iic2", "tpu0", "mmcif1", "scif2", "sdhi3",
 				"sdhi2", "sdhi1", "sdhi0", "mmcif0",
 				"iic0", "pciec", "iic1", "ssusb", "cmt1",
 				"usbdmac0", "usbdmac1";
diff --git a/include/dt-bindings/clock/r8a7790-clock.h b/include/dt-bindings/clock/r8a7790-clock.h
index 7b1ad8922eec..fa5e8da809f2 100644
--- a/include/dt-bindings/clock/r8a7790-clock.h
+++ b/include/dt-bindings/clock/r8a7790-clock.h
@@ -66,6 +66,7 @@
 #define R8A7790_CLK_IIC2		0
 #define R8A7790_CLK_TPU0		4
 #define R8A7790_CLK_MMCIF1		5
+#define R8A7790_CLK_SCIF2		10
 #define R8A7790_CLK_SDHI3		11
 #define R8A7790_CLK_SDHI2		12
 #define R8A7790_CLK_SDHI1		13
-- 
2.1.4
