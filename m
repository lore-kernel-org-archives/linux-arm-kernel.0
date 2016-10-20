From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 20 Oct 2016 15:49:06 +0200
Subject: [PATCH v3 5/6] ARM: sunxi: Remove useless allwinner,pull property
In-Reply-To: <cover.f893b02a9f816dad8fad3986672b05c4b211e2b1.1476971126.git-series.maxime.ripard@free-electrons.com>
References: <cover.f893b02a9f816dad8fad3986672b05c4b211e2b1.1476971126.git-series.maxime.ripard@free-electrons.com>
Message-ID: <42e249454ccf6b14e9ec266cb8d42a24f6d71d7b.1476971126.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The allwinner,pull property set to NO_PULL was really considered our
default (and wasn't even changing the default value in the code).

Remove these properties to make it obvious that we do not set anything in
such a case.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Acked-by: Chen-Yu Tsai <wens@csie.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/ntc-gr8-evb.dts                     |  4 +-
 arch/arm/boot/dts/ntc-gr8.dtsi                        | 14 +-----
 arch/arm/boot/dts/sun4i-a10-a1000.dts                 |  2 +-
 arch/arm/boot/dts/sun4i-a10-cubieboard.dts            |  1 +-
 arch/arm/boot/dts/sun4i-a10-dserve-dsrv9703c.dts      |  4 +-
 arch/arm/boot/dts/sun4i-a10-gemei-g9.dts              |  1 +-
 arch/arm/boot/dts/sun4i-a10-hackberry.dts             |  2 +-
 arch/arm/boot/dts/sun4i-a10-inet1.dts                 |  2 +-
 arch/arm/boot/dts/sun4i-a10-jesurun-q5.dts            |  2 +-
 arch/arm/boot/dts/sun4i-a10-marsboard.dts             |  1 +-
 arch/arm/boot/dts/sun4i-a10-mk802.dts                 |  3 +-
 arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts        |  2 +-
 arch/arm/boot/dts/sun4i-a10-pcduino.dts               |  2 +-
 arch/arm/boot/dts/sun4i-a10-pcduino2.dts              |  1 +-
 arch/arm/boot/dts/sun4i-a10-pov-protab2-ips9.dts      |  3 +-
 arch/arm/boot/dts/sun4i-a10.dtsi                      | 24 +--------
 arch/arm/boot/dts/sun5i-a10s-auxtek-t003.dts          |  1 +-
 arch/arm/boot/dts/sun5i-a10s-auxtek-t004.dts          |  2 +-
 arch/arm/boot/dts/sun5i-a10s-mk802.dts                |  2 +-
 arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts      |  2 +-
 arch/arm/boot/dts/sun5i-a10s-r7-tv-dongle.dts         |  2 +-
 arch/arm/boot/dts/sun5i-a10s-wobo-i5.dts              |  2 +-
 arch/arm/boot/dts/sun5i-a10s.dtsi                     |  7 +--
 arch/arm/boot/dts/sun5i-a13-hsg-h702.dts              |  1 +-
 arch/arm/boot/dts/sun5i-a13-olinuxino-micro.dts       |  3 +-
 arch/arm/boot/dts/sun5i-a13-olinuxino.dts             |  2 +-
 arch/arm/boot/dts/sun5i-a13-utoo-p66.dts              |  1 +-
 arch/arm/boot/dts/sun5i-a13.dtsi                      |  3 +-
 arch/arm/boot/dts/sun5i-r8-chip.dts                   |  2 +-
 arch/arm/boot/dts/sun5i-reference-design-tablet.dtsi  |  2 +-
 arch/arm/boot/dts/sun5i.dtsi                          |  7 +--
 arch/arm/boot/dts/sun6i-a31-app4-evb1.dts             |  1 +-
 arch/arm/boot/dts/sun6i-a31-colombus.dts              |  1 +-
 arch/arm/boot/dts/sun6i-a31-hummingbird.dts           |  2 +-
 arch/arm/boot/dts/sun6i-a31-i7.dts                    |  2 +-
 arch/arm/boot/dts/sun6i-a31-m9.dts                    |  2 +-
 arch/arm/boot/dts/sun6i-a31-mele-a1000g-quad.dts      |  2 +-
 arch/arm/boot/dts/sun6i-a31.dtsi                      | 13 +----
 arch/arm/boot/dts/sun6i-a31s-primo81.dts              |  1 +-
 arch/arm/boot/dts/sun6i-a31s-sina31s.dts              |  1 +-
 arch/arm/boot/dts/sun6i-a31s-sinovoip-bpi-m2.dts      |  3 +-
 arch/arm/boot/dts/sun7i-a20-bananapi-m1-plus.dts      |  3 +-
 arch/arm/boot/dts/sun7i-a20-bananapi.dts              |  2 +-
 arch/arm/boot/dts/sun7i-a20-bananapro.dts             |  5 +--
 arch/arm/boot/dts/sun7i-a20-cubieboard2.dts           |  1 +-
 arch/arm/boot/dts/sun7i-a20-cubietruck.dts            |  6 +--
 arch/arm/boot/dts/sun7i-a20-hummingbird.dts           |  4 +-
 arch/arm/boot/dts/sun7i-a20-i12-tvbox.dts             |  4 +-
 arch/arm/boot/dts/sun7i-a20-itead-ibox.dts            |  1 +-
 arch/arm/boot/dts/sun7i-a20-lamobo-r1.dts             |  2 +-
 arch/arm/boot/dts/sun7i-a20-m3.dts                    |  1 +-
 arch/arm/boot/dts/sun7i-a20-mk808c.dts                |  2 +-
 arch/arm/boot/dts/sun7i-a20-olimex-som-evb.dts        |  4 +-
 arch/arm/boot/dts/sun7i-a20-olinuxino-lime.dts        |  2 +-
 arch/arm/boot/dts/sun7i-a20-olinuxino-lime2-emmc.dts  |  1 +-
 arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts       |  3 +-
 arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts       |  1 +-
 arch/arm/boot/dts/sun7i-a20-orangepi-mini.dts         |  4 +-
 arch/arm/boot/dts/sun7i-a20-orangepi.dts              |  4 +-
 arch/arm/boot/dts/sun7i-a20-pcduino3-nano.dts         |  3 +-
 arch/arm/boot/dts/sun7i-a20-pcduino3.dts              |  2 +-
 arch/arm/boot/dts/sun7i-a20-wexler-tab7200.dts        |  3 +-
 arch/arm/boot/dts/sun7i-a20-wits-pro-a20-dkt.dts      |  1 +-
 arch/arm/boot/dts/sun7i-a20.dtsi                      | 37 +------------
 arch/arm/boot/dts/sun8i-a23-a33.dtsi                  | 10 +---
 arch/arm/boot/dts/sun8i-a23-polaroid-mid2407pxe03.dts |  1 +-
 arch/arm/boot/dts/sun8i-a23-polaroid-mid2809pxe04.dts |  1 +-
 arch/arm/boot/dts/sun8i-a33-inet-d978-rev2.dts        |  1 +-
 arch/arm/boot/dts/sun8i-a33-olinuxino.dts             |  3 +-
 arch/arm/boot/dts/sun8i-a33.dtsi                      |  1 +-
 arch/arm/boot/dts/sun8i-a83t.dtsi                     |  3 +-
 arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dts       |  3 +-
 arch/arm/boot/dts/sun8i-h3-nanopi-neo.dts             |  2 +-
 arch/arm/boot/dts/sun8i-h3-orangepi-2.dts             |  4 +-
 arch/arm/boot/dts/sun8i-h3-orangepi-lite.dts          |  3 +-
 arch/arm/boot/dts/sun8i-h3-orangepi-one.dts           |  3 +-
 arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts            |  3 +-
 arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts          |  1 +-
 arch/arm/boot/dts/sun8i-h3.dtsi                       | 12 +----
 arch/arm/boot/dts/sun8i-r16-parrot.dts                |  3 +-
 arch/arm/boot/dts/sun8i-reference-design-tablet.dtsi  |  2 +-
 arch/arm/boot/dts/sun9i-a80-cubieboard4.dts           |  1 +-
 arch/arm/boot/dts/sun9i-a80-optimus.dts               |  4 +-
 arch/arm/boot/dts/sun9i-a80.dtsi                      |  6 +--
 arch/arm/boot/dts/sunxi-common-regulators.dtsi        |  4 +-
 85 files changed, 0 insertions(+), 302 deletions(-)

diff --git a/arch/arm/boot/dts/ntc-gr8-evb.dts b/arch/arm/boot/dts/ntc-gr8-evb.dts
index 04a474471adc..5a97dea32f98 100644
--- a/arch/arm/boot/dts/ntc-gr8-evb.dts
+++ b/arch/arm/boot/dts/ntc-gr8-evb.dts
@@ -228,25 +228,21 @@
 	mmc0_cd_pin_gr8_evb: mmc0-cd-pin at 0 {
 		allwinner,pins = "PG0";
 		allwinner,function = "gpio_in";
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 
 	usb0_id_pin_gr8_evb: usb0-id-pin at 0 {
 		allwinner,pins = "PG2";
 		allwinner,function = "gpio_in";
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 
 	usb0_vbus_det_pin_gr8_evb: usb0-vbus-det-pin at 0 {
 		allwinner,pins = "PG1";
 		allwinner,function = "gpio_in";
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 
 	usb1_vbus_pin_gr8_evb: usb1-vbus-pin at 0 {
 		allwinner,pins = "PG13";
 		allwinner,function = "gpio_out";
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 };
 
diff --git a/arch/arm/boot/dts/ntc-gr8.dtsi b/arch/arm/boot/dts/ntc-gr8.dtsi
index d6a499bfd795..1c46cd38d999 100644
--- a/arch/arm/boot/dts/ntc-gr8.dtsi
+++ b/arch/arm/boot/dts/ntc-gr8.dtsi
@@ -766,37 +766,31 @@
 			i2c0_pins_a: i2c0 at 0 {
 				allwinner,pins = "PB0", "PB1";
 				allwinner,function = "i2c0";
-				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 
 			i2c1_pins_a: i2c1 at 0 {
 				allwinner,pins = "PB15", "PB16";
 				allwinner,function = "i2c1";
-				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 
 			i2c2_pins_a: i2c2 at 0 {
 				allwinner,pins = "PB17", "PB18";
 				allwinner,function = "i2c2";
-				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 
 			i2s0_data_pins_a: i2s0-data at 0 {
 				allwinner,pins = "PB6", "PB7", "PB8", "PB9";
 				allwinner,function = "i2s0";
-				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 
 			i2s0_mclk_pins_a: i2s0-mclk at 0 {
 				allwinner,pins = "PB6", "PB7", "PB8", "PB9";
 				allwinner,function = "i2s0";
-				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 
 			ir0_rx_pins_a: ir0 at 0 {
 				allwinner,pins = "PB4";
 				allwinner,function = "ir0";
-				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 
 			lcd_rgb666_pins: lcd-rgb666 at 0 {
@@ -805,7 +799,6 @@
 						 "PD18", "PD19", "PD20", "PD21", "PD22", "PD23",
 						 "PD24", "PD25", "PD26", "PD27";
 				allwinner,function = "lcd0";
-				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 
 			mmc0_pins_a: mmc0 at 0 {
@@ -813,7 +806,6 @@
 						 "PF4", "PF5";
 				allwinner,function = "mmc0";
 				allwinner,drive = <SUN4I_PINCTRL_30_MA>;
-				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 
 			nand_pins_a: nand-base0 at 0 {
@@ -822,25 +814,21 @@
 						"PC11", "PC12", "PC13", "PC14",
 						"PC15";
 				allwinner,function = "nand0";
-				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 
 			nand_cs0_pins_a: nand-cs at 0 {
 				allwinner,pins = "PC4";
 				allwinner,function = "nand0";
-				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 
 			nand_rb0_pins_a: nand-rb at 0 {
 				allwinner,pins = "PC6";
 				allwinner,function = "nand0";
-				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 
 			pwm0_pins_a: pwm0 at 0 {
 				allwinner,pins = "PB2";
 				allwinner,function = "pwm0";
-				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 
 			spdif_tx_pins_a: spdif at 0 {
@@ -852,13 +840,11 @@
 			uart1_pins_a: uart1 at 1 {
 				allwinner,pins = "PG3", "PG4";
 				allwinner,function = "uart1";
-				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 
 			uart1_cts_rts_pins_a: uart1-cts-rts at 0 {
 				allwinner,pins = "PG5", "PG6";
 				allwinner,function = "uart1";
-				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 		};
 
diff --git a/arch/arm/boot/dts/sun4i-a10-a1000.dts b/arch/arm/boot/dts/sun4i-a10-a1000.dts
index 035395a32212..4d8164afc671 100644
--- a/arch/arm/boot/dts/sun4i-a10-a1000.dts
+++ b/arch/arm/boot/dts/sun4i-a10-a1000.dts
@@ -188,13 +188,11 @@
 	emac_power_pin_a1000: emac_power_pin at 0 {
 		allwinner,pins = "PH15";
 		allwinner,function = "gpio_out";
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 
 	led_pins_a1000: led_pins at 0 {
 		allwinner,pins = "PH10", "PH20";
 		allwinner,function = "gpio_out";
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 };
 
diff --git a/arch/arm/boot/dts/sun4i-a10-cubieboard.dts b/arch/arm/boot/dts/sun4i-a10-cubieboard.dts
index f11dcd82f468..e7188d2fb303 100644
--- a/arch/arm/boot/dts/sun4i-a10-cubieboard.dts
+++ b/arch/arm/boot/dts/sun4i-a10-cubieboard.dts
@@ -168,7 +168,6 @@
 		allwinner,pins = "PH20", "PH21";
 		allwinner,function = "gpio_out";
 		allwinner,drive = <SUN4I_PINCTRL_20_MA>;
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 
 	usb0_id_detect_pin: usb0_id_detect_pin at 0 {
diff --git a/arch/arm/boot/dts/sun4i-a10-dserve-dsrv9703c.dts b/arch/arm/boot/dts/sun4i-a10-dserve-dsrv9703c.dts
index e01bdd1f1b2b..b4b829d6008d 100644
--- a/arch/arm/boot/dts/sun4i-a10-dserve-dsrv9703c.dts
+++ b/arch/arm/boot/dts/sun4i-a10-dserve-dsrv9703c.dts
@@ -180,25 +180,21 @@
 	bl_en_pin_dsrv9703c: bl_en_pin at 0 {
 		allwinner,pins = "PH7";
 		allwinner,function = "gpio_out";
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 
 	codec_pa_pin: codec_pa_pin at 0 {
 		allwinner,pins = "PH15";
 		allwinner,function = "gpio_out";
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 
 	motor_pins: motor_pins at 0 {
 		allwinner,pins = "PB3";
 		allwinner,function = "gpio_out";
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 
 	touchscreen_pins: touchscreen_pins at 0 {
 		allwinner,pins = "PB13";
 		allwinner,function = "gpio_out";
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 
 	usb0_id_detect_pin: usb0_id_detect_pin at 0 {
diff --git a/arch/arm/boot/dts/sun4i-a10-gemei-g9.dts b/arch/arm/boot/dts/sun4i-a10-gemei-g9.dts
index fbd02c7a5d43..57496a38b94a 100644
--- a/arch/arm/boot/dts/sun4i-a10-gemei-g9.dts
+++ b/arch/arm/boot/dts/sun4i-a10-gemei-g9.dts
@@ -158,7 +158,6 @@
 	codec_pa_pin: codec_pa_pin at 0 {
 		allwinner,pins = "PH15";
 		allwinner,function = "gpio_out";
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 };
 
diff --git a/arch/arm/boot/dts/sun4i-a10-hackberry.dts b/arch/arm/boot/dts/sun4i-a10-hackberry.dts
index 9b8134cb968d..de10ae48c6f6 100644
--- a/arch/arm/boot/dts/sun4i-a10-hackberry.dts
+++ b/arch/arm/boot/dts/sun4i-a10-hackberry.dts
@@ -131,13 +131,11 @@
 	hackberry_hogs: hogs at 0 {
 		allwinner,pins = "PH19";
 		allwinner,function = "gpio_out";
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 
 	usb2_vbus_pin_hackberry: usb2_vbus_pin at 0 {
 		allwinner,pins = "PH12";
 		allwinner,function = "gpio_out";
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 };
 
diff --git a/arch/arm/boot/dts/sun4i-a10-inet1.dts b/arch/arm/boot/dts/sun4i-a10-inet1.dts
index bb64e466c4e0..f78c17a9a298 100644
--- a/arch/arm/boot/dts/sun4i-a10-inet1.dts
+++ b/arch/arm/boot/dts/sun4i-a10-inet1.dts
@@ -182,13 +182,11 @@
 	bl_en_pin_inet: bl_en_pin at 0 {
 		allwinner,pins = "PH7";
 		allwinner,function = "gpio_out";
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 
 	touchscreen_wake_pin: touchscreen_wake_pin at 0 {
 		allwinner,pins = "PB13";
 		allwinner,function = "gpio_out";
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 
 	usb0_id_detect_pin: usb0_id_detect_pin at 0 {
diff --git a/arch/arm/boot/dts/sun4i-a10-jesurun-q5.dts b/arch/arm/boot/dts/sun4i-a10-jesurun-q5.dts
index 65273bc7998c..e6ffaefed42d 100644
--- a/arch/arm/boot/dts/sun4i-a10-jesurun-q5.dts
+++ b/arch/arm/boot/dts/sun4i-a10-jesurun-q5.dts
@@ -165,13 +165,11 @@
 	emac_power_pin_q5: emac_power_pin at 0 {
 		allwinner,pins = "PH19";
 		allwinner,function = "gpio_out";
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 
 	led_pins_q5: led_pins at 0 {
 		allwinner,pins = "PH20";
 		allwinner,function = "gpio_out";
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 };
 
diff --git a/arch/arm/boot/dts/sun4i-a10-marsboard.dts b/arch/arm/boot/dts/sun4i-a10-marsboard.dts
index c5916125bea8..001656eb9171 100644
--- a/arch/arm/boot/dts/sun4i-a10-marsboard.dts
+++ b/arch/arm/boot/dts/sun4i-a10-marsboard.dts
@@ -166,7 +166,6 @@
 	led_pins_marsboard: led_pins at 0 {
 		allwinner,pins = "PB5", "PB6", "PB7", "PB8";
 		allwinner,function = "gpio_out";
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 
 	usb0_id_detect_pin: usb0_id_detect_pin at 0 {
diff --git a/arch/arm/boot/dts/sun4i-a10-mk802.dts b/arch/arm/boot/dts/sun4i-a10-mk802.dts
index 204e2b68d09f..9ce39f75188e 100644
--- a/arch/arm/boot/dts/sun4i-a10-mk802.dts
+++ b/arch/arm/boot/dts/sun4i-a10-mk802.dts
@@ -93,19 +93,16 @@
 	usb0_id_detect_pin: usb0_id_detect_pin at 0 {
 		allwinner,pins = "PH4";
 		allwinner,function = "gpio_in";
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 
 	usb0_vbus_detect_pin: usb0_vbus_detect_pin at 0 {
 		allwinner,pins = "PH5";
 		allwinner,function = "gpio_in";
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 
 	usb2_vbus_pin_mk802: usb2_vbus_pin at 0 {
 		allwinner,pins = "PH12";
 		allwinner,function = "gpio_out";
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 };
 
diff --git a/arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts b/arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts
index e8e14a53b764..203d399f0f7b 100644
--- a/arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts
+++ b/arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts
@@ -170,14 +170,12 @@
 	ahci_pwr_pin_olinuxinolime: ahci_pwr_pin at 1 {
 		allwinner,pins = "PC3";
 		allwinner,function = "gpio_out";
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 
 	led_pins_olinuxinolime: led_pins at 0 {
 		allwinner,pins = "PH2";
 		allwinner,function = "gpio_out";
 		allwinner,drive = <SUN4I_PINCTRL_20_MA>;
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 
 	usb0_id_detect_pin: usb0_id_detect_pin at 0 {
diff --git a/arch/arm/boot/dts/sun4i-a10-pcduino.dts b/arch/arm/boot/dts/sun4i-a10-pcduino.dts
index 7e94334420af..94cdef53ac11 100644
--- a/arch/arm/boot/dts/sun4i-a10-pcduino.dts
+++ b/arch/arm/boot/dts/sun4i-a10-pcduino.dts
@@ -172,13 +172,11 @@
 	led_pins_pcduino: led_pins at 0 {
 		allwinner,pins = "PH15", "PH16";
 		allwinner,function = "gpio_out";
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 
 	key_pins_pcduino: key_pins at 0 {
 		allwinner,pins = "PH17", "PH18", "PH19";
 		allwinner,function = "gpio_in";
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 
 	usb0_id_detect_pin: usb0_id_detect_pin at 0 {
diff --git a/arch/arm/boot/dts/sun4i-a10-pcduino2.dts b/arch/arm/boot/dts/sun4i-a10-pcduino2.dts
index 05de4050a831..9656ec9b51ae 100644
--- a/arch/arm/boot/dts/sun4i-a10-pcduino2.dts
+++ b/arch/arm/boot/dts/sun4i-a10-pcduino2.dts
@@ -59,7 +59,6 @@
 	usb2_vbus_pin_pcduino2: usb2_vbus_pin at 0 {
 		allwinner,pins = "PD2";
 		allwinner,function = "gpio_out";
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 };
 
diff --git a/arch/arm/boot/dts/sun4i-a10-pov-protab2-ips9.dts b/arch/arm/boot/dts/sun4i-a10-pov-protab2-ips9.dts
index 459c7a2dbee7..9dedd808bde8 100644
--- a/arch/arm/boot/dts/sun4i-a10-pov-protab2-ips9.dts
+++ b/arch/arm/boot/dts/sun4i-a10-pov-protab2-ips9.dts
@@ -166,19 +166,16 @@
 	bl_en_pin_protab: bl_en_pin at 0 {
 		allwinner,pins = "PH7";
 		allwinner,function = "gpio_out";
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 
 	codec_pa_pin: codec_pa_pin at 0 {
 		allwinner,pins = "PH15";
 		allwinner,function = "gpio_out";
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 
 	touchscreen_pins: touchscreen_pins at 0 {
 		allwinner,pins = "PA5", "PB13";
 		allwinner,function = "gpio_out";
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 
 	usb0_id_detect_pin: usb0_id_detect_pin at 0 {
diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
index ae562272589c..36f3416c4c32 100644
--- a/arch/arm/boot/dts/sun4i-a10.dtsi
+++ b/arch/arm/boot/dts/sun4i-a10.dtsi
@@ -980,49 +980,41 @@
 						"PA11", "PA12", "PA13", "PA14",
 						"PA15", "PA16";
 				allwinner,function = "emac";
-				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 
 			i2c0_pins_a: i2c0 at 0 {
 				allwinner,pins = "PB0", "PB1";
 				allwinner,function = "i2c0";
-				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 
 			i2c1_pins_a: i2c1 at 0 {
 				allwinner,pins = "PB18", "PB19";
 				allwinner,function = "i2c1";
-				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 
 			i2c2_pins_a: i2c2 at 0 {
 				allwinner,pins = "PB20", "PB21";
 				allwinner,function = "i2c2";
-				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 
 			ir0_rx_pins_a: ir0 at 0 {
 				allwinner,pins = "PB4";
 				allwinner,function = "ir0";
-				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 
 			ir0_tx_pins_a: ir0 at 1 {
 				allwinner,pins = "PB3";
 				allwinner,function = "ir0";
-				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 
 			ir1_rx_pins_a: ir1 at 0 {
 				allwinner,pins = "PB23";
 				allwinner,function = "ir1";
-				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 
 			ir1_tx_pins_a: ir1 at 1 {
 				allwinner,pins = "PB22";
 				allwinner,function = "ir1";
-				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 
 			mmc0_pins_a: mmc0 at 0 {
@@ -1030,7 +1022,6 @@
 						 "PF3", "PF4", "PF5";
 				allwinner,function = "mmc0";
 				allwinner,drive = <SUN4I_PINCTRL_30_MA>;
-				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 
 			mmc0_cd_pin_reference_design: mmc0_cd_pin at 0 {
@@ -1042,25 +1033,21 @@
 			ps20_pins_a: ps20 at 0 {
 				allwinner,pins = "PI20", "PI21";
 				allwinner,function = "ps2";
-				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 
 			ps21_pins_a: ps21 at 0 {
 				allwinner,pins = "PH12", "PH13";
 				allwinner,function = "ps2";
-				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 
 			pwm0_pins_a: pwm0 at 0 {
 				allwinner,pins = "PB2";
 				allwinner,function = "pwm";
-				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 
 			pwm1_pins_a: pwm1 at 0 {
 				allwinner,pins = "PI3";
 				allwinner,function = "pwm";
-				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 
 			spdif_tx_pins_a: spdif at 0 {
@@ -1072,67 +1059,56 @@
 			spi0_pins_a: spi0 at 0 {
 				allwinner,pins = "PI11", "PI12", "PI13";
 				allwinner,function = "spi0";
-				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 
 			spi0_cs0_pins_a: spi0_cs0 at 0 {
 				allwinner,pins = "PI10";
 				allwinner,function = "spi0";
-				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 
 			spi1_pins_a: spi1 at 0 {
 				allwinner,pins = "PI17", "PI18", "PI19";
 				allwinner,function = "spi1";
-				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 
 			spi1_cs0_pins_a: spi1_cs0 at 0 {
 				allwinner,pins = "PI16";
 				allwinner,function = "spi1";
-				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 
 			spi2_pins_a: spi2 at 0 {
 				allwinner,pins = "PC20", "PC21", "PC22";
 				allwinner,function = "spi2";
-				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 
 			spi2_pins_b: spi2 at 1 {
 				allwinner,pins = "PB15", "PB16", "PB17";
 				allwinner,function = "spi2";
-				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 
 			spi2_cs0_pins_a: spi2_cs0 at 0 {
 				allwinner,pins = "PC19";
 				allwinner,function = "spi2";
-				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 
 			spi2_cs0_pins_b: spi2_cs0 at 1 {
 				allwinner,pins = "PB14";
 				allwinner,function = "spi2";
-				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 
 			uart0_pins_a: uart0 at 0 {
 				allwinner,pins = "PB22", "PB23";
 				allwinner,function = "uart0";
-				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 
 			uart0_pins_b: uart0 at 1 {
 				allwinner,pins = "PF2", "PF4";
 				allwinner,function = "uart0";
-				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 
 			uart1_pins_a: uart1 at 0 {
 				allwinner,pins = "PA10", "PA11";
 				allwinner,function = "uart1";
-				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 		};
 
diff --git a/arch/arm/boot/dts/sun5i-a10s-auxtek-t003.dts b/arch/arm/boot/dts/sun5i-a10s-auxtek-t003.dts
index 813e18c011da..8d1e414c0a3a 100644
--- a/arch/arm/boot/dts/sun5i-a10s-auxtek-t003.dts
+++ b/arch/arm/boot/dts/sun5i-a10s-auxtek-t003.dts
@@ -118,7 +118,6 @@
 		allwinner,pins = "PB2";
 		allwinner,function = "gpio_out";
 		allwinner,drive = <SUN4I_PINCTRL_20_MA>;
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 };
 
diff --git a/arch/arm/boot/dts/sun5i-a10s-auxtek-t004.dts b/arch/arm/boot/dts/sun5i-a10s-auxtek-t004.dts
index 3c79e3536521..e3438a685c71 100644
--- a/arch/arm/boot/dts/sun5i-a10s-auxtek-t004.dts
+++ b/arch/arm/boot/dts/sun5i-a10s-auxtek-t004.dts
@@ -144,14 +144,12 @@
 	mmc1_vcc_en_pin_t004: mmc1_vcc_en_pin at 0 {
 		allwinner,pins = "PB18";
 		allwinner,function = "gpio_out";
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 
 	led_pins_t004: led_pins at 0 {
 		allwinner,pins = "PB2";
 		allwinner,function = "gpio_out";
 		allwinner,drive = <SUN4I_PINCTRL_20_MA>;
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 };
 
diff --git a/arch/arm/boot/dts/sun5i-a10s-mk802.dts b/arch/arm/boot/dts/sun5i-a10s-mk802.dts
index 940139145fd5..405c1d519301 100644
--- a/arch/arm/boot/dts/sun5i-a10s-mk802.dts
+++ b/arch/arm/boot/dts/sun5i-a10s-mk802.dts
@@ -118,7 +118,6 @@
 	led_pins_mk802: led_pins at 0 {
 		allwinner,pins = "PB2";
 		allwinner,function = "gpio_out";
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 
 	mmc0_cd_pin_mk802: mmc0_cd_pin at 0 {
@@ -130,7 +129,6 @@
 	usb1_vbus_pin_mk802: usb1_vbus_pin at 0 {
 		allwinner,pins = "PB10";
 		allwinner,function = "gpio_out";
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 };
 
diff --git a/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts b/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts
index 26d74958bd57..125243305525 100644
--- a/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts
+++ b/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts
@@ -217,13 +217,11 @@
 		allwinner,pins = "PE3";
 		allwinner,function = "gpio_out";
 		allwinner,drive = <SUN4I_PINCTRL_20_MA>;
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 
 	usb1_vbus_pin_olinuxino_m: usb1_vbus_pin at 0 {
 		allwinner,pins = "PB10";
 		allwinner,function = "gpio_out";
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 
 	usb0_id_detect_pin: usb0_id_detect_pin at 0 {
diff --git a/arch/arm/boot/dts/sun5i-a10s-r7-tv-dongle.dts b/arch/arm/boot/dts/sun5i-a10s-r7-tv-dongle.dts
index 84a3bf817c3b..e2dceda4889b 100644
--- a/arch/arm/boot/dts/sun5i-a10s-r7-tv-dongle.dts
+++ b/arch/arm/boot/dts/sun5i-a10s-r7-tv-dongle.dts
@@ -110,13 +110,11 @@
 		allwinner,pins = "PB2";
 		allwinner,function = "gpio_out";
 		allwinner,drive = <SUN4I_PINCTRL_20_MA>;
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 
 	usb1_vbus_pin_r7: usb1_vbus_pin at 0 {
 		allwinner,pins = "PG13";
 		allwinner,function = "gpio_out";
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 };
 
diff --git a/arch/arm/boot/dts/sun5i-a10s-wobo-i5.dts b/arch/arm/boot/dts/sun5i-a10s-wobo-i5.dts
index 56a6982773a9..f40451bffb84 100644
--- a/arch/arm/boot/dts/sun5i-a10s-wobo-i5.dts
+++ b/arch/arm/boot/dts/sun5i-a10s-wobo-i5.dts
@@ -148,7 +148,6 @@
 	led_pins_wobo_i5: led_pins at 0 {
 		allwinner,pins = "PB2";
 		allwinner,function = "gpio_out";
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 
 	mmc0_cd_pin_wobo_i5: mmc0_cd_pin at 0 {
@@ -160,7 +159,6 @@
 	emac_power_pin_wobo: emac_power_pin at 0 {
 		allwinner,pins = "PA02";
 		allwinner,function = "gpio_out";
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 };
 
diff --git a/arch/arm/boot/dts/sun5i-a10s.dtsi b/arch/arm/boot/dts/sun5i-a10s.dtsi
index 9aa80630e00f..4e014cb11e81 100644
--- a/arch/arm/boot/dts/sun5i-a10s.dtsi
+++ b/arch/arm/boot/dts/sun5i-a10s.dtsi
@@ -202,13 +202,11 @@
 	uart0_pins_a: uart0 at 0 {
 		allwinner,pins = "PB19", "PB20";
 		allwinner,function = "uart0";
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 
 	uart2_pins_a: uart2 at 0 {
 		allwinner,pins = "PC18", "PC19";
 		allwinner,function = "uart2";
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 
 	emac_pins_a: emac0 at 0 {
@@ -218,7 +216,6 @@
 				"PA11", "PA12", "PA13", "PA14",
 				"PA15", "PA16";
 		allwinner,function = "emac";
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 
 	emac_pins_b: emac0 at 1 {
@@ -228,7 +225,6 @@
 				"PD21", "PD22", "PD23", "PD24",
 				"PD25", "PD26", "PD27";
 		allwinner,function = "emac";
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 
 	mmc1_pins_a: mmc1 at 0 {
@@ -236,19 +232,16 @@
 				 "PG6", "PG7", "PG8";
 		allwinner,function = "mmc1";
 		allwinner,drive = <SUN4I_PINCTRL_30_MA>;
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 
 	spi2_pins_a: spi2 at 0 {
 		allwinner,pins = "PB12", "PB13", "PB14";
 		allwinner,function = "spi2";
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 
 	spi2_cs0_pins_a: spi2_cs0 at 0 {
 		allwinner,pins = "PB11";
 		allwinner,function = "spi2";
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 };
 
diff --git a/arch/arm/boot/dts/sun5i-a13-hsg-h702.dts b/arch/arm/boot/dts/sun5i-a13-hsg-h702.dts
index aa4484ac50b2..f5d1a04f3a16 100644
--- a/arch/arm/boot/dts/sun5i-a13-hsg-h702.dts
+++ b/arch/arm/boot/dts/sun5i-a13-hsg-h702.dts
@@ -150,7 +150,6 @@
 	usb0_vbus_detect_pin: usb0_vbus_detect_pin at 0 {
 		allwinner,pins = "PG1";
 		allwinner,function = "gpio_in";
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 };
 
diff --git a/arch/arm/boot/dts/sun5i-a13-olinuxino-micro.dts b/arch/arm/boot/dts/sun5i-a13-olinuxino-micro.dts
index 8aec90ac28a4..df9315e5c850 100644
--- a/arch/arm/boot/dts/sun5i-a13-olinuxino-micro.dts
+++ b/arch/arm/boot/dts/sun5i-a13-olinuxino-micro.dts
@@ -124,7 +124,6 @@
 		allwinner,pins = "PG9";
 		allwinner,function = "gpio_out";
 		allwinner,drive = <SUN4I_PINCTRL_20_MA>;
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 
 	usb0_id_detect_pin: usb0_id_detect_pin at 0 {
@@ -142,13 +141,11 @@
 	usb0_vbus_pin_olinuxinom: usb0_vbus_pin at 0 {
 		allwinner,pins = "PG12";
 		allwinner,function = "gpio_out";
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 
 	usb1_vbus_pin_olinuxinom: usb1_vbus_pin at 0 {
 		allwinner,pins = "PG11";
 		allwinner,function = "gpio_out";
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 };
 
diff --git a/arch/arm/boot/dts/sun5i-a13-olinuxino.dts b/arch/arm/boot/dts/sun5i-a13-olinuxino.dts
index 86ae19ba70d4..0f035adfbc57 100644
--- a/arch/arm/boot/dts/sun5i-a13-olinuxino.dts
+++ b/arch/arm/boot/dts/sun5i-a13-olinuxino.dts
@@ -174,7 +174,6 @@
 		allwinner,pins = "PG9";
 		allwinner,function = "gpio_out";
 		allwinner,drive = <SUN4I_PINCTRL_20_MA>;
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 
 	usb0_id_detect_pin: usb0_id_detect_pin at 0 {
@@ -192,7 +191,6 @@
 	usb1_vbus_pin_olinuxino: usb1_vbus_pin at 0 {
 		allwinner,pins = "PG11";
 		allwinner,function = "gpio_out";
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 };
 
diff --git a/arch/arm/boot/dts/sun5i-a13-utoo-p66.dts b/arch/arm/boot/dts/sun5i-a13-utoo-p66.dts
index 663cfa414dc2..3b7f2097824d 100644
--- a/arch/arm/boot/dts/sun5i-a13-utoo-p66.dts
+++ b/arch/arm/boot/dts/sun5i-a13-utoo-p66.dts
@@ -124,7 +124,6 @@
 	ts_wake_pin_p66: ts_wake_pin at 0 {
 		allwinner,pins = "PB3";
 		allwinner,function = "gpio_out";
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 
 };
diff --git a/arch/arm/boot/dts/sun5i-a13.dtsi b/arch/arm/boot/dts/sun5i-a13.dtsi
index d79db1525448..1f4c5f773226 100644
--- a/arch/arm/boot/dts/sun5i-a13.dtsi
+++ b/arch/arm/boot/dts/sun5i-a13.dtsi
@@ -355,18 +355,15 @@
 				 "PD18", "PD19", "PD20", "PD21", "PD22", "PD23",
 				 "PD24", "PD25", "PD26", "PD27";
 		allwinner,function = "lcd0";
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 
 	uart1_pins_a: uart1 at 0 {
 		allwinner,pins = "PE10", "PE11";
 		allwinner,function = "uart1";
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 
 	uart1_pins_b: uart1 at 1 {
 		allwinner,pins = "PG3", "PG4";
 		allwinner,function = "uart1";
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 };
diff --git a/arch/arm/boot/dts/sun5i-r8-chip.dts b/arch/arm/boot/dts/sun5i-r8-chip.dts
index 398a17a5d2e6..8f7f01bf1f0c 100644
--- a/arch/arm/boot/dts/sun5i-r8-chip.dts
+++ b/arch/arm/boot/dts/sun5i-r8-chip.dts
@@ -152,13 +152,11 @@
 	chip_vbus_pin: chip_vbus_pin at 0 {
 		allwinner,pins = "PB10";
 		allwinner,function = "gpio_out";
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 
 	chip_id_det_pin: chip_id_det_pin at 0 {
 		allwinner,pins = "PG2";
 		allwinner,function = "gpio_in";
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 };
 
diff --git a/arch/arm/boot/dts/sun5i-reference-design-tablet.dtsi b/arch/arm/boot/dts/sun5i-reference-design-tablet.dtsi
index 600bd3c0e231..b29c4d1fad40 100644
--- a/arch/arm/boot/dts/sun5i-reference-design-tablet.dtsi
+++ b/arch/arm/boot/dts/sun5i-reference-design-tablet.dtsi
@@ -114,7 +114,6 @@
 	codec_pa_pin: codec_pa_pin at 0 {
 		allwinner,pins = "PG10";
 		allwinner,function = "gpio_out";
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 
 	mmc0_cd_pin: mmc0_cd_pin at 0 {
@@ -138,7 +137,6 @@
 	usb0_vbus_pin_a: usb0_vbus_pin at 0 {
 		allwinner,pins = "PG12";
 		allwinner,function = "gpio_out";
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 };
 
diff --git a/arch/arm/boot/dts/sun5i.dtsi b/arch/arm/boot/dts/sun5i.dtsi
index fe84703d3c14..76b696944514 100644
--- a/arch/arm/boot/dts/sun5i.dtsi
+++ b/arch/arm/boot/dts/sun5i.dtsi
@@ -556,19 +556,16 @@
 			i2c0_pins_a: i2c0 at 0 {
 				allwinner,pins = "PB0", "PB1";
 				allwinner,function = "i2c0";
-				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 
 			i2c1_pins_a: i2c1 at 0 {
 				allwinner,pins = "PB15", "PB16";
 				allwinner,function = "i2c1";
-				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 
 			i2c2_pins_a: i2c2 at 0 {
 				allwinner,pins = "PB17", "PB18";
 				allwinner,function = "i2c2";
-				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 
 			mmc0_pins_a: mmc0 at 0 {
@@ -576,7 +573,6 @@
 						 "PF4", "PF5";
 				allwinner,function = "mmc0";
 				allwinner,drive = <SUN4I_PINCTRL_30_MA>;
-				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 
 			mmc2_pins_a: mmc2 at 0 {
@@ -591,19 +587,16 @@
 			uart3_pins_a: uart3 at 0 {
 				allwinner,pins = "PG9", "PG10";
 				allwinner,function = "uart3";
-				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 
 			uart3_pins_cts_rts_a: uart3-cts-rts at 0 {
 				allwinner,pins = "PG11", "PG12";
 				allwinner,function = "uart3";
-				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 
 			pwm0_pins: pwm0 {
 				allwinner,pins = "PB2";
 				allwinner,function = "pwm";
-				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 		};
 
diff --git a/arch/arm/boot/dts/sun6i-a31-app4-evb1.dts b/arch/arm/boot/dts/sun6i-a31-app4-evb1.dts
index e723dedeb614..cbc99ce6ab1a 100644
--- a/arch/arm/boot/dts/sun6i-a31-app4-evb1.dts
+++ b/arch/arm/boot/dts/sun6i-a31-app4-evb1.dts
@@ -70,7 +70,6 @@
 	usb1_vbus_pin_a: usb1_vbus_pin at 0 {
 		allwinner,pins = "PH27";
 		allwinner,function = "gpio_out";
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 };
 
diff --git a/arch/arm/boot/dts/sun6i-a31-colombus.dts b/arch/arm/boot/dts/sun6i-a31-colombus.dts
index 4057e91c7cb5..24909c8c1186 100644
--- a/arch/arm/boot/dts/sun6i-a31-colombus.dts
+++ b/arch/arm/boot/dts/sun6i-a31-colombus.dts
@@ -137,7 +137,6 @@
 	usb2_vbus_pin_colombus: usb2_vbus_pin at 0 {
 		allwinner,pins = "PH24";
 		allwinner,function = "gpio_out";
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 
 	i2c_lcd_pins: i2c_lcd_pin at 0 {
diff --git a/arch/arm/boot/dts/sun6i-a31-hummingbird.dts b/arch/arm/boot/dts/sun6i-a31-hummingbird.dts
index a82c4674a3fc..7ec5f5fcdaac 100644
--- a/arch/arm/boot/dts/sun6i-a31-hummingbird.dts
+++ b/arch/arm/boot/dts/sun6i-a31-hummingbird.dts
@@ -155,7 +155,6 @@
 	gmac_phy_reset_pin_hummingbird: gmac_phy_reset_pin at 0 {
 		allwinner,pins = "PA21";
 		allwinner,function = "gpio_out";
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 
 	mmc0_cd_pin_hummingbird: mmc0_cd_pin at 0 {
@@ -167,7 +166,6 @@
 	wifi_reset_pin_hummingbird: wifi_reset_pin at 0 {
 		allwinner,pins = "PG10";
 		allwinner,function = "gpio_out";
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 };
 
diff --git a/arch/arm/boot/dts/sun6i-a31-i7.dts b/arch/arm/boot/dts/sun6i-a31-i7.dts
index a2d6a92dac29..61e3ef4528ec 100644
--- a/arch/arm/boot/dts/sun6i-a31-i7.dts
+++ b/arch/arm/boot/dts/sun6i-a31-i7.dts
@@ -111,7 +111,6 @@
 	led_pins_i7: led_pins at 0 {
 		allwinner,pins = "PH13";
 		allwinner,function = "gpio_out";
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 
 	mmc0_cd_pin_i7: mmc0_cd_pin at 0 {
@@ -123,7 +122,6 @@
 	usb1_vbus_pin_i7: usb1_vbus_pin at 0 {
 		allwinner,pins = "PC27";
 		allwinner,function = "gpio_out";
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 };
 
diff --git a/arch/arm/boot/dts/sun6i-a31-m9.dts b/arch/arm/boot/dts/sun6i-a31-m9.dts
index 0ae5ab2f06fa..96ad1fe9bbc8 100644
--- a/arch/arm/boot/dts/sun6i-a31-m9.dts
+++ b/arch/arm/boot/dts/sun6i-a31-m9.dts
@@ -130,7 +130,6 @@
 	led_pins_m9: led_pins at 0 {
 		allwinner,pins = "PH13";
 		allwinner,function = "gpio_out";
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 
 	mmc0_cd_pin_m9: mmc0_cd_pin at 0 {
@@ -142,7 +141,6 @@
 	usb1_vbus_pin_m9: usb1_vbus_pin at 0 {
 		allwinner,pins = "PC27";
 		allwinner,function = "gpio_out";
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 };
 
diff --git a/arch/arm/boot/dts/sun6i-a31-mele-a1000g-quad.dts b/arch/arm/boot/dts/sun6i-a31-mele-a1000g-quad.dts
index a551673aca68..a29ea186b964 100644
--- a/arch/arm/boot/dts/sun6i-a31-mele-a1000g-quad.dts
+++ b/arch/arm/boot/dts/sun6i-a31-mele-a1000g-quad.dts
@@ -130,7 +130,6 @@
 	led_pins_m9: led_pins at 0 {
 		allwinner,pins = "PH13";
 		allwinner,function = "gpio_out";
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 
 	mmc0_cd_pin_m9: mmc0_cd_pin at 0 {
@@ -142,7 +141,6 @@
 	usb1_vbus_pin_m9: usb1_vbus_pin at 0 {
 		allwinner,pins = "PC27";
 		allwinner,function = "gpio_out";
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 };
 
diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
index 19ccf7a89759..1a00c67cc1b6 100644
--- a/arch/arm/boot/dts/sun6i-a31.dtsi
+++ b/arch/arm/boot/dts/sun6i-a31.dtsi
@@ -437,25 +437,21 @@
 			uart0_pins_a: uart0 at 0 {
 				allwinner,pins = "PH20", "PH21";
 				allwinner,function = "uart0";
-				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 
 			i2c0_pins_a: i2c0 at 0 {
 				allwinner,pins = "PH14", "PH15";
 				allwinner,function = "i2c0";
-				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 
 			i2c1_pins_a: i2c1 at 0 {
 				allwinner,pins = "PH16", "PH17";
 				allwinner,function = "i2c1";
-				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 
 			i2c2_pins_a: i2c2 at 0 {
 				allwinner,pins = "PH18", "PH19";
 				allwinner,function = "i2c2";
-				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 
 			mmc0_pins_a: mmc0 at 0 {
@@ -463,7 +459,6 @@
 						 "PF3", "PF4", "PF5";
 				allwinner,function = "mmc0";
 				allwinner,drive = <SUN4I_PINCTRL_30_MA>;
-				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 
 			mmc1_pins_a: mmc1 at 0 {
@@ -471,7 +466,6 @@
 						 "PG4", "PG5";
 				allwinner,function = "mmc1";
 				allwinner,drive = <SUN4I_PINCTRL_30_MA>;
-				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 
 			mmc2_pins_a: mmc2 at 0 {
@@ -489,7 +483,6 @@
 						 "PC24";
 				allwinner,function = "mmc2";
 				allwinner,drive = <SUN4I_PINCTRL_30_MA>;
-				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 
 			mmc3_8bit_emmc_pins: mmc3 at 1 {
@@ -499,7 +492,6 @@
 						 "PC24";
 				allwinner,function = "mmc3";
 				allwinner,drive = <SUN4I_PINCTRL_40_MA>;
-				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 
 			gmac_pins_mii_a: gmac_mii at 0 {
@@ -509,7 +501,6 @@
 						"PA20", "PA21", "PA22", "PA23",
 						"PA24", "PA26", "PA27";
 				allwinner,function = "gmac";
-				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 
 			gmac_pins_gmii_a: gmac_gmii at 0 {
@@ -526,7 +517,6 @@
 				 * might need a higher signal drive strength
 				 */
 				allwinner,drive = <SUN4I_PINCTRL_30_MA>;
-				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 
 			gmac_pins_rgmii_a: gmac_rgmii at 0 {
@@ -540,7 +530,6 @@
 				 * and need a higher signal drive strength
 				 */
 				allwinner,drive = <SUN4I_PINCTRL_40_MA>;
-				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 		};
 
@@ -892,13 +881,11 @@
 			ir_pins_a: ir at 0 {
 				allwinner,pins = "PL4";
 				allwinner,function = "s_ir";
-				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 
 			p2wi_pins: p2wi {
 				allwinner,pins = "PL0", "PL1";
 				allwinner,function = "s_p2wi";
-				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 		};
 
diff --git a/arch/arm/boot/dts/sun6i-a31s-primo81.dts b/arch/arm/boot/dts/sun6i-a31s-primo81.dts
index 4332cde8d6ca..f511aa0e250d 100644
--- a/arch/arm/boot/dts/sun6i-a31s-primo81.dts
+++ b/arch/arm/boot/dts/sun6i-a31s-primo81.dts
@@ -136,7 +136,6 @@
 	gt911_int_primo81: gt911_int_pin at 0 {
 		allwinner,pins = "PA3";
 		allwinner,function = "gpio_in";
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 
 	mma8452_int_primo81: mma8452_int_pin at 0 {
diff --git a/arch/arm/boot/dts/sun6i-a31s-sina31s.dts b/arch/arm/boot/dts/sun6i-a31s-sina31s.dts
index d0304f51a5c6..2beb867d095a 100644
--- a/arch/arm/boot/dts/sun6i-a31s-sina31s.dts
+++ b/arch/arm/boot/dts/sun6i-a31s-sina31s.dts
@@ -130,7 +130,6 @@
 	led_pin_sina31s: led_pin at 0 {
 		allwinner,pins = "PH13";
 		allwinner,function = "gpio_out";
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 
 	mmc0_cd_pin_sina31s: mmc0_cd_pin at 0 {
diff --git a/arch/arm/boot/dts/sun6i-a31s-sinovoip-bpi-m2.dts b/arch/arm/boot/dts/sun6i-a31s-sinovoip-bpi-m2.dts
index 83e47a1c93bd..3731cf22abc1 100644
--- a/arch/arm/boot/dts/sun6i-a31s-sinovoip-bpi-m2.dts
+++ b/arch/arm/boot/dts/sun6i-a31s-sinovoip-bpi-m2.dts
@@ -155,13 +155,11 @@
 	gmac_phy_reset_pin_bpi_m2: gmac_phy_reset_pin at 0 {
 		allwinner,pins = "PA21";
 		allwinner,function = "gpio_out";
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 
 	led_pins_bpi_m2: led_pins at 0 {
 		allwinner,pins = "PG5", "PG10", "PG11";
 		allwinner,function = "gpio_out";
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 
 	mmc0_cd_pin_bpi_m2: mmc0_cd_pin at 0 {
@@ -175,7 +173,6 @@
 	mmc2_pwrseq_pin_bpi_m2: mmc2_pwrseq_pin at 0 {
 		allwinner,pins = "PL8";
 		allwinner,function = "gpio_out";
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 };
 
diff --git a/arch/arm/boot/dts/sun7i-a20-bananapi-m1-plus.dts b/arch/arm/boot/dts/sun7i-a20-bananapi-m1-plus.dts
index e10630e59c05..2018f074ff05 100644
--- a/arch/arm/boot/dts/sun7i-a20-bananapi-m1-plus.dts
+++ b/arch/arm/boot/dts/sun7i-a20-bananapi-m1-plus.dts
@@ -196,13 +196,11 @@
 	gmac_power_pin_bpi_m1p: gmac_power_pin at 0 {
 		allwinner,pins = "PH23";
 		allwinner,function = "gpio_out";
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 
 	led_pins_bpi_m1p: led_pins at 0 {
 		allwinner,pins = "PH24", "PH25";
 		allwinner,function = "gpio_out";
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 
 	mmc0_cd_pin_bpi_m1p: mmc0_cd_pin at 0 {
@@ -214,7 +212,6 @@
 	mmc3_pwrseq_pin_bpi_m1p: mmc3_pwrseq_pin at 0 {
 		allwinner,pins = "PH22";
 		allwinner,function = "gpio_out";
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 };
 
diff --git a/arch/arm/boot/dts/sun7i-a20-bananapi.dts b/arch/arm/boot/dts/sun7i-a20-bananapi.dts
index 158ab889dce7..7cd6a74d104c 100644
--- a/arch/arm/boot/dts/sun7i-a20-bananapi.dts
+++ b/arch/arm/boot/dts/sun7i-a20-bananapi.dts
@@ -193,13 +193,11 @@
 	gmac_power_pin_bananapi: gmac_power_pin at 0 {
 		allwinner,pins = "PH23";
 		allwinner,function = "gpio_out";
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 
 	led_pins_bananapi: led_pins at 0 {
 		allwinner,pins = "PH24";
 		allwinner,function = "gpio_out";
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 };
 
diff --git a/arch/arm/boot/dts/sun7i-a20-bananapro.dts b/arch/arm/boot/dts/sun7i-a20-bananapro.dts
index 4aaf137376de..366636451e7e 100644
--- a/arch/arm/boot/dts/sun7i-a20-bananapro.dts
+++ b/arch/arm/boot/dts/sun7i-a20-bananapro.dts
@@ -184,13 +184,11 @@
 	gmac_power_pin_bananapro: gmac_power_pin at 0 {
 		allwinner,pins = "PH23";
 		allwinner,function = "gpio_out";
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 
 	led_pins_bananapro: led_pins at 0 {
 		allwinner,pins = "PH24", "PG2";
 		allwinner,function = "gpio_out";
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 
 	mmc0_cd_pin_bananapro: mmc0_cd_pin at 0 {
@@ -202,19 +200,16 @@
 	usb1_vbus_pin_bananapro: usb1_vbus_pin at 0 {
 		allwinner,pins = "PH0";
 		allwinner,function = "gpio_out";
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 
 	usb2_vbus_pin_bananapro: usb2_vbus_pin at 0 {
 		allwinner,pins = "PH1";
 		allwinner,function = "gpio_out";
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 
 	vmmc3_pin_bananapro: vmmc3_pin at 0 {
 		allwinner,pins = "PH22";
 		allwinner,function = "gpio_out";
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 };
 
diff --git a/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts b/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts
index 42779aeb7297..e635dd6ac47d 100644
--- a/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts
+++ b/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts
@@ -162,7 +162,6 @@
 	led_pins_cubieboard2: led_pins at 0 {
 		allwinner,pins = "PH20", "PH21";
 		allwinner,function = "gpio_out";
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 
 	usb0_id_detect_pin: usb0_id_detect_pin at 0 {
diff --git a/arch/arm/boot/dts/sun7i-a20-cubietruck.dts b/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
index a0b7ffb6196d..be8fa4879453 100644
--- a/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
+++ b/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
@@ -226,37 +226,31 @@
 	ahci_pwr_pin_cubietruck: ahci_pwr_pin at 1 {
 		allwinner,pins = "PH12";
 		allwinner,function = "gpio_out";
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 
 	led_pins_cubietruck: led_pins at 0 {
 		allwinner,pins = "PH7", "PH11", "PH20", "PH21";
 		allwinner,function = "gpio_out";
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 
 	mmc3_pwrseq_pin_cubietruck: mmc3_pwrseq_pin at 0 {
 		allwinner,pins = "PH9";
 		allwinner,function = "gpio_out";
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 
 	usb0_vbus_pin_a: usb0_vbus_pin at 0 {
 		allwinner,pins = "PH17";
 		allwinner,function = "gpio_out";
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 
 	usb0_id_detect_pin: usb0_id_detect_pin at 0 {
 		allwinner,pins = "PH19";
 		allwinner,function = "gpio_in";
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 
 	usb0_vbus_detect_pin: usb0_vbus_detect_pin at 0 {
 		allwinner,pins = "PH22";
 		allwinner,function = "gpio_in";
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 };
 
diff --git a/arch/arm/boot/dts/sun7i-a20-hummingbird.dts b/arch/arm/boot/dts/sun7i-a20-hummingbird.dts
index 714a463e24ed..6719c701a45f 100644
--- a/arch/arm/boot/dts/sun7i-a20-hummingbird.dts
+++ b/arch/arm/boot/dts/sun7i-a20-hummingbird.dts
@@ -190,25 +190,21 @@
 	ahci_pwr_pin_a20_hummingbird: ahci_pwr_pin at 0 {
 		allwinner,pins = "PH15";
 		allwinner,function = "gpio_out";
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 
 	usb1_vbus_pin_a20_hummingbird: usb1_vbus_pin at 0 {
 		allwinner,pins = "PH2";
 		allwinner,function = "gpio_out";
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 
 	mmc3_vdd_pin_a20_hummingbird: mmc3_vdd_pin at 0 {
 		allwinner,pins = "PH9";
 		allwinner,function = "gpio_out";
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 
 	gmac_vdd_pin_a20_hummingbird: gmac_vdd_pin at 0 {
 		allwinner,pins = "PH16";
 		allwinner,function = "gpio_out";
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 };
 
diff --git a/arch/arm/boot/dts/sun7i-a20-i12-tvbox.dts b/arch/arm/boot/dts/sun7i-a20-i12-tvbox.dts
index 4d1e102ea4b9..d64c11134dd7 100644
--- a/arch/arm/boot/dts/sun7i-a20-i12-tvbox.dts
+++ b/arch/arm/boot/dts/sun7i-a20-i12-tvbox.dts
@@ -200,25 +200,21 @@
 	vmmc3_pin_i12_tvbox: vmmc3_pin at 0 {
 		allwinner,pins = "PH2";
 		allwinner,function = "gpio_out";
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 
 	vmmc3_io_pin_i12_tvbox: vmmc3_io_pin at 0 {
 		allwinner,pins = "PH12";
 		allwinner,function = "gpio_out";
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 
 	gmac_power_pin_i12_tvbox: gmac_power_pin at 0 {
 		allwinner,pins = "PH21";
 		allwinner,function = "gpio_out";
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 
 	led_pins_i12_tvbox: led_pins at 0 {
 		allwinner,pins = "PH9", "PH20";
 		allwinner,function = "gpio_out";
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 };
 
diff --git a/arch/arm/boot/dts/sun7i-a20-itead-ibox.dts b/arch/arm/boot/dts/sun7i-a20-itead-ibox.dts
index 10d48cbf81ff..44f09642c893 100644
--- a/arch/arm/boot/dts/sun7i-a20-itead-ibox.dts
+++ b/arch/arm/boot/dts/sun7i-a20-itead-ibox.dts
@@ -134,7 +134,6 @@
 		allwinner,pins = "PH20","PH21";
 		allwinner,function = "gpio_out";
 		allwinner,drive = <SUN4I_PINCTRL_20_MA>;
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 };
 
diff --git a/arch/arm/boot/dts/sun7i-a20-lamobo-r1.dts b/arch/arm/boot/dts/sun7i-a20-lamobo-r1.dts
index 57c05e69d012..79cee00a85de 100644
--- a/arch/arm/boot/dts/sun7i-a20-lamobo-r1.dts
+++ b/arch/arm/boot/dts/sun7i-a20-lamobo-r1.dts
@@ -236,13 +236,11 @@
 	gmac_power_pin_lamobo_r1: gmac_power_pin at 0 {
 		allwinner,pins = "PH23";
 		allwinner,function = "gpio_out";
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 
 	led_pins_lamobo_r1: led_pins at 0 {
 		allwinner,pins = "PH24";
 		allwinner,function = "gpio_out";
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 };
 
diff --git a/arch/arm/boot/dts/sun7i-a20-m3.dts b/arch/arm/boot/dts/sun7i-a20-m3.dts
index cfaa5b45b159..97ce27da445f 100644
--- a/arch/arm/boot/dts/sun7i-a20-m3.dts
+++ b/arch/arm/boot/dts/sun7i-a20-m3.dts
@@ -147,7 +147,6 @@
 	led_pins_m3: led_pins at 0 {
 		allwinner,pins = "PH20";
 		allwinner,function = "gpio_out";
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 };
 
diff --git a/arch/arm/boot/dts/sun7i-a20-mk808c.dts b/arch/arm/boot/dts/sun7i-a20-mk808c.dts
index edd397d796be..c5890617382c 100644
--- a/arch/arm/boot/dts/sun7i-a20-mk808c.dts
+++ b/arch/arm/boot/dts/sun7i-a20-mk808c.dts
@@ -134,13 +134,11 @@
 	usb0_id_detect_pin: usb0_id_detect_pin at 0 {
 		allwinner,pins = "PH4";
 		allwinner,function = "gpio_in";
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 
 	usb0_vbus_detect_pin: usb0_vbus_detect_pin at 0 {
 		allwinner,pins = "PH5";
 		allwinner,function = "gpio_in";
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 };
 
diff --git a/arch/arm/boot/dts/sun7i-a20-olimex-som-evb.dts b/arch/arm/boot/dts/sun7i-a20-olimex-som-evb.dts
index edf735c10b63..de2863651b44 100644
--- a/arch/arm/boot/dts/sun7i-a20-olimex-som-evb.dts
+++ b/arch/arm/boot/dts/sun7i-a20-olimex-som-evb.dts
@@ -206,14 +206,12 @@
 	ahci_pwr_pin_olimex_som_evb: ahci_pwr_pin at 1 {
 		allwinner,pins = "PC3";
 		allwinner,function = "gpio_out";
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 
 	led_pins_olimex_som_evb: led_pins at 0 {
 		allwinner,pins = "PH2";
 		allwinner,function = "gpio_out";
 		allwinner,drive = <SUN4I_PINCTRL_20_MA>;
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 
 	mmc3_cd_pin_olimex_som_evb: mmc3_cd_pin at 0 {
@@ -225,13 +223,11 @@
 	usb0_id_detect_pin: usb0_id_detect_pin at 0 {
 		allwinner,pins = "PH4";
 		allwinner,function = "gpio_in";
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 
 	usb0_vbus_detect_pin: usb0_vbus_detect_pin at 0 {
 		allwinner,pins = "PH5";
 		allwinner,function = "gpio_in";
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 };
 
diff --git a/arch/arm/boot/dts/sun7i-a20-olinuxino-lime.dts b/arch/arm/boot/dts/sun7i-a20-olinuxino-lime.dts
index 632ad580e09f..21946497789e 100644
--- a/arch/arm/boot/dts/sun7i-a20-olinuxino-lime.dts
+++ b/arch/arm/boot/dts/sun7i-a20-olinuxino-lime.dts
@@ -155,14 +155,12 @@
 	ahci_pwr_pin_olinuxinolime: ahci_pwr_pin at 1 {
 		allwinner,pins = "PC3";
 		allwinner,function = "gpio_out";
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 
 	led_pins_olinuxinolime: led_pins at 0 {
 		allwinner,pins = "PH2";
 		allwinner,function = "gpio_out";
 		allwinner,drive = <SUN4I_PINCTRL_20_MA>;
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 
 	usb0_id_detect_pin: usb0_id_detect_pin at 0 {
diff --git a/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2-emmc.dts b/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2-emmc.dts
index a64c2b3a1125..6858d6aafea3 100644
--- a/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2-emmc.dts
+++ b/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2-emmc.dts
@@ -59,7 +59,6 @@
 	mmc2_pins_nrst: mmc2 at 0 {
 		allwinner,pins = "PC16";
 		allwinner,function = "gpio_out";
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 };
 
diff --git a/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts b/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
index b47b67765aec..3dcd745126a9 100644
--- a/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
+++ b/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
@@ -204,14 +204,12 @@
 	ahci_pwr_pin_olinuxinolime: ahci_pwr_pin at 1 {
 		allwinner,pins = "PC3";
 		allwinner,function = "gpio_out";
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 
 	led_pins_olinuxinolime: led_pins at 0 {
 		allwinner,pins = "PH2";
 		allwinner,function = "gpio_out";
 		allwinner,drive = <SUN4I_PINCTRL_20_MA>;
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 
 	usb0_id_detect_pin: usb0_id_detect_pin at 0 {
@@ -229,7 +227,6 @@
 	usb0_vbus_pin_lime2: usb0_vbus_pin at 0 {
 		allwinner,pins = "PC17";
 		allwinner,function = "gpio_out";
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 };
 
diff --git a/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts b/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
index 2dddbf148d8e..3773926df96e 100644
--- a/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
+++ b/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
@@ -236,7 +236,6 @@
 		allwinner,pins = "PH2";
 		allwinner,function = "gpio_out";
 		allwinner,drive = <SUN4I_PINCTRL_20_MA>;
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 
 	usb0_id_detect_pin: usb0_id_detect_pin at 0 {
diff --git a/arch/arm/boot/dts/sun7i-a20-orangepi-mini.dts b/arch/arm/boot/dts/sun7i-a20-orangepi-mini.dts
index 69ad2345613f..8e05256f7c1b 100644
--- a/arch/arm/boot/dts/sun7i-a20-orangepi-mini.dts
+++ b/arch/arm/boot/dts/sun7i-a20-orangepi-mini.dts
@@ -186,25 +186,21 @@
 	usb2_vbus_pin_bananapro: usb2_vbus_pin at 0 {
 		allwinner,pins = "PH22";
 		allwinner,function = "gpio_out";
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 
 	gmac_power_pin_orangepi: gmac_power_pin at 0 {
 		allwinner,pins = "PH23";
 		allwinner,function = "gpio_out";
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 
 	led_pins_orangepi: led_pins at 0 {
 		allwinner,pins = "PH24", "PH25";
 		allwinner,function = "gpio_out";
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 
 	usb1_vbus_pin_bananapro: usb1_vbus_pin at 0 {
 		allwinner,pins = "PH26";
 		allwinner,function = "gpio_out";
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 };
 
diff --git a/arch/arm/boot/dts/sun7i-a20-orangepi.dts b/arch/arm/boot/dts/sun7i-a20-orangepi.dts
index d6608ed6cdf3..d168b8f08e30 100644
--- a/arch/arm/boot/dts/sun7i-a20-orangepi.dts
+++ b/arch/arm/boot/dts/sun7i-a20-orangepi.dts
@@ -161,25 +161,21 @@
 	usb2_vbus_pin_bananapro: usb2_vbus_pin at 0 {
 		allwinner,pins = "PH22";
 		allwinner,function = "gpio_out";
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 
 	gmac_power_pin_orangepi: gmac_power_pin at 0 {
 		allwinner,pins = "PH23";
 		allwinner,function = "gpio_out";
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 
 	led_pins_orangepi: led_pins at 0 {
 		allwinner,pins = "PH24";
 		allwinner,function = "gpio_out";
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 
 	usb1_vbus_pin_bananapro: usb1_vbus_pin at 0 {
 		allwinner,pins = "PH26";
 		allwinner,function = "gpio_out";
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 };
 
diff --git a/arch/arm/boot/dts/sun7i-a20-pcduino3-nano.dts b/arch/arm/boot/dts/sun7i-a20-pcduino3-nano.dts
index 4a292a12616d..cdcbee74274e 100644
--- a/arch/arm/boot/dts/sun7i-a20-pcduino3-nano.dts
+++ b/arch/arm/boot/dts/sun7i-a20-pcduino3-nano.dts
@@ -154,13 +154,11 @@
 	ahci_pwr_pin_pcduino3_nano: ahci_pwr_pin at 0 {
 		allwinner,pins = "PH2";
 		allwinner,function = "gpio_out";
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 
 	led_pins_pcduino3_nano: led_pins at 0 {
 		allwinner,pins = "PH16", "PH15";
 		allwinner,function = "gpio_out";
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 
 	usb0_id_detect_pin: usb0_id_detect_pin at 0 {
@@ -172,7 +170,6 @@
 	usb1_vbus_pin_pcduino3_nano: usb1_vbus_pin at 0 {
 		allwinner,pins = "PD2";
 		allwinner,function = "gpio_out";
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 };
 
diff --git a/arch/arm/boot/dts/sun7i-a20-pcduino3.dts b/arch/arm/boot/dts/sun7i-a20-pcduino3.dts
index a416b3a47cee..fd2b4b8af9ea 100644
--- a/arch/arm/boot/dts/sun7i-a20-pcduino3.dts
+++ b/arch/arm/boot/dts/sun7i-a20-pcduino3.dts
@@ -185,13 +185,11 @@
 	led_pins_pcduino3: led_pins at 0 {
 		allwinner,pins = "PH15", "PH16";
 		allwinner,function = "gpio_out";
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 
 	key_pins_pcduino3: key_pins at 0 {
 		allwinner,pins = "PH17", "PH18", "PH19";
 		allwinner,function = "gpio_in";
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 
 	usb0_id_detect_pin: usb0_id_detect_pin at 0 {
diff --git a/arch/arm/boot/dts/sun7i-a20-wexler-tab7200.dts b/arch/arm/boot/dts/sun7i-a20-wexler-tab7200.dts
index a10c4ccd741d..688f75ceab58 100644
--- a/arch/arm/boot/dts/sun7i-a20-wexler-tab7200.dts
+++ b/arch/arm/boot/dts/sun7i-a20-wexler-tab7200.dts
@@ -175,19 +175,16 @@
 	bl_enable_pin: bl_enable_pin at 0 {
 		allwinner,pins = "PH7";
 		allwinner,function = "gpio_out";
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 
 	codec_pa_pin: codec_pa_pin at 0 {
 		allwinner,pins = "PH15";
 		allwinner,function = "gpio_out";
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 
 	ts_reset_pin: ts_reset_pin at 0 {
 		allwinner,pins = "PB13";
 		allwinner,function = "gpio_out";
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 
 	usb0_id_detect_pin: usb0_id_detect_pin at 0 {
diff --git a/arch/arm/boot/dts/sun7i-a20-wits-pro-a20-dkt.dts b/arch/arm/boot/dts/sun7i-a20-wits-pro-a20-dkt.dts
index 87901259582b..b12493350ee3 100644
--- a/arch/arm/boot/dts/sun7i-a20-wits-pro-a20-dkt.dts
+++ b/arch/arm/boot/dts/sun7i-a20-wits-pro-a20-dkt.dts
@@ -162,7 +162,6 @@
 	vmmc3_pin_ap6xxx_wl_regon: vmmc3_pin at 0 {
 		allwinner,pins = "PH9";
 		allwinner,function = "gpio_out";
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 
 	usb0_id_detect_pin: usb0_id_detect_pin at 0 {
diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index f672df81106c..5585b25c2acd 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -1094,13 +1094,11 @@
 			clk_out_a_pins_a: clk_out_a at 0 {
 				allwinner,pins = "PI12";
 				allwinner,function = "clk_out_a";
-				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 
 			clk_out_b_pins_a: clk_out_b at 0 {
 				allwinner,pins = "PI13";
 				allwinner,function = "clk_out_b";
-				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 
 			emac_pins_a: emac0 at 0 {
@@ -1110,7 +1108,6 @@
 						"PA11", "PA12", "PA13", "PA14",
 						"PA15", "PA16";
 				allwinner,function = "emac";
-				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 
 			gmac_pins_mii_a: gmac_mii at 0 {
@@ -1120,7 +1117,6 @@
 						"PA11", "PA12", "PA13", "PA14",
 						"PA15", "PA16";
 				allwinner,function = "gmac";
-				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 
 			gmac_pins_rgmii_a: gmac_rgmii at 0 {
@@ -1135,55 +1131,46 @@
 				 * and need a higher signal drive strength
 				 */
 				allwinner,drive = <SUN4I_PINCTRL_40_MA>;
-				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 
 			i2c0_pins_a: i2c0 at 0 {
 				allwinner,pins = "PB0", "PB1";
 				allwinner,function = "i2c0";
-				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 
 			i2c1_pins_a: i2c1 at 0 {
 				allwinner,pins = "PB18", "PB19";
 				allwinner,function = "i2c1";
-				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 
 			i2c2_pins_a: i2c2 at 0 {
 				allwinner,pins = "PB20", "PB21";
 				allwinner,function = "i2c2";
-				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 
 			i2c3_pins_a: i2c3 at 0 {
 				allwinner,pins = "PI0", "PI1";
 				allwinner,function = "i2c3";
-				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 
 			ir0_rx_pins_a: ir0 at 0 {
 				    allwinner,pins = "PB4";
 				    allwinner,function = "ir0";
-				    allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 
 			ir0_tx_pins_a: ir0 at 1 {
 				    allwinner,pins = "PB3";
 				    allwinner,function = "ir0";
-				    allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 
 			ir1_rx_pins_a: ir1 at 0 {
 				    allwinner,pins = "PB23";
 				    allwinner,function = "ir1";
-				    allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 
 			ir1_tx_pins_a: ir1 at 1 {
 				    allwinner,pins = "PB22";
 				    allwinner,function = "ir1";
-				    allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 
 			mmc0_pins_a: mmc0 at 0 {
@@ -1191,7 +1178,6 @@
 						 "PF3", "PF4", "PF5";
 				allwinner,function = "mmc0";
 				allwinner,drive = <SUN4I_PINCTRL_30_MA>;
-				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 
 			mmc0_cd_pin_reference_design: mmc0_cd_pin at 0 {
@@ -1213,31 +1199,26 @@
 						 "PI7", "PI8", "PI9";
 				allwinner,function = "mmc3";
 				allwinner,drive = <SUN4I_PINCTRL_30_MA>;
-				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 
 			ps20_pins_a: ps20 at 0 {
 				allwinner,pins = "PI20", "PI21";
 				allwinner,function = "ps2";
-				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 
 			ps21_pins_a: ps21 at 0 {
 				allwinner,pins = "PH12", "PH13";
 				allwinner,function = "ps2";
-				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 
 			pwm0_pins_a: pwm0 at 0 {
 				allwinner,pins = "PB2";
 				allwinner,function = "pwm";
-				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 
 			pwm1_pins_a: pwm1 at 0 {
 				allwinner,pins = "PI3";
 				allwinner,function = "pwm";
-				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 
 			spdif_tx_pins_a: spdif at 0 {
@@ -1249,109 +1230,91 @@
 			spi0_pins_a: spi0 at 0 {
 				allwinner,pins = "PI11", "PI12", "PI13";
 				allwinner,function = "spi0";
-				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 
 			spi0_cs0_pins_a: spi0_cs0 at 0 {
 				allwinner,pins = "PI10";
 				allwinner,function = "spi0";
-				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 
 			spi0_cs1_pins_a: spi0_cs1 at 0 {
 				allwinner,pins = "PI14";
 				allwinner,function = "spi0";
-				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 
 			spi1_pins_a: spi1 at 0 {
 				allwinner,pins = "PI17", "PI18", "PI19";
 				allwinner,function = "spi1";
-				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 
 			spi1_cs0_pins_a: spi1_cs0 at 0 {
 				allwinner,pins = "PI16";
 				allwinner,function = "spi1";
-				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 
 			spi2_pins_a: spi2 at 0 {
 				allwinner,pins = "PC20", "PC21", "PC22";
 				allwinner,function = "spi2";
-				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 
 			spi2_pins_b: spi2 at 1 {
 				allwinner,pins = "PB15", "PB16", "PB17";
 				allwinner,function = "spi2";
-				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 
 			spi2_cs0_pins_a: spi2_cs0 at 0 {
 				allwinner,pins = "PC19";
 				allwinner,function = "spi2";
-				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 
 			spi2_cs0_pins_b: spi2_cs0 at 1 {
 				allwinner,pins = "PB14";
 				allwinner,function = "spi2";
-				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 
 			uart0_pins_a: uart0 at 0 {
 				allwinner,pins = "PB22", "PB23";
 				allwinner,function = "uart0";
-				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 
 			uart2_pins_a: uart2 at 0 {
 				allwinner,pins = "PI16", "PI17", "PI18", "PI19";
 				allwinner,function = "uart2";
-				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 
 			uart3_pins_a: uart3 at 0 {
 				allwinner,pins = "PG6", "PG7", "PG8", "PG9";
 				allwinner,function = "uart3";
-				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 
 			uart3_pins_b: uart3 at 1 {
 				allwinner,pins = "PH0", "PH1";
 				allwinner,function = "uart3";
-				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 
 			uart4_pins_a: uart4 at 0 {
 				allwinner,pins = "PG10", "PG11";
 				allwinner,function = "uart4";
-				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 
 			uart4_pins_b: uart4 at 1 {
 				allwinner,pins = "PH4", "PH5";
 				allwinner,function = "uart4";
-				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 
 			uart5_pins_a: uart5 at 0 {
 				allwinner,pins = "PI10", "PI11";
 				allwinner,function = "uart5";
-				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 
 			uart6_pins_a: uart6 at 0 {
 				allwinner,pins = "PI12", "PI13";
 				allwinner,function = "uart6";
-				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 
 			uart7_pins_a: uart7 at 0 {
 				allwinner,pins = "PI20", "PI21";
 				allwinner,function = "uart7";
-				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 		};
 
diff --git a/arch/arm/boot/dts/sun8i-a23-a33.dtsi b/arch/arm/boot/dts/sun8i-a23-a33.dtsi
index 3f9b0f0f9b4c..3d2ad7da2564 100644
--- a/arch/arm/boot/dts/sun8i-a23-a33.dtsi
+++ b/arch/arm/boot/dts/sun8i-a23-a33.dtsi
@@ -275,7 +275,6 @@
 			uart0_pins_a: uart0 at 0 {
 				allwinner,pins = "PF2", "PF4";
 				allwinner,function = "uart0";
-				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 
 			uart1_pins_a: uart1 at 0 {
@@ -293,7 +292,6 @@
 						 "PF3", "PF4", "PF5";
 				allwinner,function = "mmc0";
 				allwinner,drive = <SUN4I_PINCTRL_30_MA>;
-				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 
 			mmc1_pins_a: mmc1 at 0 {
@@ -301,7 +299,6 @@
 						 "PG3", "PG4", "PG5";
 				allwinner,function = "mmc1";
 				allwinner,drive = <SUN4I_PINCTRL_30_MA>;
-				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 
 			mmc2_8bit_pins: mmc2_8bit {
@@ -311,31 +308,26 @@
 						 "PC15", "PC16";
 				allwinner,function = "mmc2";
 				allwinner,drive = <SUN4I_PINCTRL_30_MA>;
-				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 
 			pwm0_pins: pwm0 {
 				allwinner,pins = "PH0";
 				allwinner,function = "pwm0";
-				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 
 			i2c0_pins_a: i2c0 at 0 {
 				allwinner,pins = "PH2", "PH3";
 				allwinner,function = "i2c0";
-				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 
 			i2c1_pins_a: i2c1 at 0 {
 				allwinner,pins = "PH4", "PH5";
 				allwinner,function = "i2c1";
-				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 
 			i2c2_pins_a: i2c2 at 0 {
 				allwinner,pins = "PE12", "PE13";
 				allwinner,function = "i2c2";
-				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 
 			lcd_rgb666_pins: lcd-rgb666 at 0 {
@@ -344,7 +336,6 @@
 			                         "PD18", "PD19", "PD20", "PD21", "PD22", "PD23",
 			                         "PD24", "PD25", "PD26", "PD27";
 				allwinner,function = "lcd0";
-				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 		};
 
@@ -584,7 +575,6 @@
 			r_uart_pins_a: r_uart at 0 {
 				allwinner,pins = "PL2", "PL3";
 				allwinner,function = "s_uart";
-				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 		};
 
diff --git a/arch/arm/boot/dts/sun8i-a23-polaroid-mid2407pxe03.dts b/arch/arm/boot/dts/sun8i-a23-polaroid-mid2407pxe03.dts
index fea9db3ee9ad..89f68a78ab32 100644
--- a/arch/arm/boot/dts/sun8i-a23-polaroid-mid2407pxe03.dts
+++ b/arch/arm/boot/dts/sun8i-a23-polaroid-mid2407pxe03.dts
@@ -93,7 +93,6 @@
 	wifi_pwrseq_pin_mid2407: wifi_pwrseq_pin at 0 {
 		allwinner,pins = "PL6";
 		allwinner,function = "gpio_out";
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 };
 
diff --git a/arch/arm/boot/dts/sun8i-a23-polaroid-mid2809pxe04.dts b/arch/arm/boot/dts/sun8i-a23-polaroid-mid2809pxe04.dts
index abcd94ea5e86..e8367deaa587 100644
--- a/arch/arm/boot/dts/sun8i-a23-polaroid-mid2809pxe04.dts
+++ b/arch/arm/boot/dts/sun8i-a23-polaroid-mid2809pxe04.dts
@@ -86,7 +86,6 @@
 	wifi_pwrseq_pin_mid2809: wifi_pwrseq_pin at 0 {
 		allwinner,pins = "PL6";
 		allwinner,function = "gpio_out";
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 };
 
diff --git a/arch/arm/boot/dts/sun8i-a33-inet-d978-rev2.dts b/arch/arm/boot/dts/sun8i-a33-inet-d978-rev2.dts
index fb4665576dff..442db91b943a 100644
--- a/arch/arm/boot/dts/sun8i-a33-inet-d978-rev2.dts
+++ b/arch/arm/boot/dts/sun8i-a33-inet-d978-rev2.dts
@@ -92,7 +92,6 @@
 		allwinner,pins = "PL5";
 		allwinner,function = "gpio_out";
 		allwinner,drive = <SUN4I_PINCTRL_20_MA>;
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 };
 
diff --git a/arch/arm/boot/dts/sun8i-a33-olinuxino.dts b/arch/arm/boot/dts/sun8i-a33-olinuxino.dts
index 7eaf610eabd7..59a64d2d695c 100644
--- a/arch/arm/boot/dts/sun8i-a33-olinuxino.dts
+++ b/arch/arm/boot/dts/sun8i-a33-olinuxino.dts
@@ -94,19 +94,16 @@
 	led_pin_olinuxino: led_pins at 0 {
 		allwinner,pins = "PB7";
 		allwinner,function = "gpio_out";
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 
 	mmc0_cd_pin_olinuxino: mmc0_cd_pin at 0 {
 		allwinner,pins = "PB4";
 		allwinner,function = "gpio_in";
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 
 	usb0_id_detect_pin: usb0_id_detect_pin at 0 {
 		allwinner,pins = "PB3";
 		allwinner,function = "gpio_in";
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 };
 
diff --git a/arch/arm/boot/dts/sun8i-a33.dtsi b/arch/arm/boot/dts/sun8i-a33.dtsi
index e60c4c8c6976..310a38cf7f18 100644
--- a/arch/arm/boot/dts/sun8i-a33.dtsi
+++ b/arch/arm/boot/dts/sun8i-a33.dtsi
@@ -240,7 +240,6 @@
 	uart0_pins_b: uart0 at 1 {
 		allwinner,pins = "PB0", "PB1";
 		allwinner,function = "uart0";
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 
 };
diff --git a/arch/arm/boot/dts/sun8i-a83t.dtsi b/arch/arm/boot/dts/sun8i-a83t.dtsi
index c03d7f4cac83..cec6bfc2d3c9 100644
--- a/arch/arm/boot/dts/sun8i-a83t.dtsi
+++ b/arch/arm/boot/dts/sun8i-a83t.dtsi
@@ -171,19 +171,16 @@
 						 "PF3", "PF4", "PF5";
 				allwinner,function = "mmc0";
 				allwinner,drive = <SUN4I_PINCTRL_30_MA>;
-				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 
 			uart0_pins_a: uart0 at 0 {
 				allwinner,pins = "PF2", "PF4";
 				allwinner,function = "uart0";
-				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 
 			uart0_pins_b: uart0 at 1 {
 				allwinner,pins = "PB9", "PB10";
 				allwinner,function = "uart0";
-				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 		};
 
diff --git a/arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dts b/arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dts
index e02314a2d643..49194c38d56b 100644
--- a/arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dts
+++ b/arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dts
@@ -158,19 +158,16 @@
 	pwr_led_bpi_m2p: led_pins at 0 {
 		allwinner,pins = "PL10";
 		allwinner,function = "gpio_out";
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 
 	sw_r_bpi_m2p: key_pins at 0 {
 		allwinner,pins = "PL3";
 		allwinner,function = "gpio_in";
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 
 	wifi_en_bpi_m2p: wifi_en_pin {
 		allwinner,pins = "PL7";
 		allwinner,function = "gpio_out";
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 };
 
diff --git a/arch/arm/boot/dts/sun8i-h3-nanopi-neo.dts b/arch/arm/boot/dts/sun8i-h3-nanopi-neo.dts
index 277935e10543..1c6e96e8ec98 100644
--- a/arch/arm/boot/dts/sun8i-h3-nanopi-neo.dts
+++ b/arch/arm/boot/dts/sun8i-h3-nanopi-neo.dts
@@ -99,7 +99,6 @@
 	leds_opc: led-pins {
 		allwinner,pins = "PA10";
 		allwinner,function = "gpio_out";
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 };
 
@@ -107,7 +106,6 @@
 	leds_r_opc: led-pins {
 		allwinner,pins = "PL10";
 		allwinner,function = "gpio_out";
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 };
 
diff --git a/arch/arm/boot/dts/sun8i-h3-orangepi-2.dts b/arch/arm/boot/dts/sun8i-h3-orangepi-2.dts
index e44af3446514..dfd9bc2008fd 100644
--- a/arch/arm/boot/dts/sun8i-h3-orangepi-2.dts
+++ b/arch/arm/boot/dts/sun8i-h3-orangepi-2.dts
@@ -147,7 +147,6 @@
 	leds_opc: led_pins at 0 {
 		allwinner,pins = "PA15";
 		allwinner,function = "gpio_out";
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 };
 
@@ -155,19 +154,16 @@
 	leds_r_opc: led_pins at 0 {
 		allwinner,pins = "PL10";
 		allwinner,function = "gpio_out";
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 
 	sw_r_opc: key_pins at 0 {
 		allwinner,pins = "PL3", "PL4";
 		allwinner,function = "gpio_in";
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 
 	wifi_pwrseq_pin_orangepi: wifi_pwrseq_pin at 0 {
 		allwinner,pins = "PL7";
 		allwinner,function = "gpio_out";
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 };
 
diff --git a/arch/arm/boot/dts/sun8i-h3-orangepi-lite.dts b/arch/arm/boot/dts/sun8i-h3-orangepi-lite.dts
index ce5b1086b580..77d29bae7739 100644
--- a/arch/arm/boot/dts/sun8i-h3-orangepi-lite.dts
+++ b/arch/arm/boot/dts/sun8i-h3-orangepi-lite.dts
@@ -145,7 +145,6 @@
 	leds_opc: led_pins at 0 {
 		allwinner,pins = "PA15";
 		allwinner,function = "gpio_out";
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 };
 
@@ -153,13 +152,11 @@
 	leds_r_opc: led_pins at 0 {
 		allwinner,pins = "PL10";
 		allwinner,function = "gpio_out";
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 
 	sw_r_opc: key_pins at 0 {
 		allwinner,pins = "PL3";
 		allwinner,function = "gpio_in";
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 };
 
diff --git a/arch/arm/boot/dts/sun8i-h3-orangepi-one.dts b/arch/arm/boot/dts/sun8i-h3-orangepi-one.dts
index fbdd239175d4..49529d9ca26d 100644
--- a/arch/arm/boot/dts/sun8i-h3-orangepi-one.dts
+++ b/arch/arm/boot/dts/sun8i-h3-orangepi-one.dts
@@ -112,7 +112,6 @@
 	leds_opc: led_pins at 0 {
 		allwinner,pins = "PA15";
 		allwinner,function = "gpio_out";
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 };
 
@@ -120,13 +119,11 @@
 	leds_r_opc: led_pins at 0 {
 		allwinner,pins = "PL10";
 		allwinner,function = "gpio_out";
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 
 	sw_r_opc: key_pins at 0 {
 		allwinner,pins = "PL3";
 		allwinner,function = "gpio_in";
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 };
 
diff --git a/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts b/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts
index 638720c3d04e..0d56d33d43ea 100644
--- a/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts
+++ b/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts
@@ -134,7 +134,6 @@
 	leds_opc: led_pins at 0 {
 		allwinner,pins = "PA15";
 		allwinner,function = "gpio_out";
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 };
 
@@ -142,13 +141,11 @@
 	leds_r_opc: led_pins at 0 {
 		allwinner,pins = "PL10";
 		allwinner,function = "gpio_out";
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 
 	sw_r_opc: key_pins at 0 {
 		allwinner,pins = "PL3";
 		allwinner,function = "gpio_in";
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 };
 
diff --git a/arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts b/arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts
index 1236583caf64..ab8593d1d3df 100644
--- a/arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts
+++ b/arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts
@@ -85,7 +85,6 @@
 	usb3_vbus_pin_a: usb3_vbus_pin at 0 {
 		allwinner,pins = "PG11";
 		allwinner,function = "gpio_out";
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 };
 
diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi b/arch/arm/boot/dts/sun8i-h3.dtsi
index 098373ce38eb..9510d785bd12 100644
--- a/arch/arm/boot/dts/sun8i-h3.dtsi
+++ b/arch/arm/boot/dts/sun8i-h3.dtsi
@@ -330,19 +330,16 @@
 			i2c0_pins: i2c0 {
 				allwinner,pins = "PA11", "PA12";
 				allwinner,function = "i2c0";
-				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 
 			i2c1_pins: i2c1 {
 				allwinner,pins = "PA18", "PA19";
 				allwinner,function = "i2c1";
-				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 
 			i2c2_pins: i2c2 {
 				allwinner,pins = "PE12", "PE13";
 				allwinner,function = "i2c2";
-				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 
 			mmc0_pins_a: mmc0 at 0 {
@@ -350,7 +347,6 @@
 						 "PF4", "PF5";
 				allwinner,function = "mmc0";
 				allwinner,drive = <SUN4I_PINCTRL_30_MA>;
-				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 
 			mmc0_cd_pin: mmc0_cd_pin at 0 {
@@ -364,7 +360,6 @@
 						 "PG4", "PG5";
 				allwinner,function = "mmc1";
 				allwinner,drive = <SUN4I_PINCTRL_30_MA>;
-				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 
 			mmc2_8bit_pins: mmc2_8bit {
@@ -374,37 +369,31 @@
 						 "PC15", "PC16";
 				allwinner,function = "mmc2";
 				allwinner,drive = <SUN4I_PINCTRL_30_MA>;
-				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 
 			uart0_pins_a: uart0 at 0 {
 				allwinner,pins = "PA4", "PA5";
 				allwinner,function = "uart0";
-				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 
 			uart1_pins: uart1 {
 				allwinner,pins = "PG6", "PG7";
 				allwinner,function = "uart1";
-				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 
 			uart1_rts_cts_pins: uart1_rts_cts {
 				allwinner,pins = "PG8", "PG9";
 				allwinner,function = "uart1";
-				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 
 			uart2_pins: uart2 {
 				allwinner,pins = "PA0", "PA1";
 				allwinner,function = "uart2";
-				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 
 			uart3_pins: uart3 {
 				allwinner,pins = "PG13", "PG14";
 				allwinner,function = "uart3";
-				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 		};
 
@@ -569,7 +558,6 @@
 			ir_pins_a: ir at 0 {
 				allwinner,pins = "PL11";
 				allwinner,function = "s_cir_rx";
-				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 		};
 	};
diff --git a/arch/arm/boot/dts/sun8i-r16-parrot.dts b/arch/arm/boot/dts/sun8i-r16-parrot.dts
index 6161ec441df5..0588fceb0636 100644
--- a/arch/arm/boot/dts/sun8i-r16-parrot.dts
+++ b/arch/arm/boot/dts/sun8i-r16-parrot.dts
@@ -167,7 +167,6 @@
 	led_pins_parrot: led_pins at 0 {
 		allwinner,pins = "PE16", "PE17";
 		allwinner,function = "gpio_out";
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 
 	usb0_id_det: usb0_id_detect_pin at 0 {
@@ -179,7 +178,6 @@
 	usb1_vbus_pin_parrot: usb1_vbus_pin at 0 {
 		allwinner,pins = "PD12";
 		allwinner,function = "gpio_out";
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 };
 
@@ -187,7 +185,6 @@
 	wifi_reset_pin_parrot: wifi_reset_pin at 0 {
 		allwinner,pins = "PL6";
 		allwinner,function = "gpio_out";
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 };
 
diff --git a/arch/arm/boot/dts/sun8i-reference-design-tablet.dtsi b/arch/arm/boot/dts/sun8i-reference-design-tablet.dtsi
index ae95e5969681..dea852b2a4f3 100644
--- a/arch/arm/boot/dts/sun8i-reference-design-tablet.dtsi
+++ b/arch/arm/boot/dts/sun8i-reference-design-tablet.dtsi
@@ -96,7 +96,6 @@
 	bl_en_pin: bl_en_pin at 0 {
 		allwinner,pins = "PH6";
 		allwinner,function = "gpio_in";
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 
 	mmc0_cd_pin: mmc0_cd_pin at 0 {
@@ -108,7 +107,6 @@
 	ts_power_pin: ts_power_pin at 0 {
 		allwinner,pins = "PH1";
 		allwinner,function = "gpio_out";
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 
 	usb0_id_detect_pin: usb0_id_detect_pin at 0 {
diff --git a/arch/arm/boot/dts/sun9i-a80-cubieboard4.dts b/arch/arm/boot/dts/sun9i-a80-cubieboard4.dts
index e1be9fca86c7..e0ae76088f7e 100644
--- a/arch/arm/boot/dts/sun9i-a80-cubieboard4.dts
+++ b/arch/arm/boot/dts/sun9i-a80-cubieboard4.dts
@@ -112,7 +112,6 @@
 	led_pins_cubieboard4: led-pins at 0 {
 		allwinner,pins = "PH6", "PH17";
 		allwinner,function = "gpio_out";
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 
 	mmc0_cd_pin_cubieboard4: mmc0_cd_pin at 0 {
diff --git a/arch/arm/boot/dts/sun9i-a80-optimus.dts b/arch/arm/boot/dts/sun9i-a80-optimus.dts
index 0b2f7042bddf..a2e540fc5725 100644
--- a/arch/arm/boot/dts/sun9i-a80-optimus.dts
+++ b/arch/arm/boot/dts/sun9i-a80-optimus.dts
@@ -162,7 +162,6 @@
 	led_pins_optimus: led-pins at 0 {
 		allwinner,pins = "PH0", "PH1";
 		allwinner,function = "gpio_out";
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 
 	mmc0_cd_pin_optimus: mmc0_cd_pin at 0 {
@@ -174,13 +173,11 @@
 	usb1_vbus_pin_optimus: usb1_vbus_pin at 1 {
 		allwinner,pins = "PH4";
 		allwinner,function = "gpio_out";
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 
 	usb3_vbus_pin_optimus: usb3_vbus_pin at 1 {
 		allwinner,pins = "PH5";
 		allwinner,function = "gpio_out";
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 };
 
@@ -192,7 +189,6 @@
 	led_r_pins_optimus: led-pins at 1 {
 		allwinner,pins = "PM15";
 		allwinner,function = "gpio_out";
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 };
 
diff --git a/arch/arm/boot/dts/sun9i-a80.dtsi b/arch/arm/boot/dts/sun9i-a80.dtsi
index 293b41ac8e37..d03f7481401c 100644
--- a/arch/arm/boot/dts/sun9i-a80.dtsi
+++ b/arch/arm/boot/dts/sun9i-a80.dtsi
@@ -688,7 +688,6 @@
 			i2c3_pins_a: i2c3 at 0 {
 				allwinner,pins = "PG10", "PG11";
 				allwinner,function = "i2c3";
-				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 
 			mmc0_pins: mmc0 {
@@ -696,7 +695,6 @@
 						 "PF4", "PF5";
 				allwinner,function = "mmc0";
 				allwinner,drive = <SUN4I_PINCTRL_30_MA>;
-				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 
 			mmc2_8bit_pins: mmc2_8bit {
@@ -706,19 +704,16 @@
 						 "PC16";
 				allwinner,function = "mmc2";
 				allwinner,drive = <SUN4I_PINCTRL_30_MA>;
-				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 
 			uart0_pins_a: uart0 at 0 {
 				allwinner,pins = "PH12", "PH13";
 				allwinner,function = "uart0";
-				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 
 			uart4_pins_a: uart4 at 0 {
 				allwinner,pins = "PG12", "PG13", "PG14", "PG15";
 				allwinner,function = "uart4";
-				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 		};
 
@@ -901,7 +896,6 @@
 			r_ir_pins: r_ir {
 				allwinner,pins = "PL6";
 				allwinner,function = "s_cir_rx";
-				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 
 			r_rsb_pins: r_rsb {
diff --git a/arch/arm/boot/dts/sunxi-common-regulators.dtsi b/arch/arm/boot/dts/sunxi-common-regulators.dtsi
index 7809e18d30bd..358b8d9b4703 100644
--- a/arch/arm/boot/dts/sunxi-common-regulators.dtsi
+++ b/arch/arm/boot/dts/sunxi-common-regulators.dtsi
@@ -49,25 +49,21 @@
 	ahci_pwr_pin_a: ahci_pwr_pin at 0 {
 		allwinner,pins = "PB8";
 		allwinner,function = "gpio_out";
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 
 	usb0_vbus_pin_a: usb0_vbus_pin at 0 {
 		allwinner,pins = "PB9";
 		allwinner,function = "gpio_out";
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 
 	usb1_vbus_pin_a: usb1_vbus_pin at 0 {
 		allwinner,pins = "PH6";
 		allwinner,function = "gpio_out";
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 
 	usb2_vbus_pin_a: usb2_vbus_pin at 0 {
 		allwinner,pins = "PH3";
 		allwinner,function = "gpio_out";
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 };
 
-- 
git-series 0.8.10
