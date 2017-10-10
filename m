From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 10 Oct 2017 10:39:24 +0200
Subject: [PATCH] ARM: dts: qcom: add MSM8660 GSBI6 and GSBI7
Message-ID: <20171010083924.19244-1-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the GSBI6 and GSBI7 IO blocks to the MSM8660 DTSI file.
On the APQ8060 DragonBoard, GSBI6 DM is used for Bluetooth UART,
and GSBI7 I2C is used for FM radio I2C.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/qcom-msm8660.dtsi | 67 +++++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-msm8660.dtsi b/arch/arm/boot/dts/qcom-msm8660.dtsi
index 1b5d31b33b5e..4f02489bcb2e 100644
--- a/arch/arm/boot/dts/qcom-msm8660.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8660.dtsi
@@ -123,6 +123,73 @@
 			reg = <0x900000 0x4000>;
 		};
 
+		gsbi6: gsbi at 16500000 {
+			compatible = "qcom,gsbi-v1.0.0";
+			cell-index = <12>;
+			reg = <0x16500000 0x100>;
+			clocks = <&gcc GSBI6_H_CLK>;
+			clock-names = "iface";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+
+			syscon-tcsr = <&tcsr>;
+
+			gsbi6_serial: serial at 16540000 {
+				compatible = "qcom,msm-uartdm-v1.3", "qcom,msm-uartdm";
+				reg = <0x16540000 0x1000>,
+				      <0x16500000 0x1000>;
+				interrupts = <GIC_SPI 156 IRQ_TYPE_NONE>;
+				clocks = <&gcc GSBI6_UART_CLK>, <&gcc GSBI6_H_CLK>;
+				clock-names = "core", "iface";
+				status = "disabled";
+			};
+
+			gsbi6_i2c: i2c at 16580000 {
+				compatible = "qcom,i2c-qup-v1.1.1";
+				reg = <0x16580000 0x1000>;
+				interrupts = <GIC_SPI 157 IRQ_TYPE_NONE>;
+				clocks = <&gcc GSBI6_QUP_CLK>, <&gcc GSBI6_H_CLK>;
+				clock-names = "core", "iface";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+		};
+
+		gsbi7: gsbi at 16600000 {
+			compatible = "qcom,gsbi-v1.0.0";
+			cell-index = <12>;
+			reg = <0x16600000 0x100>;
+			clocks = <&gcc GSBI7_H_CLK>;
+			clock-names = "iface";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+
+			syscon-tcsr = <&tcsr>;
+
+			gsbi7_serial: serial at 16640000 {
+				compatible = "qcom,msm-uartdm-v1.3", "qcom,msm-uartdm";
+				reg = <0x16640000 0x1000>,
+				      <0x16600000 0x1000>;
+				interrupts = <GIC_SPI 158 IRQ_TYPE_NONE>;
+				clocks = <&gcc GSBI7_UART_CLK>, <&gcc GSBI7_H_CLK>;
+				clock-names = "core", "iface";
+				status = "disabled";
+			};
+
+			gsbi7_i2c: i2c at 16680000 {
+				compatible = "qcom,i2c-qup-v1.1.1";
+				reg = <0x16680000 0x1000>;
+				interrupts = <GIC_SPI 159 IRQ_TYPE_NONE>;
+				clocks = <&gcc GSBI7_QUP_CLK>, <&gcc GSBI7_H_CLK>;
+				clock-names = "core", "iface";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+		};
 
 		gsbi8: gsbi at 19800000 {
 			compatible = "qcom,gsbi-v1.0.0";
-- 
2.13.5
