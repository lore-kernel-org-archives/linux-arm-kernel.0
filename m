From: bjorn.andersson@sonymobile.com (Bjorn Andersson)
Date: Tue, 20 Oct 2015 21:57:44 -0700
Subject: [PATCH 1/7] ARM: dts: qcom: msm8974-honami: Define pinctrl state for
 blsp_uart2
Message-ID: <1445403470-17434-1-git-send-email-bjorn.andersson@sonymobile.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make sure the blsp1_uart2 pins are in the correct state for the uart.

Signed-off-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>
---
 .../boot/dts/qcom-msm8974-sony-xperia-honami.dts   | 23 ++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-msm8974-sony-xperia-honami.dts b/arch/arm/boot/dts/qcom-msm8974-sony-xperia-honami.dts
index 016f9ad9392a..6f7e4ef4ccf7 100644
--- a/arch/arm/boot/dts/qcom-msm8974-sony-xperia-honami.dts
+++ b/arch/arm/boot/dts/qcom-msm8974-sony-xperia-honami.dts
@@ -23,6 +23,29 @@
 &soc {
 	serial at f991e000 {
 		status = "ok";
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&blsp1_uart2_pin_a>;
+	};
+
+	pinctrl at fd510000 {
+		blsp1_uart2_pin_a: blsp1-uart2-pin-active {
+			rx {
+				pins = "gpio5";
+				function = "blsp_uart2";
+
+				drive-strength = <2>;
+				bias-pull-up;
+			};
+
+			tx {
+				pins = "gpio4";
+				function = "blsp_uart2";
+
+				drive-strength = <4>;
+				bias-disable;
+			};
+		};
 	};
 };
 
-- 
2.4.2
