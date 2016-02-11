From: michal.simek@xilinx.com (Michal Simek)
Date: Thu, 11 Feb 2016 13:26:26 +0100
Subject: [PATCH 1/3] ARM64: zynqmp: Keep gpio node alphabetically sorted
Message-ID: <2f160e012080d5d6de11238ade239bb0bb224f64.1455193571.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

No functional change.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
index 200fb588d0f5..7bc65e391530 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
@@ -126,18 +126,6 @@
 			clock-frequency = <25000000>;
 		};
 
-		gpio: gpio at ff0a0000 {
-			compatible = "xlnx,zynqmp-gpio-1.0";
-			status = "disabled";
-			#gpio-cells = <0x2>;
-			clocks = <&misc_clk>;
-			interrupt-parent = <&gic>;
-			interrupts = <0 16 4>;
-			interrupt-controller;
-			#interrupt-cells = <2>;
-			reg = <0x0 0xff0a0000 0x1000>;
-		};
-
 		gem0: ethernet at ff0b0000 {
 			compatible = "cdns,gem";
 			status = "disabled";
@@ -186,6 +174,18 @@
 			#size-cells = <0>;
 		};
 
+		gpio: gpio at ff0a0000 {
+			compatible = "xlnx,zynqmp-gpio-1.0";
+			status = "disabled";
+			#gpio-cells = <0x2>;
+			clocks = <&misc_clk>;
+			interrupt-parent = <&gic>;
+			interrupts = <0 16 4>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			reg = <0x0 0xff0a0000 0x1000>;
+		};
+
 		i2c_clk: i2c_clk {
 			compatible = "fixed-clock";
 			#clock-cells = <0x0>;
-- 
1.9.1
