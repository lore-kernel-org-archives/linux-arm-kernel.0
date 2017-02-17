From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Fri, 17 Feb 2017 00:53:23 -0800
Subject: [PATCH] arm64: dts: qcom: pm8994: Add rtc node
Message-ID: <20170217085323.4123-1-bjorn.andersson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 arch/arm64/boot/dts/qcom/pm8994.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/pm8994.dtsi b/arch/arm64/boot/dts/qcom/pm8994.dtsi
index 0f1866024ae3..b413e44fd09e 100644
--- a/arch/arm64/boot/dts/qcom/pm8994.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8994.dtsi
@@ -9,6 +9,13 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 
+		rtc at 6000 {
+			compatible = "qcom,pm8941-rtc";
+			reg = <0x6000>, <0x6100>;
+			reg-names = "rtc", "alarm";
+			interrupts = <0x0 0x61 0x1 IRQ_TYPE_EDGE_RISING>;
+		};
+
 		pm8994_gpios: gpios at c000 {
 			compatible = "qcom,pm8994-gpio";
 			reg = <0xc000>;
-- 
2.11.1
