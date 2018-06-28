From: jbrunet@baylibre.com (Jerome Brunet)
Date: Thu, 28 Jun 2018 11:50:52 +0200
Subject: [PATCH 1/3] ARM64: dts: meson-axg: add s400 microphone card leds
In-Reply-To: <20180628095054.13433-1-jbrunet@baylibre.com>
References: <20180628095054.13433-1-jbrunet@baylibre.com>
Message-ID: <20180628095054.13433-2-jbrunet@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The microphone card connected to the s400 has 6 leds controlled
through an additional i2c gpio controller.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-axg-s400.dts | 42 ++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
index dff9b15eb3c0..d926f8956db8 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
@@ -62,6 +62,40 @@
 		clock-frequency = <32768>;
 		pwms = <&pwm_ab 0 30518 0>; /* PWM_A at 32.768KHz */
 	};
+
+	speaker-leds {
+		compatible = "gpio-leds";
+
+		aled1 {
+			label = "speaker:aled1";
+			gpios = <&gpio_speaker 7 0>;
+		};
+
+		aled2 {
+			label = "speaker:aled2";
+			gpios = <&gpio_speaker 6 0>;
+		};
+
+		aled3 {
+			label = "speaker:aled3";
+			gpios = <&gpio_speaker 5 0>;
+		};
+
+		aled4 {
+			label = "speaker:aled4";
+			gpios = <&gpio_speaker 4 0>;
+		};
+
+		aled5 {
+			label = "speaker:aled5";
+			gpios = <&gpio_speaker 3 0>;
+		};
+
+		aled6 {
+			label = "speaker:aled6";
+			gpios = <&gpio_speaker 2 0>;
+		};
+	};
 };
 
 &ethmac {
@@ -112,6 +146,14 @@
 	status = "okay";
 	pinctrl-0 = <&i2c_ao_sck_10_pins>, <&i2c_ao_sda_11_pins>;
 	pinctrl-names = "default";
+
+	gpio_speaker: gpio-controller at 1f {
+		compatible = "nxp,pca9557";
+		reg = <0x1f>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		vcc-supply = <&vddao_3v3>;
+	};
 };
 
 &pwm_ab {
-- 
2.14.4
