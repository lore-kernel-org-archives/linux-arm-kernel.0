From: michal.simek@xilinx.com (Michal Simek)
Date: Fri, 25 Jul 2014 08:52:36 +0200
Subject: [PATCH v2] ARM: zynq: DT: Add CAN node
Message-ID: <56bf20294d106e0fc9c23a70cd991a50b441d0aa.1406271138.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add node describing Zynq's CAN controller.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

Changes in v2:
- Add can1
- Enable can0 for zc702
- Use status property

 arch/arm/boot/dts/zynq-7000.dtsi | 26 +++++++++++++++++++++++++-
 arch/arm/boot/dts/zynq-zc702.dts |  4 ++++
 2 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/zynq-7000.dtsi b/arch/arm/boot/dts/zynq-7000.dtsi
index 366ca6434f54..983148111e3a 100644
--- a/arch/arm/boot/dts/zynq-7000.dtsi
+++ b/arch/arm/boot/dts/zynq-7000.dtsi
@@ -71,7 +71,31 @@
 			interrupts = <0 7 4>;
 			interrupt-parent = <&intc>;
 			clocks = <&clkc 12>;
-		};
+		};
+
+		can0: can at e0008000 {
+			compatible = "xlnx,zynq-can-1.0";
+			status = "disabled";
+			clocks = <&clkc 19>, <&clkc 36>;
+			clock-names = "can_clk", "pclk";
+			reg = <0xe0008000 0x1000>;
+			interrupts = <0 28 4>;
+			interrupt-parent = <&intc>;
+			tx-fifo-depth = <0x40>;
+			rx-fifo-depth = <0x40>;
+		};
+
+		can1: can at e0009000 {
+			compatible = "xlnx,zynq-can-1.0";
+			status = "disabled";
+			clocks = <&clkc 19>, <&clkc 36>;
+			clock-names = "can_clk", "pclk";
+			reg = <0xe0009000 0x1000>;
+			interrupts = <0 51 4>;
+			interrupt-parent = <&intc>;
+			tx-fifo-depth = <0x40>;
+			rx-fifo-depth = <0x40>;
+		};

 		gpio0: gpio at e000a000 {
 			compatible = "xlnx,zynq-gpio-1.0";
diff --git a/arch/arm/boot/dts/zynq-zc702.dts b/arch/arm/boot/dts/zynq-zc702.dts
index 5e09cee33d42..835c3089c61c 100644
--- a/arch/arm/boot/dts/zynq-zc702.dts
+++ b/arch/arm/boot/dts/zynq-zc702.dts
@@ -29,6 +29,10 @@

 };

+&can0 {
+	status = "okay";
+};
+
 &gem0 {
 	status = "okay";
 	phy-mode = "rgmii";
--
1.8.2.3

-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140725/3d540a4f/attachment.sig>
