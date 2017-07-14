From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 14 Jul 2017 14:43:02 +0800
Subject: [PATCH 11/11] ARM: dts: sun8i: a83t: h8homlet: Enable micro-SD card
 and onboard eMMC
In-Reply-To: <20170714064302.20383-1-wens@csie.org>
References: <20170714064302.20383-1-wens@csie.org>
Message-ID: <20170714064302.20383-12-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The H8 homlet has a micro-SD card slot connected to mmc0,
and onboard eMMC from FORESEE, connected to mmc2.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 .../boot/dts/sun8i-a83t-allwinner-h8homlet-v2.dts   | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a83t-allwinner-h8homlet-v2.dts b/arch/arm/boot/dts/sun8i-a83t-allwinner-h8homlet-v2.dts
index aecdeeb368ed..7afbaa4eea8d 100644
--- a/arch/arm/boot/dts/sun8i-a83t-allwinner-h8homlet-v2.dts
+++ b/arch/arm/boot/dts/sun8i-a83t-allwinner-h8homlet-v2.dts
@@ -43,6 +43,7 @@
 
 /dts-v1/;
 #include "sun8i-a83t.dtsi"
+#include "sunxi-common-regulators.dtsi"
 
 / {
 	model = "Allwinner A83T H8Homlet Proto Dev Board v2.0";
@@ -57,6 +58,26 @@
 	};
 };
 
+&mmc0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc0_pins>;
+	vmmc-supply = <&reg_vcc3v0>;
+	cd-gpios = <&pio 5 6 GPIO_ACTIVE_HIGH>; /* PF6 */
+	bus-width = <4>;
+	cd-inverted;
+	status = "okay";
+};
+
+&mmc2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc2_8bit_emmc_pins>;
+	vmmc-supply = <&reg_vcc3v0>;
+	bus-width = <8>;
+	non-removable;
+	cap-mmc-hw-reset;
+	status = "okay";
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_pb_pins>;
-- 
2.13.2
