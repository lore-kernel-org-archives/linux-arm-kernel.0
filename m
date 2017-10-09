From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon,  9 Oct 2017 22:22:51 +0200
Subject: [PATCH v2 2/5] ARM: dts: sun4i: Provide default muxing for relevant
 controllers
In-Reply-To: <cover.e7363fd7884334063590603c0b0de566f66e0c18.1507580565.git-series.maxime.ripard@free-electrons.com>
References: <cover.e7363fd7884334063590603c0b0de566f66e0c18.1507580565.git-series.maxime.ripard@free-electrons.com>
Message-ID: <a3995c8dc0a63498627c30da5dd42071b2747d14.1507580565.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The I2C's, MMC0 and EMAC controllers have only one muxing option in the
SoC. In such a case, we can just move the muxing into the DTSI, and remove
it from the DTS.

Acked-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun4i-a10-a1000.dts            |  6 ------
 arch/arm/boot/dts/sun4i-a10-ba10-tvbox.dts       |  6 ------
 arch/arm/boot/dts/sun4i-a10-chuwi-v7-cw0825.dts  |  8 --------
 arch/arm/boot/dts/sun4i-a10-cubieboard.dts       |  8 --------
 arch/arm/boot/dts/sun4i-a10-dserve-dsrv9703c.dts |  8 --------
 arch/arm/boot/dts/sun4i-a10-gemei-g9.dts         |  6 ------
 arch/arm/boot/dts/sun4i-a10-hackberry.dts        |  4 ----
 arch/arm/boot/dts/sun4i-a10-hyundai-a7hd.dts     |  4 ----
 arch/arm/boot/dts/sun4i-a10-inet1.dts            |  8 --------
 arch/arm/boot/dts/sun4i-a10-inet97fv2.dts        |  8 --------
 arch/arm/boot/dts/sun4i-a10-inet9f-rev03.dts     |  8 --------
 arch/arm/boot/dts/sun4i-a10-jesurun-q5.dts       |  6 ------
 arch/arm/boot/dts/sun4i-a10-marsboard.dts        | 10 ----------
 arch/arm/boot/dts/sun4i-a10-mini-xplus.dts       |  4 ----
 arch/arm/boot/dts/sun4i-a10-mk802.dts            |  2 --
 arch/arm/boot/dts/sun4i-a10-mk802ii.dts          |  4 ----
 arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts   |  8 --------
 arch/arm/boot/dts/sun4i-a10-pcduino.dts          |  6 ------
 arch/arm/boot/dts/sun4i-a10-pov-protab2-ips9.dts |  8 --------
 arch/arm/boot/dts/sun4i-a10.dtsi                 | 12 ++++++++++++
 arch/arm/boot/dts/sunxi-itead-core-common.dtsi   |  4 ----
 21 files changed, 12 insertions(+), 126 deletions(-)

diff --git a/arch/arm/boot/dts/sun4i-a10-a1000.dts b/arch/arm/boot/dts/sun4i-a10-a1000.dts
index 769ae7f4dfbb..09e909576c61 100644
--- a/arch/arm/boot/dts/sun4i-a10-a1000.dts
+++ b/arch/arm/boot/dts/sun4i-a10-a1000.dts
@@ -125,8 +125,6 @@
 };
 
 &emac {
-	pinctrl-names = "default";
-	pinctrl-0 = <&emac_pins>;
 	phy = <&phy1>;
 	status = "okay";
 };
@@ -136,8 +134,6 @@
 };
 
 &i2c0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c0_pins>;
 	status = "okay";
 
 	axp209: pmic at 34 {
@@ -166,8 +162,6 @@
 };
 
 &mmc0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	cd-gpios = <&pio 7 1 GPIO_ACTIVE_HIGH>; /* PH1 */
diff --git a/arch/arm/boot/dts/sun4i-a10-ba10-tvbox.dts b/arch/arm/boot/dts/sun4i-a10-ba10-tvbox.dts
index 64a67b954d2a..39ba4ccb9e2e 100644
--- a/arch/arm/boot/dts/sun4i-a10-ba10-tvbox.dts
+++ b/arch/arm/boot/dts/sun4i-a10-ba10-tvbox.dts
@@ -68,8 +68,6 @@
 };
 
 &emac {
-	pinctrl-names = "default";
-	pinctrl-0 = <&emac_pins>;
 	phy = <&phy1>;
 	status = "okay";
 };
@@ -79,8 +77,6 @@
 };
 
 &i2c0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c0_pins>;
 	status = "okay";
 
 	axp209: pmic at 34 {
@@ -108,8 +104,6 @@
 };
 
 &mmc0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	cd-gpios = <&pio 7 1 GPIO_ACTIVE_HIGH>; /* PH1 */
