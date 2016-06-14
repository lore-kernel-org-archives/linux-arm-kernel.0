From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 14 Jun 2016 17:30:55 +0200
Subject: [PATCH 1/5] ARM: dts: add GPIO and MPP to MSM8660 PMIC
In-Reply-To: <1465918259-11138-1-git-send-email-linus.walleij@linaro.org>
References: <1465918259-11138-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <1465918259-11138-2-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the 8660 PMIC GPIO and MPP blocks to the MSM8660
DTSI. Verified against the vendor tree to be in these locations
with these interrupts, tested on the APQ8060 Dragonboard.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/qcom-msm8660.dtsi | 38 +++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-msm8660.dtsi b/arch/arm/boot/dts/qcom-msm8660.dtsi
index cd214030b84a..6a62b62ad980 100644
--- a/arch/arm/boot/dts/qcom-msm8660.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8660.dtsi
@@ -143,6 +143,44 @@
 				#address-cells = <1>;
 				#size-cells = <0>;
 
+				pm8058_gpio: gpio at 150 {
+					compatible = "qcom,pm8058-gpio",
+						     "qcom,ssbi-gpio";
+					reg = <0x150>;
+					interrupt-parent = <&pmicintc>;
+					interrupts = <192 1>, <193 1>, <194 1>,
+						     <195 1>, <196 1>, <197 1>,
+						     <198 1>, <199 1>, <200 1>,
+						     <201 1>, <202 1>, <203 1>,
+						     <204 1>, <205 1>, <206 1>,
+						     <207 1>, <208 1>, <209 1>,
+						     <210 1>, <211 1>, <212 1>,
+						     <213 1>, <214 1>, <215 1>,
+						     <216 1>, <217 1>, <218 1>,
+						     <219 1>, <220 1>, <221 1>,
+						     <222 1>, <223 1>, <224 1>,
+						     <225 1>, <226 1>, <227 1>,
+						     <228 1>, <229 1>, <230 1>,
+						     <231 1>, <232 1>, <233 1>,
+						     <234 1>, <235 1>;
+					gpio-controller;
+					#gpio-cells = <2>;
+
+				};
+
+				pm8058_mpps: mpps at 50 {
+					compatible = "qcom,pm8058-mpp",
+						     "qcom,ssbi-mpp";
+					reg = <0x50>;
+					gpio-controller;
+					#gpio-cells = <2>;
+					interrupt-parent = <&pmicintc>;
+					interrupts =
+					<128 1>, <129 1>, <130 1>, <131 1>,
+					<132 1>, <133 1>, <134 1>, <135 1>,
+					<136 1>, <137 1>, <138 1>, <139 1>;
+				};
+
 				pwrkey at 1c {
 					compatible = "qcom,pm8058-pwrkey";
 					reg = <0x1c>;
-- 
2.4.11
