From: michal.simek@xilinx.com (Michal Simek)
Date: Wed, 23 Jul 2014 15:05:39 +0200
Subject: [PATCH] ARM: zynq: DT: Add CAN node
Message-ID: <52d799e17cd3539713625c6f6a6666620f52d692.1406120732.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add node describing Zynq's CAN controller.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 arch/arm/boot/dts/zynq-7000.dtsi | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/zynq-7000.dtsi b/arch/arm/boot/dts/zynq-7000.dtsi
index 366ca6434f54..2287d9b4ed1a 100644
--- a/arch/arm/boot/dts/zynq-7000.dtsi
+++ b/arch/arm/boot/dts/zynq-7000.dtsi
@@ -71,7 +71,18 @@
 			interrupts = <0 7 4>;
 			interrupt-parent = <&intc>;
 			clocks = <&clkc 12>;
-		};
+		};
+
+		can0: can at e0008000 {
+			compatible = "xlnx,zynq-can-1.0";
+			clocks = <&clkc 19>, <&clkc 36>;
+			clock-names = "can_clk", "pclk";
+			reg = <0xe0008000 0x1000>;
+			interrupts = <0 28 4>;
+			interrupt-parent = <&intc>;
+			tx-fifo-depth = <0x40>;
+			rx-fifo-depth = <0x40>;
+		};

 		gpio0: gpio at e000a000 {
 			compatible = "xlnx,zynq-gpio-1.0";
--
1.8.2.3

-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140723/b9a77014/attachment-0001.sig>
