From: soren.brinkmann@xilinx.com (Soren Brinkmann)
Date: Thu,  5 Jun 2014 09:05:23 -0700
Subject: [PATCH 1/2] ARM: zynq: DT: Add XADC node
Message-ID: <1401984324-6075-1-git-send-email-soren.brinkmann@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add node for the Xilinx A/D Converter.

Cc: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
---
 arch/arm/boot/dts/zynq-7000.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/zynq-7000.dtsi b/arch/arm/boot/dts/zynq-7000.dtsi
index 760bbc463c5b..c5854286a95a 100644
--- a/arch/arm/boot/dts/zynq-7000.dtsi
+++ b/arch/arm/boot/dts/zynq-7000.dtsi
@@ -65,6 +65,14 @@
 		interrupt-parent = <&intc>;
 		ranges;
 
+		adc at f8007100 {
+			compatible = "xlnx,zynq-xadc-1.00.a";
+			reg = <0xf8007100 0x20>;
+			interrupts = <0 7 4>;
+			interrupt-parent = <&intc>;
+			clocks = <&clkc 12>;
+		};
+
 		i2c0: i2c at e0004000 {
 			compatible = "cdns,i2c-r1p10";
 			status = "disabled";
-- 
2.0.0
