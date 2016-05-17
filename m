From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 17 May 2016 23:56:10 +0800
Subject: [PATCH 5/6] ARM: dts: sun5i: q8-common: Enable audio codec
In-Reply-To: <1463500571-28970-1-git-send-email-wens@csie.org>
References: <1463500571-28970-1-git-send-email-wens@csie.org>
Message-ID: <1463500571-28970-6-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Q8 tablets use the audio codec to provide audio output via a
headphone jack or a small mono speaker. A GPIO output is used to
control speaker amp.

The tablets may or may not have an internal microphone.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun5i-q8-common.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/sun5i-q8-common.dtsi b/arch/arm/boot/dts/sun5i-q8-common.dtsi
index 8fc1b6110fb8..5b065fd542f0 100644
--- a/arch/arm/boot/dts/sun5i-q8-common.dtsi
+++ b/arch/arm/boot/dts/sun5i-q8-common.dtsi
@@ -61,6 +61,13 @@
 	};
 };
 
+&codec {
+	pinctrl-names = "default";
+	pinctrl-0 = <&codec_pa_pin>;
+	allwinner,pa-gpios = <&pio 6 10 GPIO_ACTIVE_HIGH>; /* PG10 */
+	status = "okay";
+};
+
 &cpu0 {
 	cpu-supply = <&reg_dcdc2>;
 };
@@ -100,6 +107,13 @@
 };
 
 &pio {
+	codec_pa_pin: codec_pa_pin at 0 {
+		allwinner,pins = "PG10";
+		allwinner,function = "gpio_out";
+		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+	};
+
 	mmc0_cd_pin_q8: mmc0_cd_pin at 0 {
 		allwinner,pins = "PG0";
 		allwinner,function = "gpio_in";
-- 
2.8.1