diff --git a/arch/arm/boot/dts/sun4i-a10-chuwi-v7-cw0825.dts b/arch/arm/boot/dts/sun4i-a10-chuwi-v7-cw0825.dts
index 1afbf6bc8b7d..b2dbdac19c0f 100644
--- a/arch/arm/boot/dts/sun4i-a10-chuwi-v7-cw0825.dts
+++ b/arch/arm/boot/dts/sun4i-a10-chuwi-v7-cw0825.dts
@@ -65,8 +65,6 @@
 };
 
 &i2c0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c0_pins>;
 	status = "okay";
 
 	axp209: pmic at 34 {
@@ -80,14 +78,10 @@
 };
 
 &i2c1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c1_pins>;
 	status = "okay";
 };
 
 &i2c2 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c2_pins>;
 	status = "okay";
 
 	ft5306de4: touchscreen at 38 {
@@ -127,8 +121,6 @@
 };
 
 &mmc0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	cd-gpios = <&pio 7 1 GPIO_ACTIVE_HIGH>; /* PH1 */
diff --git a/arch/arm/boot/dts/sun4i-a10-cubieboard.dts b/arch/arm/boot/dts/sun4i-a10-cubieboard.dts
index d240209bfe85..b48cc70aa6c2 100644
--- a/arch/arm/boot/dts/sun4i-a10-cubieboard.dts
+++ b/arch/arm/boot/dts/sun4i-a10-cubieboard.dts
@@ -99,8 +99,6 @@
 };
 
 &emac {
-	pinctrl-names = "default";
-	pinctrl-0 = <&emac_pins>;
 	phy = <&phy1>;
 	status = "okay";
 };
@@ -110,8 +108,6 @@
 };
 
 &i2c0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c0_pins>;
 	status = "okay";
 
 	axp209: pmic at 34 {
@@ -121,8 +117,6 @@
 };
 
 &i2c1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c1_pins>;
 	status = "okay";
 };
 
@@ -141,8 +135,6 @@
 };
 
 &mmc0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	cd-gpios = <&pio 7 1 GPIO_ACTIVE_HIGH>; /* PH1 */
diff --git a/arch/arm/boot/dts/sun4i-a10-dserve-dsrv9703c.dts b/arch/arm/boot/dts/sun4i-a10-dserve-dsrv9703c.dts
index e527b86de8c6..acbf692e837f 100644
--- a/arch/arm/boot/dts/sun4i-a10-dserve-dsrv9703c.dts
+++ b/arch/arm/boot/dts/sun4i-a10-dserve-dsrv9703c.dts
@@ -99,8 +99,6 @@
 };
 
 &i2c0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c0_pins>;
 	status = "okay";
 
 	axp209: pmic at 34 {
@@ -112,15 +110,11 @@
 #include "axp209.dtsi"
 
 &i2c1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c1_pins>;
 	/* pull-ups and devices require AXP209 LDO3 */
 	status = "failed";
 };
 
 &i2c2 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c2_pins>;
 	status = "okay";
 
 	ft5406ee8: touchscreen at 38 {
@@ -154,8 +148,6 @@
 };
 
 &mmc0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	cd-gpios = <&pio 7 1 GPIO_ACTIVE_HIGH>; /* PH1 */
diff --git a/arch/arm/boot/dts/sun4i-a10-gemei-g9.dts b/arch/arm/boot/dts/sun4i-a10-gemei-g9.dts
index de78e28ecb84..41ca8bded89f 100644
--- a/arch/arm/boot/dts/sun4i-a10-gemei-g9.dts
+++ b/arch/arm/boot/dts/sun4i-a10-gemei-g9.dts
@@ -89,8 +89,6 @@
 };
 
 &i2c0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c0_pins>;
 	status = "okay";
 
 	axp209: pmic at 34 {
@@ -102,8 +100,6 @@
 #include "axp209.dtsi"
 
 &i2c1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c1_pins>;
 	status = "okay";
 
 	/* Accelerometer */
@@ -143,8 +139,6 @@
 };
 
 &mmc0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	cd-gpios = <&pio 7 1 GPIO_ACTIVE_HIGH>; /* PH01 */
diff --git a/arch/arm/boot/dts/sun4i-a10-hackberry.dts b/arch/arm/boot/dts/sun4i-a10-hackberry.dts
index e59ae6085870..f33e42d6ce8b 100644
--- a/arch/arm/boot/dts/sun4i-a10-hackberry.dts
+++ b/arch/arm/boot/dts/sun4i-a10-hackberry.dts
@@ -80,8 +80,6 @@
 };
 
 &emac {
-	pinctrl-names = "default";
-	pinctrl-0 = <&emac_pins>;
 	phy = <&phy0>;
 	status = "okay";
 };
