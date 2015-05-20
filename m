From: cory.tusar@pid1solutions.com (Cory Tusar)
Date: Tue, 19 May 2015 22:45:39 -0400
Subject: [PATCH] ARM: dts: vf610: Extend I2C support to all available busses.
Message-ID: <1432089939-1086-1-git-send-email-cory.tusar@pid1solutions.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit extends the existing Vybrid I2C support to cover busses
I2C1, I2C2, and I2C3.

Signed-off-by: Cory Tusar <cory.tusar@pid1solutions.com>
---
 arch/arm/boot/dts/vfxxx.dtsi | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/arch/arm/boot/dts/vfxxx.dtsi b/arch/arm/boot/dts/vfxxx.dtsi
index 4aa3351..ec98b6c 100644
--- a/arch/arm/boot/dts/vfxxx.dtsi
+++ b/arch/arm/boot/dts/vfxxx.dtsi
@@ -347,6 +347,48 @@
 				status = "disabled";
 			};
 
+			i2c1: i2c at 40067000 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,vf610-i2c";
+				reg = <0x40067000 0x1000>;
+				interrupts = <72 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clks VF610_CLK_I2C1>;
+				clock-names = "ipg";
+				dmas = <&edma0 0 52>,
+					<&edma0 0 53>;
+				dma-names = "rx","tx";
+				status = "disabled";
+			};
+
+			i2c2: i2c at 400e6000 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,vf610-i2c";
+				reg = <0x400e6000 0x1000>;
+				interrupts = <73 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clks VF610_CLK_I2C2>;
+				clock-names = "ipg";
+				dmas = <&edma0 1 36>,
+					<&edma0 1 37>;
+				dma-names = "rx","tx";
+				status = "disabled";
+			};
+
+			i2c3: i2c at 400e7000 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,vf610-i2c";
+				reg = <0x400e7000 0x1000>;
+				interrupts = <74 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clks VF610_CLK_I2C3>;
+				clock-names = "ipg";
+				dmas = <&edma0 1 38>,
+					<&edma0 1 39>;
+				dma-names = "rx","tx";
+				status = "disabled";
+			};
+
 			clks: ccm at 4006b000 {
 				compatible = "fsl,vf610-ccm";
 				reg = <0x4006b000 0x1000>;
-- 
2.3.6
