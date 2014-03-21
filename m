From: phil.edworthy@renesas.com (Phil Edworthy)
Date: Fri, 21 Mar 2014 10:32:43 +0000
Subject: [PATCH v4 4/9] ARM: shmobile: r8a7791: Add PCIe clock device tree
 nodes
In-Reply-To: <1395397968-6242-1-git-send-email-phil.edworthy@renesas.com>
References: <1395397968-6242-1-git-send-email-phil.edworthy@renesas.com>
Message-ID: <1395397968-6242-5-git-send-email-phil.edworthy@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the device tree clock nodes for PCIe

Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
---
 arch/arm/boot/dts/r8a7791.dtsi            | 7 +++++--
 include/dt-bindings/clock/r8a7791-clock.h | 1 +
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index 71bac2c..ccfba57 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -717,14 +717,17 @@
 			compatible = "renesas,r8a7791-mstp-clocks", "renesas,cpg-mstp-clocks";
 			reg = <0 0xe615013c 0 4>, <0 0xe6150048 0 4>;
 			clocks = <&cp_clk>, <&sd2_clk>, <&sd1_clk>,
-				<&cpg_clocks R8A7791_CLK_SD0>, <&mmc0_clk>, <&rclk_clk>;
+				<&cpg_clocks R8A7791_CLK_SD0>, <&mmc0_clk>, <&rclk_clk>,
+				<&mp_clk>;
 			#clock-cells = <1>;
 			renesas,clock-indices = <
 				R8A7791_CLK_TPU0 R8A7791_CLK_SDHI2 R8A7791_CLK_SDHI1
 				R8A7791_CLK_SDHI0 R8A7791_CLK_MMCIF0 R8A7791_CLK_CMT1
+				R8A7791_CLK_PCIE
 			>;
 			clock-output-names =
-				"tpu0", "sdhi2", "sdhi1", "sdhi0", "mmcif0", "cmt1";
+				"tpu0", "sdhi2", "sdhi1", "sdhi0", "mmcif0", "cmt1",
+				"pcie";
 		};
 		mstp5_clks: mstp5_clks at e6150144 {
 			compatible = "renesas,r8a7791-mstp-clocks", "renesas,cpg-mstp-clocks";
diff --git a/include/dt-bindings/clock/r8a7791-clock.h b/include/dt-bindings/clock/r8a7791-clock.h
index 30f82f2..d3e2cf5 100644
--- a/include/dt-bindings/clock/r8a7791-clock.h
+++ b/include/dt-bindings/clock/r8a7791-clock.h
@@ -51,6 +51,7 @@
 #define R8A7791_CLK_SDHI1		12
 #define R8A7791_CLK_SDHI0		14
 #define R8A7791_CLK_MMCIF0		15
+#define R8A7791_CLK_PCIE		19
 #define R8A7791_CLK_SSUSB		28
 #define R8A7791_CLK_CMT1		29
 #define R8A7791_CLK_USBDMAC0		30
-- 
1.9.0
