From: bjorn.andersson@sonymobile.com (Bjorn Andersson)
Date: Tue, 20 Oct 2015 21:57:46 -0700
Subject: [PATCH 3/7] ARM: dts: qcom: msm8974-honami: Introduce gpio-keys
In-Reply-To: <1445403470-17434-1-git-send-email-bjorn.andersson@sonymobile.com>
References: <1445403470-17434-1-git-send-email-bjorn.andersson@sonymobile.com>
Message-ID: <1445403470-17434-3-git-send-email-bjorn.andersson@sonymobile.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Introduce a gpio-keys node defining the physical keys of the Honami and
the associated pinctrl state.

Signed-off-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>
---
 .../boot/dts/qcom-msm8974-sony-xperia-honami.dts   | 45 ++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-msm8974-sony-xperia-honami.dts b/arch/arm/boot/dts/qcom-msm8974-sony-xperia-honami.dts
index 5768c97bb124..8c0753a32b20 100644
--- a/arch/arm/boot/dts/qcom-msm8974-sony-xperia-honami.dts
+++ b/arch/arm/boot/dts/qcom-msm8974-sony-xperia-honami.dts
@@ -2,6 +2,7 @@
 #include "qcom-pm8841.dtsi"
 #include "qcom-pm8941.dtsi"
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
 #include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
 
 / {
@@ -16,6 +17,42 @@
 		stdout-path = "serial0:115200n8";
 	};
 
+	gpio-keys {
+		compatible = "gpio-keys";
+		input-name = "gpio-keys";
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&gpio_keys_pin_a>;
+
+		volume-down {
+			label = "volume_down";
+			gpios = <&pm8941_gpios 2 GPIO_ACTIVE_LOW>;
+			linux,input-type = <1>;
+			linux,code = <KEY_VOLUMEDOWN>;
+		};
+
+		camera-snapshot {
+			label = "camera_snapshot";
+			gpios = <&pm8941_gpios 3 GPIO_ACTIVE_LOW>;
+			linux,input-type = <1>;
+			linux,code = <KEY_CAMERA>;
+		};
+
+		camera-focus {
+			label = "camera_focus";
+			gpios = <&pm8941_gpios 4 GPIO_ACTIVE_LOW>;
+			linux,input-type = <1>;
+			linux,code = <KEY_CAMERA_FOCUS>;
+		};
+
+		volume-up {
+			label = "volume_up";
+			gpios = <&pm8941_gpios 5 GPIO_ACTIVE_LOW>;
+			linux,input-type = <1>;
+			linux,code = <KEY_VOLUMEUP>;
+		};
+	};
+
 	memory at 0 {
 		reg = <0 0x40000000>, <0x40000000 0x40000000>;
 		device_type = "memory";
@@ -275,6 +312,14 @@
 				pins = "gpio21";
 				function = "normal";
 			};
+
+			gpio_keys_pin_a: gpio-keys-active {
+				pins = "gpio2", "gpio3", "gpio4", "gpio5";
+				function = "normal";
+
+				bias-pull-up;
+				power-source = <PM8941_GPIO_S3>;
+			};
 		};
 
 		coincell at 2800 {
-- 
2.4.2
