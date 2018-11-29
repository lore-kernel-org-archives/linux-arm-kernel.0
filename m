From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 29 Nov 2018 12:08:21 +0100
Subject: [PATCH] ARM: dts: msm8660: Fix up GIC IRQ flags
Message-ID: <20181129110821.18102-1-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All the GSBI blocks are marking their GIC IRQ lines as
"IRQ_TYPE_NONE" but there is no such thing: all GIC IRQ
lines have a trigger type.

That yields the following warning from the GIC driver:

WARNING: CPU: 0 PID: 1 at ../drivers/irqchip/irq-gic.c:1016
	 gic_irq_domain_translate+0xdc/0xe4
(...)

Mark all of these IRQ_TYPE_LEVEL_HIGH as is common so this
warning goes away.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/qcom-msm8660.dtsi | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-msm8660.dtsi b/arch/arm/boot/dts/qcom-msm8660.dtsi
index 9b1cf00d8ca3..e5da87036dbb 100644
--- a/arch/arm/boot/dts/qcom-msm8660.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8660.dtsi
@@ -141,7 +141,7 @@
 				compatible = "qcom,msm-uartdm-v1.3", "qcom,msm-uartdm";
 				reg = <0x16540000 0x1000>,
 				      <0x16500000 0x1000>;
-				interrupts = <GIC_SPI 156 IRQ_TYPE_NONE>;
+				interrupts = <GIC_SPI 156 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&gcc GSBI6_UART_CLK>, <&gcc GSBI6_H_CLK>;
 				clock-names = "core", "iface";
 				status = "disabled";
@@ -150,7 +150,7 @@
 			gsbi6_i2c: i2c at 16580000 {
 				compatible = "qcom,i2c-qup-v1.1.1";
 				reg = <0x16580000 0x1000>;
-				interrupts = <GIC_SPI 157 IRQ_TYPE_NONE>;
+				interrupts = <GIC_SPI 157 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&gcc GSBI6_QUP_CLK>, <&gcc GSBI6_H_CLK>;
 				clock-names = "core", "iface";
 				#address-cells = <1>;
@@ -176,7 +176,7 @@
 				compatible = "qcom,msm-uartdm-v1.3", "qcom,msm-uartdm";
 				reg = <0x16640000 0x1000>,
 				      <0x16600000 0x1000>;
-				interrupts = <GIC_SPI 158 IRQ_TYPE_NONE>;
+				interrupts = <GIC_SPI 158 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&gcc GSBI7_UART_CLK>, <&gcc GSBI7_H_CLK>;
 				clock-names = "core", "iface";
 				status = "disabled";
@@ -185,7 +185,7 @@
 			gsbi7_i2c: i2c at 16680000 {
 				compatible = "qcom,i2c-qup-v1.1.1";
 				reg = <0x16680000 0x1000>;
-				interrupts = <GIC_SPI 159 IRQ_TYPE_NONE>;
+				interrupts = <GIC_SPI 159 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&gcc GSBI7_QUP_CLK>, <&gcc GSBI7_H_CLK>;
 				clock-names = "core", "iface";
 				#address-cells = <1>;
@@ -209,7 +209,7 @@
 			gsbi8_i2c: i2c at 19880000 {
 				compatible = "qcom,i2c-qup-v1.1.1";
 				reg = <0x19880000 0x1000>;
-				interrupts = <GIC_SPI 161 IRQ_TYPE_NONE>;
+				interrupts = <GIC_SPI 161 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&gcc GSBI8_QUP_CLK>, <&gcc GSBI8_H_CLK>;
 				clock-names = "core", "iface";
 				#address-cells = <1>;
@@ -234,7 +234,7 @@
 				compatible = "qcom,msm-uartdm-v1.3", "qcom,msm-uartdm";
 				reg = <0x19c40000 0x1000>,
 				      <0x19c00000 0x1000>;
-				interrupts = <0 195 IRQ_TYPE_NONE>;
+				interrupts = <0 195 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&gcc GSBI12_UART_CLK>, <&gcc GSBI12_H_CLK>;
 				clock-names = "core", "iface";
 				status = "disabled";
@@ -243,7 +243,7 @@
 			gsbi12_i2c: i2c at 19c80000 {
 				compatible = "qcom,i2c-qup-v1.1.1";
 				reg = <0x19c80000 0x1000>;
-				interrupts = <0 196 IRQ_TYPE_NONE>;
+				interrupts = <0 196 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&gcc GSBI12_QUP_CLK>, <&gcc GSBI12_H_CLK>;
 				clock-names = "core", "iface";
 				#address-cells = <1>;
-- 
2.19.1
