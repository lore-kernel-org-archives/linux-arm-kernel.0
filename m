From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Mon, 28 Mar 2016 18:32:38 -0700
Subject: [PATCH 3/4] ARM: dts: msm8974: Add node for second i2c from blsp1
In-Reply-To: <1459215159-2576-1-git-send-email-bjorn.andersson@linaro.org>
References: <1459215159-2576-1-git-send-email-bjorn.andersson@linaro.org>
Message-ID: <1459215159-2576-3-git-send-email-bjorn.andersson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 arch/arm/boot/dts/qcom-msm8974.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom-msm8974.dtsi
index 1afee408a923..d872ddc2d190 100644
--- a/arch/arm/boot/dts/qcom-msm8974.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
@@ -445,6 +445,17 @@
 			interrupts = <0 208 0>;
 		};
 
+		i2c at f9924000 {
+			status = "disabled";
+			compatible = "qcom,i2c-qup-v2.1.1";
+			reg = <0xf9924000 0x1000>;
+			interrupts = <0 96 IRQ_TYPE_NONE>;
+			clocks = <&gcc GCC_BLSP1_QUP2_I2C_APPS_CLK>, <&gcc GCC_BLSP1_AHB_CLK>;
+			clock-names = "core", "iface";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
 		blsp_i2c8: i2c at f9964000 {
 			status = "disabled";
 			compatible = "qcom,i2c-qup-v2.1.1";
-- 
2.5.0
