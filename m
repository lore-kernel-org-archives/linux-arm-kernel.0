From: LW@KARO-electronics.de (=?UTF-8?q?Lothar=20Wa=C3=9Fmann?=)
Date: Tue, 12 Jan 2016 18:21:23 +0100
Subject: [PATCH 06/14] ARM: dts: imx6ul: disable PWMs by default
In-Reply-To: <1452619291-13625-6-git-send-email-LW@KARO-electronics.de>
References: <1452619291-13625-1-git-send-email-LW@KARO-electronics.de>
 <1452619291-13625-2-git-send-email-LW@KARO-electronics.de>
 <1452619291-13625-3-git-send-email-LW@KARO-electronics.de>
 <1452619291-13625-4-git-send-email-LW@KARO-electronics.de>
 <1452619291-13625-5-git-send-email-LW@KARO-electronics.de>
 <1452619291-13625-6-git-send-email-LW@KARO-electronics.de>
Message-ID: <1452619291-13625-7-git-send-email-LW@KARO-electronics.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since PWMs are only useful if they are actually connected to an output pin,
let users enable them explicitly in their device trees where they should
also set up the pin configuration.

Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
---
 arch/arm/boot/dts/imx6ul.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/imx6ul.dtsi b/arch/arm/boot/dts/imx6ul.dtsi
index 3aba0bb..863777e 100644
--- a/arch/arm/boot/dts/imx6ul.dtsi
+++ b/arch/arm/boot/dts/imx6ul.dtsi
@@ -512,6 +512,7 @@
 					 <&clks IMX6UL_CLK_PWM5>;
 				clock-names = "ipg", "per";
 				#pwm-cells = <2>;
+				status = "disabled";
 			};
 
 			pwm6: pwm at 020f4000 {
@@ -522,6 +523,7 @@
 					 <&clks IMX6UL_CLK_PWM6>;
 				clock-names = "ipg", "per";
 				#pwm-cells = <2>;
+				status = "disabled";
 			};
 
 			pwm7: pwm at 020f8000 {
@@ -532,6 +534,7 @@
 					 <&clks IMX6UL_CLK_PWM7>;
 				clock-names = "ipg", "per";
 				#pwm-cells = <2>;
+				status = "disabled";
 			};
 
 			pwm8: pwm at 020fc000 {
@@ -542,6 +545,7 @@
 					 <&clks IMX6UL_CLK_PWM8>;
 				clock-names = "ipg", "per";
 				#pwm-cells = <2>;
+				status = "disabled";
 			};
 		};
 
-- 
2.1.4