@@ -106,8 +104,6 @@
 };
 
 &mmc0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	cd-gpios = <&pio 7 1 GPIO_ACTIVE_HIGH>; /* PH1 */
diff --git a/arch/arm/boot/dts/sun4i-a10-hyundai-a7hd.dts b/arch/arm/boot/dts/sun4i-a10-hyundai-a7hd.dts
index 0c4437f0ef5c..f5e9b643007e 100644
--- a/arch/arm/boot/dts/sun4i-a10-hyundai-a7hd.dts
+++ b/arch/arm/boot/dts/sun4i-a10-hyundai-a7hd.dts
@@ -63,8 +63,6 @@
 };
 
 &i2c0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c0_pins>;
 	status = "okay";
 
 	axp209: pmic at 34 {
@@ -78,8 +76,6 @@
 };
 
 &mmc0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	cd-gpios = <&pio 7 1 GPIO_ACTIVE_HIGH>; /* PH1 */
diff --git a/arch/arm/boot/dts/sun4i-a10-inet1.dts b/arch/arm/boot/dts/sun4i-a10-inet1.dts
index 1f69d69ee266..2374ee7dfc64 100644
--- a/arch/arm/boot/dts/sun4i-a10-inet1.dts
+++ b/arch/arm/boot/dts/sun4i-a10-inet1.dts
@@ -86,8 +86,6 @@
 };
 
 &i2c0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c0_pins>;
 	status = "okay";
 
 	axp209: pmic at 34 {
@@ -99,8 +97,6 @@
 #include "axp209.dtsi"
 
 &i2c1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c1_pins>;
 	status = "okay";
 
 	/* Accelerometer */
@@ -113,8 +109,6 @@
 };
 
 &i2c2 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c2_pins>;
 	status = "okay";
 
 	ft5x: touchscreen at 38 {
@@ -156,8 +150,6 @@
 };
 
 &mmc0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	cd-gpios = <&pio 7 1 GPIO_ACTIVE_HIGH>; /* PH1 */
diff --git a/arch/arm/boot/dts/sun4i-a10-inet97fv2.dts b/arch/arm/boot/dts/sun4i-a10-inet97fv2.dts
index ab3a8071c45f..c76f2538e3a2 100644
--- a/arch/arm/boot/dts/sun4i-a10-inet97fv2.dts
+++ b/arch/arm/boot/dts/sun4i-a10-inet97fv2.dts
@@ -72,8 +72,6 @@
 };
 
 &i2c0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c0_pins>;
 	status = "okay";
 
 	axp209: pmic at 34 {
@@ -85,14 +83,10 @@
 #include "axp209.dtsi"
 
 &i2c1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c1_pins>;
 	status = "okay";
 };
 
 &i2c2 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c2_pins>;
 	status = "okay";
 
 	ft5406ee8: touchscreen at 38 {
@@ -146,8 +140,6 @@
 };
 
 &mmc0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	cd-gpios = <&pio 7 1 GPIO_ACTIVE_HIGH>; /* PH1 */
diff --git a/arch/arm/boot/dts/sun4i-a10-inet9f-rev03.dts b/arch/arm/boot/dts/sun4i-a10-inet9f-rev03.dts
index c9498d93dde8..4188907b0477 100644
--- a/arch/arm/boot/dts/sun4i-a10-inet9f-rev03.dts
+++ b/arch/arm/boot/dts/sun4i-a10-inet9f-rev03.dts
@@ -222,8 +222,6 @@
 };
 
 &i2c0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c0_pins>;
 	status = "okay";
 
 	axp209: pmic at 34 {
@@ -235,8 +233,6 @@
 #include "axp209.dtsi"
 
 &i2c1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c1_pins>;
 	status = "okay";
 
 	/* Accelerometer */
@@ -249,8 +245,6 @@
 };
 
 &i2c2 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c2_pins>;
 	status = "okay";
 
 	ft5406ee8: touchscreen at 38 {
@@ -304,8 +298,6 @@
 };
 
 &mmc0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	cd-gpios = <&pio 7 1 GPIO_ACTIVE_HIGH>; /* PH1 */
