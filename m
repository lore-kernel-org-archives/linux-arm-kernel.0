From: stefan@agner.ch (Stefan Agner)
Date: Wed,  2 Dec 2015 14:11:46 -0800
Subject: [PATCH 1/2] ARM: dts: vf-colibri: split PWM pinctrl
Message-ID: <1449094307-6011-1-git-send-email-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Split PWM pins into separate pinctrl nodes to allow overrides which
select pins individually. This is useful for carrier boards which use
only one pin for PWM and would like to use the other pin for a
different purpose.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 arch/arm/boot/dts/vf-colibri.dtsi | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/vf-colibri.dtsi b/arch/arm/boot/dts/vf-colibri.dtsi
index e5949b9..924b660 100644
--- a/arch/arm/boot/dts/vf-colibri.dtsi
+++ b/arch/arm/boot/dts/vf-colibri.dtsi
@@ -74,12 +74,12 @@
 
 &pwm0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_pwm0>;
+	pinctrl-0 = <&pinctrl_pwm0_a &pinctrl_pwm0_c>;
 };
 
 &pwm1 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_pwm1>;
+	pinctrl-0 = <&pinctrl_pwm1_b &pinctrl_pwm1_d>;
 };
 
 &uart0 {
@@ -195,16 +195,26 @@
 			>;
 		};
 
-		pinctrl_pwm0: pwm0grp {
+		pinctrl_pwm0_a: pwm0agrp {
 			fsl,pins = <
 				VF610_PAD_PTB0__FTM0_CH0		0x1182
+			>;
+		};
+
+		pinctrl_pwm0_c: pwm0cgrp {
+			fsl,pins = <
 				VF610_PAD_PTB1__FTM0_CH1		0x1182
 			>;
 		};
 
-		pinctrl_pwm1: pwm1grp {
+		pinctrl_pwm1_b: pwm1bgrp {
 			fsl,pins = <
 				VF610_PAD_PTB8__FTM1_CH0		0x1182
+			>;
+		};
+
+		pinctrl_pwm1_d: pwm1dgrp {
+			fsl,pins = <
 				VF610_PAD_PTB9__FTM1_CH1		0x1182
 			>;
 		};
-- 
2.6.2
