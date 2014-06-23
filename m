From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 23 Jun 2014 11:28:30 +0900
Subject: [PATCH 21/29] ARM: shmobile: r8a7790: Add PCIEC clock device tree node
In-Reply-To: <cover.1403487225.git.horms+renesas@verge.net.au>
References: <cover.1403487225.git.horms+renesas@verge.net.au>
Message-ID: <ecafea8cd261833d7bb857aad76cf2e721821e88.1403487225.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Phil Edworthy <phil.edworthy@renesas.com>

This patch adds the device tree clock node for the PCIe Controller

Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7790.dtsi            | 6 +++---
 include/dt-bindings/clock/r8a7790-clock.h | 1 +
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index 29907c9..9df5712 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -765,17 +765,17 @@
 			reg = <0 0xe615013c 0 4>, <0 0xe6150048 0 4>;
 			clocks = <&hp_clk>, <&cp_clk>, <&mmc1_clk>, <&sd3_clk>,
 				 <&sd2_clk>, <&cpg_clocks R8A7790_CLK_SD1>, <&cpg_clocks R8A7790_CLK_SD0>, <&mmc0_clk>,
-				 <&hp_clk>, <&hp_clk>, <&mp_clk>, <&rclk_clk>;
+				 <&hp_clk>, <&mp_clk>, <&hp_clk>, <&mp_clk>, <&rclk_clk>;
 			#clock-cells = <1>;
 			renesas,clock-indices = <
 				R8A7790_CLK_IIC2 R8A7790_CLK_TPU0 R8A7790_CLK_MMCIF1 R8A7790_CLK_SDHI3
 				R8A7790_CLK_SDHI2 R8A7790_CLK_SDHI1 R8A7790_CLK_SDHI0 R8A7790_CLK_MMCIF0
-				R8A7790_CLK_IIC0 R8A7790_CLK_IIC1 R8A7790_CLK_SSUSB R8A7790_CLK_CMT1
+				R8A7790_CLK_IIC0 R8A7790_CLK_PCIEC R8A7790_CLK_IIC1 R8A7790_CLK_SSUSB R8A7790_CLK_CMT1
 			>;
 			clock-output-names =
 				"iic2", "tpu0", "mmcif1", "sdhi3",
 				"sdhi2", "sdhi1", "sdhi0", "mmcif0",
-				"iic0", "iic1", "ssusb", "cmt1";
+				"iic0", "pciec", "iic1", "ssusb", "cmt1";
 		};
 		mstp5_clks: mstp5_clks at e6150144 {
 			compatible = "renesas,r8a7790-mstp-clocks", "renesas,cpg-mstp-clocks";
diff --git a/include/dt-bindings/clock/r8a7790-clock.h b/include/dt-bindings/clock/r8a7790-clock.h
index a16df68..f929a79e 100644
--- a/include/dt-bindings/clock/r8a7790-clock.h
+++ b/include/dt-bindings/clock/r8a7790-clock.h
@@ -59,6 +59,7 @@
 #define R8A7790_CLK_SDHI0		14
 #define R8A7790_CLK_MMCIF0		15
 #define R8A7790_CLK_IIC0		18
+#define R8A7790_CLK_PCIEC		19
 #define R8A7790_CLK_IIC1		23
 #define R8A7790_CLK_SSUSB		28
 #define R8A7790_CLK_CMT1		29
-- 
2.0.0.rc2