diff --git a/arch/arm/boot/dts/sun4i-a10-jesurun-q5.dts b/arch/arm/boot/dts/sun4i-a10-jesurun-q5.dts
index 6558cd7dda10..879141ca6027 100644
--- a/arch/arm/boot/dts/sun4i-a10-jesurun-q5.dts
+++ b/arch/arm/boot/dts/sun4i-a10-jesurun-q5.dts
@@ -94,8 +94,6 @@
 };
 
 &emac {
-	pinctrl-names = "default";
-	pinctrl-0 = <&emac_pins>;
 	phy = <&phy1>;
 	status = "okay";
 };
@@ -105,8 +103,6 @@
 };
 
 &i2c0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c0_pins>;
 	status = "okay";
 
 	axp209: pmic at 34 {
@@ -135,8 +131,6 @@
 };
 
 &mmc0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	cd-gpios = <&pio 7 1 GPIO_ACTIVE_HIGH>; /* PH1 */
diff --git a/arch/arm/boot/dts/sun4i-a10-marsboard.dts b/arch/arm/boot/dts/sun4i-a10-marsboard.dts
index fb98c2a290c9..86c7c3fcaf9c 100644
--- a/arch/arm/boot/dts/sun4i-a10-marsboard.dts
+++ b/arch/arm/boot/dts/sun4i-a10-marsboard.dts
@@ -105,27 +105,19 @@
 };
 
 &emac {
-	pinctrl-names = "default";
-	pinctrl-0 = <&emac_pins>;
 	phy = <&phy1>;
 	status = "okay";
 };
 
 &i2c0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c0_pins>;
 	status = "okay";
 };
 
 &i2c1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c1_pins>;
 	status = "okay";
 };
 
 &i2c2 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c2_pins>;
 	status = "okay";
 };
 
@@ -138,8 +130,6 @@
 };
 
 &mmc0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	cd-gpios = <&pio 7 1 GPIO_ACTIVE_HIGH>; /* PH1 */
diff --git a/arch/arm/boot/dts/sun4i-a10-mini-xplus.dts b/arch/arm/boot/dts/sun4i-a10-mini-xplus.dts
index 3d3992d02b0e..1b639e5f9172 100644
--- a/arch/arm/boot/dts/sun4i-a10-mini-xplus.dts
+++ b/arch/arm/boot/dts/sun4i-a10-mini-xplus.dts
@@ -70,8 +70,6 @@
 };
 
 &i2c0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c0_pins>;
 	status = "okay";
 
 	axp209: pmic at 34 {
@@ -96,8 +94,6 @@
 };
 
 &mmc0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	cd-gpios = <&pio 7 1 GPIO_ACTIVE_HIGH>; /* PH1 */
diff --git a/arch/arm/boot/dts/sun4i-a10-mk802.dts b/arch/arm/boot/dts/sun4i-a10-mk802.dts
index 112f14aba3d1..7198b34e2e50 100644
--- a/arch/arm/boot/dts/sun4i-a10-mk802.dts
+++ b/arch/arm/boot/dts/sun4i-a10-mk802.dts
@@ -71,8 +71,6 @@
 };
 
 &mmc0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	cd-gpios = <&pio 7 1 GPIO_ACTIVE_HIGH>; /* PH1 */
diff --git a/arch/arm/boot/dts/sun4i-a10-mk802ii.dts b/arch/arm/boot/dts/sun4i-a10-mk802ii.dts
index e86e765070d4..e460da2eb139 100644
--- a/arch/arm/boot/dts/sun4i-a10-mk802ii.dts
+++ b/arch/arm/boot/dts/sun4i-a10-mk802ii.dts
@@ -67,8 +67,6 @@
 };
 
 &i2c0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c0_pins>;
 	status = "okay";
 
 	axp209: pmic at 34 {
@@ -82,8 +80,6 @@
 };
 
 &mmc0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	cd-gpios = <&pio 7 1 GPIO_ACTIVE_HIGH>; /* PH1 */
diff --git a/arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts b/arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts
index 855627142f32..3689b8c3b7a0 100644
--- a/arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts
+++ b/arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts
@@ -98,8 +98,6 @@
 };
 
 &emac {
-	pinctrl-names = "default";
-	pinctrl-0 = <&emac_pins>;
 	phy = <&phy1>;
 	status = "okay";
 };
@@ -109,8 +107,6 @@
 };
 
 &i2c0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c0_pins>;
 	status = "okay";
 
 	axp209: pmic at 34 {
@@ -124,8 +120,6 @@
 };
 
 &i2c1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c1_pins>;
 	status = "okay";
 
 	eeprom: eeprom at 50 {
@@ -144,8 +138,6 @@
 };
 
 &mmc0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	cd-gpios = <&pio 7 1 GPIO_ACTIVE_HIGH>; /* PH1 */
