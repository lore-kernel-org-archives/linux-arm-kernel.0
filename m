From: stefan@agner.ch (Stefan Agner)
Date: Tue, 16 May 2017 00:40:13 -0700
Subject: [PATCH] ARM: dts: imx7: use 3 PWM cells
Message-ID: <20170516074013.3571-1-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The PWM driver has now capability to specify the PWM polarity
which is e.g. for backlight control. Allow to make use of PWM
polarity by specifying pwm-cells to be 3 in the base dt.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 arch/arm/boot/dts/imx7-colibri.dtsi   | 2 +-
 arch/arm/boot/dts/imx7d-nitrogen7.dts | 2 +-
 arch/arm/boot/dts/imx7s.dtsi          | 8 ++++----
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/imx7-colibri.dtsi b/arch/arm/boot/dts/imx7-colibri.dtsi
index 2d87489f9105..d7753f79937a 100644
--- a/arch/arm/boot/dts/imx7-colibri.dtsi
+++ b/arch/arm/boot/dts/imx7-colibri.dtsi
@@ -43,7 +43,7 @@
 / {
 	bl: backlight {
 		compatible = "pwm-backlight";
-		pwms = <&pwm1 0 5000000>;
+		pwms = <&pwm1 0 5000000 0>;
 	};
 
 	reg_module_3v3: regulator-module-3v3 {
diff --git a/arch/arm/boot/dts/imx7d-nitrogen7.dts b/arch/arm/boot/dts/imx7d-nitrogen7.dts
index 5d98e2b5d54b..37a7c6f4f8f1 100644
--- a/arch/arm/boot/dts/imx7d-nitrogen7.dts
+++ b/arch/arm/boot/dts/imx7d-nitrogen7.dts
@@ -67,7 +67,7 @@
 
 	backlight-j20 {
 		compatible = "pwm-backlight";
-		pwms = <&pwm1 0 5000000>;
+		pwms = <&pwm1 0 5000000 0>;
 		brightness-levels = <0 4 8 16 32 64 128 255>;
 		default-brightness-level = <6>;
 		status = "okay";
diff --git a/arch/arm/boot/dts/imx7s.dtsi b/arch/arm/boot/dts/imx7s.dtsi
index c4f12fd2e044..56a2aeadfe65 100644
--- a/arch/arm/boot/dts/imx7s.dtsi
+++ b/arch/arm/boot/dts/imx7s.dtsi
@@ -609,7 +609,7 @@
 				clocks = <&clks IMX7D_PWM1_ROOT_CLK>,
 					 <&clks IMX7D_PWM1_ROOT_CLK>;
 				clock-names = "ipg", "per";
-				#pwm-cells = <2>;
+				#pwm-cells = <3>;
 				status = "disabled";
 			};
 
@@ -620,7 +620,7 @@
 				clocks = <&clks IMX7D_PWM2_ROOT_CLK>,
 					 <&clks IMX7D_PWM2_ROOT_CLK>;
 				clock-names = "ipg", "per";
-				#pwm-cells = <2>;
+				#pwm-cells = <3>;
 				status = "disabled";
 			};
 
@@ -631,7 +631,7 @@
 				clocks = <&clks IMX7D_PWM3_ROOT_CLK>,
 					 <&clks IMX7D_PWM3_ROOT_CLK>;
 				clock-names = "ipg", "per";
-				#pwm-cells = <2>;
+				#pwm-cells = <3>;
 				status = "disabled";
 			};
 
@@ -642,7 +642,7 @@
 				clocks = <&clks IMX7D_PWM4_ROOT_CLK>,
 					 <&clks IMX7D_PWM4_ROOT_CLK>;
 				clock-names = "ipg", "per";
-				#pwm-cells = <2>;
+				#pwm-cells = <3>;
 				status = "disabled";
 			};
 
-- 
2.13.0
