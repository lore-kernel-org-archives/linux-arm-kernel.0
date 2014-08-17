From: wens@csie.org (Chen-Yu Tsai)
Date: Sun, 17 Aug 2014 11:52:15 +0800
Subject: [PATCH 09/12] ARM: dts: sun8i: Enable mmc controller on ippo-q8h-v5
In-Reply-To: <1408247538-16950-1-git-send-email-wens@csie.org>
References: <1408247538-16950-1-git-send-email-wens@csie.org>
Message-ID: <1408247538-16950-10-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The card detect pin setting was taken from the original fex file,
and is confirmed to work.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun8i-a23-ippo-q8h-v5.dts | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a23-ippo-q8h-v5.dts b/arch/arm/boot/dts/sun8i-a23-ippo-q8h-v5.dts
index 224f53e..ef1e4f3 100644
--- a/arch/arm/boot/dts/sun8i-a23-ippo-q8h-v5.dts
+++ b/arch/arm/boot/dts/sun8i-a23-ippo-q8h-v5.dts
@@ -13,6 +13,7 @@
 
 /dts-v1/;
 /include/ "sun8i-a23.dtsi"
+/include/ "sunxi-common-regulators.dtsi"
 
 / {
 	model = "Ippo Q8H Dual Core Tablet (v5)";
@@ -23,6 +24,25 @@
 	};
 
 	soc at 01c00000 {
+		mmc0: mmc at 01c0f000 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_q8h>;
+			vmmc-supply = <&reg_vcc3v0>;
+			bus-width = <4>;
+			cd-gpios = <&pio 1 4 0>; /* PB4 */
+			cd-inverted;
+			status = "okay";
+		};
+
+		pinctrl at 01c20800 {
+			mmc0_cd_pin_q8h: mmc0_cd_pin at 0 {
+				allwinner,pins = "PB4";
+				allwinner,function = "gpio_in";
+				allwinner,drive = <0>;
+				allwinner,pull = <1>;
+			};
+		};
+
 		r_uart: serial at 01f02800 {
 			pinctrl-names = "default";
 			pinctrl-0 = <&r_uart_pins_a>;
-- 
2.1.0