diff --git a/arch/arm/boot/dts/sun4i-a10-pcduino.dts b/arch/arm/boot/dts/sun4i-a10-pcduino.dts
index fc74c0924163..dbb310f65a6e 100644
--- a/arch/arm/boot/dts/sun4i-a10-pcduino.dts
+++ b/arch/arm/boot/dts/sun4i-a10-pcduino.dts
@@ -112,8 +112,6 @@
 };
 
 &emac {
-	pinctrl-names = "default";
-	pinctrl-0 = <&emac_pins>;
 	phy = <&phy1>;
 	status = "okay";
 };
@@ -123,8 +121,6 @@
 };
 
 &i2c0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c0_pins>;
 	status = "okay";
 
 	axp209: pmic at 34 {
@@ -142,8 +138,6 @@
 };
 
 &mmc0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	cd-gpios = <&pio 7 1 GPIO_ACTIVE_HIGH>; /* PH1 */
diff --git a/arch/arm/boot/dts/sun4i-a10-pov-protab2-ips9.dts b/arch/arm/boot/dts/sun4i-a10-pov-protab2-ips9.dts
index 660ea9ce6c01..46e485ff925b 100644
--- a/arch/arm/boot/dts/sun4i-a10-pov-protab2-ips9.dts
+++ b/arch/arm/boot/dts/sun4i-a10-pov-protab2-ips9.dts
@@ -83,8 +83,6 @@
 };
 
 &i2c0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c0_pins>;
 	status = "okay";
 
 	axp209: pmic at 34 {
@@ -96,15 +94,11 @@
 #include "axp209.dtsi"
 
 &i2c1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c1_pins>;
 	/* pull-ups and devices require AXP209 LDO3 */
 	status = "failed";
 };
 
 &i2c2 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c2_pins>;
 	status = "okay";
 
 	pixcir_ts at 5c {
@@ -142,8 +136,6 @@
 };
 
 &mmc0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	cd-gpios = <&pio 7 1 GPIO_ACTIVE_HIGH>; /* PH1 */
diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
index e6fed58ac364..eb5256685de0 100644
--- a/arch/arm/boot/dts/sun4i-a10.dtsi
+++ b/arch/arm/boot/dts/sun4i-a10.dtsi
@@ -266,6 +266,8 @@
 			dmas = <&dma SUN4I_DMA_DEDICATED 9>,
 			       <&dma SUN4I_DMA_DEDICATED 8>;
 			dma-names = "rx", "tx";
+			pinctrl-names = "default";
+			pinctrl-0 = <&spi1_pins>, <&spi1_cs0_pin>;
 			status = "disabled";
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -277,6 +279,8 @@
 			interrupts = <55>;
 			clocks = <&ccu CLK_AHB_EMAC>;
 			allwinner,sram = <&emac_sram 1>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&emac_pins>;
 			status = "disabled";
 		};
 
@@ -294,6 +298,8 @@
 			clocks = <&ccu CLK_AHB_MMC0>, <&ccu CLK_MMC0>;
 			clock-names = "ahb", "mmc";
 			interrupts = <32>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&mmc0_pins>;
 			status = "disabled";
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -812,6 +818,8 @@
 			reg = <0x01c2ac00 0x400>;
 			interrupts = <7>;
 			clocks = <&ccu CLK_APB1_I2C0>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&i2c0_pins>;
 			status = "disabled";
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -822,6 +830,8 @@
 			reg = <0x01c2b000 0x400>;
 			interrupts = <8>;
 			clocks = <&ccu CLK_APB1_I2C1>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&i2c1_pins>;
 			status = "disabled";
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -832,6 +842,8 @@
 			reg = <0x01c2b400 0x400>;
 			interrupts = <9>;
 			clocks = <&ccu CLK_APB1_I2C2>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&i2c2_pins>;
 			status = "disabled";
 			#address-cells = <1>;
 			#size-cells = <0>;
diff --git a/arch/arm/boot/dts/sunxi-itead-core-common.dtsi b/arch/arm/boot/dts/sunxi-itead-core-common.dtsi
index 2565d5137a17..ddf4e722ea93 100644
--- a/arch/arm/boot/dts/sunxi-itead-core-common.dtsi
+++ b/arch/arm/boot/dts/sunxi-itead-core-common.dtsi
@@ -65,8 +65,6 @@
 };
 
 &i2c0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c0_pins_a>;
 	status = "okay";
 
 	axp209: pmic at 34 {
@@ -75,8 +73,6 @@
 };
 
 &i2c1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c1_pins_a>;
 	status = "okay";
 };
 
-- 
git-series 0.9.1
