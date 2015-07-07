From: lee.jones@linaro.org (Lee Jones)
Date: Tue,  7 Jul 2015 16:06:48 +0100
Subject: [PATCH v2 4/9] ARM: STi: STiH407: Move PWM nodes STiH407 =>
 STiH407-family
In-Reply-To: <1436281613-899-1-git-send-email-lee.jones@linaro.org>
References: <1436281613-899-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1436281613-899-5-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This also incorporates the STiH410.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/stih407-family.dtsi | 30 ++++++++++++++++++++++++++++++
 arch/arm/boot/dts/stih407.dtsi        | 28 ----------------------------
 2 files changed, 30 insertions(+), 28 deletions(-)

diff --git a/arch/arm/boot/dts/stih407-family.dtsi b/arch/arm/boot/dts/stih407-family.dtsi
index 838b812..64a1a26 100644
--- a/arch/arm/boot/dts/stih407-family.dtsi
+++ b/arch/arm/boot/dts/stih407-family.dtsi
@@ -539,6 +539,7 @@
 			status = "disabled";
 		};
 
+
 		st_dwc3: dwc3 at 8f94000 {
 			compatible	= "st,stih407-dwc3";
 			reg		= <0x08f94000 0x1000>, <0x110 0x4>;
@@ -565,5 +566,34 @@
 						  <&phy_port2 PHY_TYPE_USB3>;
 			};
 		};
+
+		/* COMMS PWM Module */
+		pwm0: pwm at 9810000 {
+			compatible	= "st,sti-pwm";
+			status		= "okay";
+			#pwm-cells	= <2>;
+			reg		= <0x9810000 0x68>;
+			pinctrl-names	= "default";
+			pinctrl-0	= <&pinctrl_pwm0_chan0_default>;
+			clock-names	= "pwm";
+			clocks		= <&clk_sysin>;
+			st,pwm-num-chan = <1>;
+		};
+
+		/* SBC PWM Module */
+		pwm1: pwm at 9510000 {
+			compatible	= "st,sti-pwm";
+			status		= "okay";
+			#pwm-cells	= <2>;
+			reg		= <0x9510000 0x68>;
+			pinctrl-names	= "default";
+			pinctrl-0	= <&pinctrl_pwm1_chan0_default
+					&pinctrl_pwm1_chan1_default
+					&pinctrl_pwm1_chan2_default
+					&pinctrl_pwm1_chan3_default>;
+			clock-names	= "pwm";
+			clocks		= <&clk_sysin>;
+			st,pwm-num-chan = <4>;
+		};
 	};
 };
diff --git a/arch/arm/boot/dts/stih407.dtsi b/arch/arm/boot/dts/stih407.dtsi
index 2c560fc3..3efa3b2 100644
--- a/arch/arm/boot/dts/stih407.dtsi
+++ b/arch/arm/boot/dts/stih407.dtsi
@@ -147,33 +147,5 @@
 				};
 			};
 		};
-
-		/* COMMS PWM Module */
-		pwm0: pwm at 9810000 {
-			compatible	= "st,sti-pwm";
-			status		= "disabled";
-			#pwm-cells	= <2>;
-			reg		= <0x9810000 0x68>;
-			pinctrl-names	= "default";
-			pinctrl-0	= <&pinctrl_pwm0_chan0_default>;
-			clock-names	= "pwm";
-			clocks		= <&clk_sysin>;
-		};
-
-		/* SBC PWM Module */
-		pwm1: pwm at 9510000 {
-			compatible	= "st,sti-pwm";
-			status		= "disabled";
-			#pwm-cells	= <2>;
-			reg		= <0x9510000 0x68>;
-			pinctrl-names	= "default";
-			pinctrl-0	= <&pinctrl_pwm1_chan0_default
-					&pinctrl_pwm1_chan1_default
-					&pinctrl_pwm1_chan2_default
-					&pinctrl_pwm1_chan3_default>;
-			clock-names	= "pwm";
-			clocks		= <&clk_sysin>;
-			st,pwm-num-chan = <4>;
-		};
 	};
 };
-- 
1.9.1
