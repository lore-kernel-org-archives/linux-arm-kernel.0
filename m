From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Fri, 17 Jun 2016 16:14:05 +0100
Subject: [PATCH 08/16] arm64: dts: msm8996: add support to blsp2_i2c1
In-Reply-To: <1466176454-28084-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1466176454-28084-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <1466176454-28084-9-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support to blsp2_i2c1, which is used in one of the
apq8096 based boards.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8996.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index 5536bfc..ef3c370 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -161,6 +161,21 @@
 			status = "disabled";
 		};
 
+		blsp2_i2c1: i2c at 075b6000 {
+			compatible = "qcom,i2c-qup-v2.2.1";
+			reg = <0x075b6000 0x1000>;
+			interrupts = <GIC_SPI 102 0>;
+			clocks = <&gcc GCC_BLSP2_AHB_CLK>,
+				<&gcc GCC_BLSP2_QUP2_I2C_APPS_CLK>;
+			clock-names = "iface", "core";
+			pinctrl-names = "default", "sleep";
+			pinctrl-0 = <&blsp2_i2c1_default>;
+			pinctrl-1 = <&blsp2_i2c1_sleep>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
 		blsp2_uart2: serial at 75b1000 {
 			compatible = "qcom,msm-uartdm-v1.4", "qcom,msm-uartdm";
 			reg = <0x075b1000 0x1000>;
-- 
2.7.4
