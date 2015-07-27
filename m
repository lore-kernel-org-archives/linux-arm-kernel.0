From: michal.simek@xilinx.com (Michal Simek)
Date: Mon, 27 Jul 2015 11:48:10 +0200
Subject: [PATCH 2/7] ARM64: zynqmp: Add CANs node for platform
In-Reply-To: <48a75b64b05dc094e34fe27e5d03552dbfe77fe2.1437990464.git.michal.simek@xilinx.com>
References: <48a75b64b05dc094e34fe27e5d03552dbfe77fe2.1437990464.git.michal.simek@xilinx.com>
Message-ID: <f2905b624dfc90336f67801ce29bee7a45a9f657.1437990464.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Also enable can0 for ep108.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 arch/arm64/boot/dts/xilinx/zynqmp-ep108.dts |  4 ++++
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi      | 24 ++++++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-ep108.dts b/arch/arm64/boot/dts/xilinx/zynqmp-ep108.dts
index 82deb24dddeb..3aebc3f5d02a 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-ep108.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-ep108.dts
@@ -32,6 +32,10 @@
 	};
 };
 
+&can0 {
+	status = "okay";
+};
+
 &gem0 {
 	status = "okay";
 	phy-handle = <&phy0>;
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
index bd9ba0cab504..d58c9689c82a 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
@@ -96,6 +96,30 @@
 		#size-cells = <1>;
 		ranges;
 
+		can0: can at ff060000 {
+			compatible = "xlnx,zynq-can-1.0";
+			status = "disabled";
+			clocks = <&misc_clk &misc_clk>;
+			clock-names = "can_clk", "pclk";
+			reg = <0x0 0xff060000 0x1000>;
+			interrupts = <0 23 4>;
+			interrupt-parent = <&gic>;
+			tx-fifo-depth = <0x40>;
+			rx-fifo-depth = <0x40>;
+		};
+
+		can1: can at ff070000 {
+			compatible = "xlnx,zynq-can-1.0";
+			status = "disabled";
+			clocks = <&misc_clk &misc_clk>;
+			clock-names = "can_clk", "pclk";
+			reg = <0x0 0xff070000 0x1000>;
+			interrupts = <0 24 4>;
+			interrupt-parent = <&gic>;
+			tx-fifo-depth = <0x40>;
+			rx-fifo-depth = <0x40>;
+		};
+
 		misc_clk: misc_clk {
 			compatible = "fixed-clock";
 			#clock-cells = <0>;
-- 
2.3.5
