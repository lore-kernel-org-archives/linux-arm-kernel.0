From: phil.edworthy@renesas.com (Phil Edworthy)
Date: Fri, 21 Mar 2014 10:32:42 +0000
Subject: [PATCH v4 3/9] ARM: shmobile: r8a7790: Add PCIe clock device tree
 nodes
In-Reply-To: <1395397968-6242-1-git-send-email-phil.edworthy@renesas.com>
References: <1395397968-6242-1-git-send-email-phil.edworthy@renesas.com>
Message-ID: <1395397968-6242-4-git-send-email-phil.edworthy@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the device tree clock nodes for PCIe

Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
---
 arch/arm/boot/dts/r8a7790.dtsi            | 7 ++++---
 include/dt-bindings/clock/r8a7790-clock.h | 1 +
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index da69afc..df9ec61 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -704,16 +704,17 @@
 			reg = <0 0xe615013c 0 4>, <0 0xe6150048 0 4>;
 			clocks = <&cp_clk>, <&mmc1_clk>, <&sd3_clk>, <&sd2_clk>,
 				 <&cpg_clocks R8A7790_CLK_SD1>, <&cpg_clocks R8A7790_CLK_SD0>,
-				 <&mmc0_clk>, <&rclk_clk>;
+				 <&mmc0_clk>, <&rclk_clk>, <&mp_clk>;
 			#clock-cells = <1>;
 			renesas,clock-indices = <
 				R8A7790_CLK_TPU0 R8A7790_CLK_MMCIF1 R8A7790_CLK_SDHI3
 				R8A7790_CLK_SDHI2 R8A7790_CLK_SDHI1 R8A7790_CLK_SDHI0
-				R8A7790_CLK_MMCIF0 R8A7790_CLK_CMT1
+				R8A7790_CLK_MMCIF0 R8A7790_CLK_CMT1 R8A7790_CLK_PCIE
 			>;
 			clock-output-names =
 				"tpu0", "mmcif1", "sdhi3", "sdhi2",
-				"sdhi1", "sdhi0", "mmcif0", "cmt1";
+				"sdhi1", "sdhi0", "mmcif0", "cmt1",
+				"pcie";
 		};
 		mstp5_clks: mstp5_clks at e6150144 {
 			compatible = "renesas,r8a7790-mstp-clocks", "renesas,cpg-mstp-clocks";
diff --git a/include/dt-bindings/clock/r8a7790-clock.h b/include/dt-bindings/clock/r8a7790-clock.h
index 6548a5f..840dbc8 100644
--- a/include/dt-bindings/clock/r8a7790-clock.h
+++ b/include/dt-bindings/clock/r8a7790-clock.h
@@ -57,6 +57,7 @@
 #define R8A7790_CLK_SDHI1		13
 #define R8A7790_CLK_SDHI0		14
 #define R8A7790_CLK_MMCIF0		15
+#define R8A7790_CLK_PCIE		19
 #define R8A7790_CLK_SSUSB		28
 #define R8A7790_CLK_CMT1		29
 #define R8A7790_CLK_USBDMAC0		30
-- 
1.9.0
