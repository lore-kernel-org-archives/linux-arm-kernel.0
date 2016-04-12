From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Tue, 12 Apr 2016 10:33:50 +0100
Subject: [PATCH v2 01/13] ARM: dts: apq8064: fix the pinctrls for i2c and spi
In-Reply-To: <1460453642-5809-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1460453642-5809-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <1460453642-5809-2-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes pinctrls for spi and i2c nodes whose default and sleep
states are together, which is incorrect.

Without this patch i2c/spi would not be functional.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Acked-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 arch/arm/boot/dts/qcom-apq8064.dtsi | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom-apq8064.dtsi
index 65d0e8d..c6ff8fc 100644
--- a/arch/arm/boot/dts/qcom-apq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8064.dtsi
@@ -227,7 +227,8 @@
 
 			gsbi1_i2c: i2c at 12460000 {
 				compatible = "qcom,i2c-qup-v1.1.1";
-				pinctrl-0 = <&i2c1_pins &i2c1_pins_sleep>;
+				pinctrl-0 = <&i2c1_pins>;
+				pinctrl-1 = <&i2c1_pins_sleep>;
 				pinctrl-names = "default", "sleep";
 				reg = <0x12460000 0x1000>;
 				interrupts = <0 194 IRQ_TYPE_NONE>;
@@ -255,7 +256,8 @@
 			gsbi2_i2c: i2c at 124a0000 {
 				compatible = "qcom,i2c-qup-v1.1.1";
 				reg = <0x124a0000 0x1000>;
-				pinctrl-0 = <&i2c2_pins &i2c2_pins_sleep>;
+				pinctrl-0 = <&i2c2_pins>;
+				pinctrl-1 = <&i2c2_pins_sleep>;
 				pinctrl-names = "default", "sleep";
 				interrupts = <0 196 IRQ_TYPE_NONE>;
 				clocks = <&gcc GSBI2_QUP_CLK>, <&gcc GSBI2_H_CLK>;
@@ -277,7 +279,8 @@
 			ranges;
 			gsbi3_i2c: i2c at 16280000 {
 				compatible = "qcom,i2c-qup-v1.1.1";
-				pinctrl-0 = <&i2c3_pins &i2c3_pins_sleep>;
+				pinctrl-0 = <&i2c3_pins>;
+				pinctrl-1 = <&i2c3_pins_sleep>;
 				pinctrl-names = "default", "sleep";
 				reg = <0x16280000 0x1000>;
 				interrupts = <GIC_SPI 151 IRQ_TYPE_NONE>;
@@ -302,7 +305,8 @@
 
 			gsbi4_i2c: i2c at 16380000 {
 				compatible = "qcom,i2c-qup-v1.1.1";
-				pinctrl-0 = <&i2c4_pins &i2c4_pins_sleep>;
+				pinctrl-0 = <&i2c4_pins>;
+				pinctrl-1 = <&i2c4_pins_sleep>;
 				pinctrl-names = "default", "sleep";
 				reg = <0x16380000 0x1000>;
 				interrupts = <GIC_SPI 153 IRQ_TYPE_NONE>;
@@ -337,7 +341,8 @@
 				compatible = "qcom,spi-qup-v1.1.1";
 				reg = <0x1a280000 0x1000>;
 				interrupts = <0 155 0>;
-				pinctrl-0 = <&spi5_default &spi5_sleep>;
+				pinctrl-0 = <&spi5_default>;
+				pinctrl-1 = <&spi5_sleep>;
 				pinctrl-names = "default", "sleep";
 				clocks = <&gcc GSBI5_QUP_CLK>, <&gcc GSBI5_H_CLK>;
 				clock-names = "core", "iface";
@@ -370,7 +375,8 @@
 
 			gsbi6_i2c: i2c at 16580000 {
 				compatible = "qcom,i2c-qup-v1.1.1";
-				pinctrl-0 = <&i2c6_pins &i2c6_pins_sleep>;
+				pinctrl-0 = <&i2c6_pins>;
+				pinctrl-1 = <&i2c6_pins_sleep>;
 				pinctrl-names = "default", "sleep";
 				reg = <0x16580000 0x1000>;
 				interrupts = <GIC_SPI 157 IRQ_TYPE_NONE>;
-- 
2.5.0
