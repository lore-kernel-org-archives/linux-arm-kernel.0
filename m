From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Fri, 17 Jun 2016 16:14:09 +0100
Subject: [PATCH 12/16] arm64: dts: msm8996: add support to blsp1_spi0
In-Reply-To: <1466176454-28084-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1466176454-28084-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <1466176454-28084-13-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support to blsp1_spi0 which is used on some of APQ8096
based boards.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8996.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index 675888f..e009063 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -151,6 +151,21 @@
 			reg = <0x300000 0x90000>;
 		};
 
+		blsp1_spi0: spi at 07575000 {
+			compatible = "qcom,spi-qup-v2.2.1";
+			reg = <0x07575000 0x600>;
+			interrupts = <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gcc GCC_BLSP1_QUP1_SPI_APPS_CLK>,
+				 <&gcc GCC_BLSP1_AHB_CLK>;
+			clock-names = "core", "iface";
+			pinctrl-names = "default", "sleep";
+			pinctrl-0 = <&blsp1_spi0_default>;
+			pinctrl-1 = <&blsp1_spi0_sleep>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
 		blsp2_i2c0: i2c at 075b5000 {
 			compatible = "qcom,i2c-qup-v2.2.1";
 			reg = <0x075b5000 0x1000>;
-- 
2.7.4
