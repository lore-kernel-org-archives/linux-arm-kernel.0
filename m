From: achew@nvidia.com (Andrew Chew)
Date: Mon, 1 Apr 2013 14:53:25 -0700
Subject: [PATCH V6 6/9] ARM: mxs: Provide regulator to pwm-backlight
In-Reply-To: <1364853208-32503-1-git-send-email-achew@nvidia.com>
References: <1364853208-32503-1-git-send-email-achew@nvidia.com>
Message-ID: <1364853208-32503-7-git-send-email-achew@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The pwm-backlight driver now takes a mandatory regulator that is gotten
during driver probe.  Initialize a dummy regulator to satisfy this
requirement.

Signed-off-by: Andrew Chew <achew@nvidia.com>
Acked-by: Alexandre Courbot <acourbot@nvidia.com>
Acked-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/boot/dts/imx23-evk.dts      |  6 ++++++
 arch/arm/boot/dts/imx28-apf28dev.dts |  6 ++++++
 arch/arm/boot/dts/imx28-cfa10049.dts |  6 ++++++
 arch/arm/boot/dts/imx28-evk.dts      |  6 ++++++
 arch/arm/boot/dts/imx28-tx28.dts     | 11 +++++++++++
 5 files changed, 35 insertions(+)

diff --git a/arch/arm/boot/dts/imx23-evk.dts b/arch/arm/boot/dts/imx23-evk.dts
index 035c13f..ce5048e 100644
--- a/arch/arm/boot/dts/imx23-evk.dts
+++ b/arch/arm/boot/dts/imx23-evk.dts
@@ -95,6 +95,11 @@
 			regulator-max-microvolt = <3300000>;
 			gpio = <&gpio1 29 0>;
 		};
+
+		reg_backlight_power: fixed-regulator {
+			compatible = "regulator-fixed";
+			regulator-name = "backlight-power";
+	        };
 	};
 
 	backlight {
@@ -102,5 +107,6 @@
 		pwms = <&pwm 2 5000000>;
 		brightness-levels = <0 4 8 16 32 64 128 255>;
 		default-brightness-level = <6>;
+		power-supply = <&reg_backlight_power>;
 	};
 };
diff --git a/arch/arm/boot/dts/imx28-apf28dev.dts b/arch/arm/boot/dts/imx28-apf28dev.dts
index 6d8865b..e354dc5 100644
--- a/arch/arm/boot/dts/imx28-apf28dev.dts
+++ b/arch/arm/boot/dts/imx28-apf28dev.dts
@@ -132,6 +132,11 @@
 			regulator-max-microvolt = <5000000>;
 			gpio = <&gpio1 23 1>;
 		};
+
+		reg_backlight_power: fixed-regulator {
+			compatible = "regulator-fixed";
+			regulator-name = "backlight-power";
+		};
 	};
 
 	leds {
@@ -150,5 +155,6 @@
 		pwms = <&pwm 3 191000>;
 		brightness-levels = <0 4 8 16 32 64 128 255>;
 		default-brightness-level = <6>;
+		power-supply = <&reg_backlight_power>;
 	};
 };
diff --git a/arch/arm/boot/dts/imx28-cfa10049.dts b/arch/arm/boot/dts/imx28-cfa10049.dts
index a0d3e9f..a6eddd6 100644
--- a/arch/arm/boot/dts/imx28-cfa10049.dts
+++ b/arch/arm/boot/dts/imx28-cfa10049.dts
@@ -205,6 +205,11 @@
 			regulator-max-microvolt = <5000000>;
 			gpio = <&gpio0 7 1>;
 		};
+
+		reg_backlight_power: fixed-regulator {
+			compatible = "regulator-fixed";
+			regulator-name = "backlight-power";
+		};
 	};
 
 	ahb at 80080000 {
@@ -304,5 +309,6 @@
 		pwms = <&pwm 3 5000000>;
 		brightness-levels = <0 4 8 16 32 64 128 255>;
 		default-brightness-level = <6>;
+		power-supply = <&reg_backlight_power>;
 	};
 };
diff --git a/arch/arm/boot/dts/imx28-evk.dts b/arch/arm/boot/dts/imx28-evk.dts
index 2da316e..7ba7216 100644
--- a/arch/arm/boot/dts/imx28-evk.dts
+++ b/arch/arm/boot/dts/imx28-evk.dts
@@ -285,6 +285,11 @@
 			gpio = <&gpio3 8 0>;
 			enable-active-high;
 		};
+
+		reg_backlight_power: fixed-regulator {
+			compatible = "regulator-fixed";
+			regulator-name = "backlight-power";
+		};
 	};
 
 	sound {
@@ -312,5 +317,6 @@
 		pwms = <&pwm 2 5000000>;
 		brightness-levels = <0 4 8 16 32 64 128 255>;
 		default-brightness-level = <6>;
+		power-supply = <&reg_backlight_power>;
 	};
 };
diff --git a/arch/arm/boot/dts/imx28-tx28.dts b/arch/arm/boot/dts/imx28-tx28.dts
index 37be532..7fa5a44 100644
--- a/arch/arm/boot/dts/imx28-tx28.dts
+++ b/arch/arm/boot/dts/imx28-tx28.dts
@@ -97,6 +97,16 @@
 		};
 	};
 
+	regulators {
+		compatible = "simple-bus";
+
+		reg_backlight_power: fixed-regulator {
+			compatible = "regulator-fixed";
+			regulator-name = "backlight-power";
+		};
+	};
+
+
 	leds {
 		compatible = "gpio-leds";
 
@@ -112,5 +122,6 @@
 		pwms = <&pwm 0 5000000>;
 		brightness-levels = <0 4 8 16 32 64 128 255>;
 		default-brightness-level = <6>;
+		power-supply = <&reg_backlight_power>;
 	};
 };
-- 
1.8.1.5
