From: soren.brinkmann@xilinx.com (Soren Brinkmann)
Date: Thu, 10 Jul 2014 11:53:38 -0700
Subject: [PATCH] ARM: zynq: dt: Add GPIO node
Message-ID: <1405018418-23396-1-git-send-email-soren.brinkmann@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add node describing Zynq's GPIO controller.

Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
---
The GPIO driver and binding documentation is staged in Linus' GPIO tree.

	S?ren

 arch/arm/boot/dts/zynq-7000.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/zynq-7000.dtsi b/arch/arm/boot/dts/zynq-7000.dtsi
index 760bbc463c5b..504cca338247 100644
--- a/arch/arm/boot/dts/zynq-7000.dtsi
+++ b/arch/arm/boot/dts/zynq-7000.dtsi
@@ -65,6 +65,16 @@
 		interrupt-parent = <&intc>;
 		ranges;
 
+		gpio0: gpio at e000a000 {
+			compatible = "xlnx,zynq-gpio-1.0";
+			#gpio-cells = <2>;
+			clocks = <&clkc 42>;
+			gpio-controller;
+			interrupt-parent = <&intc>;
+			interrupts = <0 20 4>;
+			reg = <0xe000a000 0x1000>;
+		};
+
 		i2c0: i2c at e0004000 {
 			compatible = "cdns,i2c-r1p10";
 			status = "disabled";
-- 
2.0.1.1.gfbfc394
