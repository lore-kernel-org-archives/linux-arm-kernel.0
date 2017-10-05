From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu,  5 Oct 2017 12:49:41 +0200
Subject: [PATCH 06/20] ARM: dts: sun4i: Provide default muxing for relevant
 controllers
In-Reply-To: <cover.f5f905a5434f2a540d6844d23369a04af9f5314c.1507198895.git-series.maxime.ripard@free-electrons.com>
References: <cover.f5f905a5434f2a540d6844d23369a04af9f5314c.1507198895.git-series.maxime.ripard@free-electrons.com>
Message-ID: <8244ddae868d0cff052daf52e7687bd3e85f7437.1507198895.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some controllers have only one muxing option in the SoC. In such a case, we
can just move the muxing into the DTSI, and remove it from the DTS.

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
index 1c12846227be..69513f341a8e 100644
--- a/arch/arm/boot/dts/sun4i-a10-a1000.dts
+++ b/arch/arm/boot/dts/sun4i-a10-a1000.dts
@@ -129,8 +129,6 @@
 };
 
 &emac {
-	pinctrl-names = "default";
-	pinctrl-0 = <&emac_pins>;
 	phy = <&phy1>;
 	status = "okay";
 };
@@ -140,8 +138,6 @@
 };
 
 &i2c0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c0_pins>;
 	status = "okay";
 
 	axp209: pmic at 34 {
@@ -170,8 +166,6 @@
 };
 
 &mmc0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	cd-gpios = <&pio 7 1 GPIO_ACTIVE_HIGH>; /* PH1 */
diff --git a/arch/arm/boot/dts/sun4i-a10-ba10-tvbox.dts b/arch/arm/boot/dts/sun4i-a10-ba10-tvbox.dts
index 58fe2fc14f32..f18c832d4e16 100644
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
index b34944188772..4978e46ca620 100644
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
index a103b36f59a9..92e5a772a93f 100644
--- a/arch/arm/boot/dts/sun4i-a10-dserve-dsrv9703c.dts
+++ b/arch/arm/boot/dts/sun4i-a10-dserve-dsrv9703c.dts
@@ -105,8 +105,6 @@
 };
 
 &i2c0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c0_pins>;
 	status = "okay";
 
 	axp209: pmic at 34 {
@@ -118,15 +116,11 @@
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
@@ -162,8 +156,6 @@
 };
 
 &mmc0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	cd-gpios = <&pio 7 1 GPIO_ACTIVE_HIGH>; /* PH1 */
diff --git a/arch/arm/boot/dts/sun4i-a10-gemei-g9.dts b/arch/arm/boot/dts/sun4i-a10-gemei-g9.dts
index deb80dd003a3..e92074c6d894 100644
--- a/arch/arm/boot/dts/sun4i-a10-gemei-g9.dts
+++ b/arch/arm/boot/dts/sun4i-a10-gemei-g9.dts
@@ -91,8 +91,6 @@
 };
 
 &i2c0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c0_pins>;
 	status = "okay";
 
 	axp209: pmic at 34 {
@@ -104,8 +102,6 @@
 #include "axp209.dtsi"
 
 &i2c1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c1_pins>;
 	status = "okay";
 
 	/* Accelerometer */
@@ -145,8 +141,6 @@
 };
 
 &mmc0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	cd-gpios = <&pio 7 1 GPIO_ACTIVE_HIGH>; /* PH01 */
diff --git a/arch/arm/boot/dts/sun4i-a10-hackberry.dts b/arch/arm/boot/dts/sun4i-a10-hackberry.dts
index 3d3a6a6ca566..d6ae111d8cd1 100644
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
index f91ca46089af..016ec3e1889f 100644
--- a/arch/arm/boot/dts/sun4i-a10-inet1.dts
+++ b/arch/arm/boot/dts/sun4i-a10-inet1.dts
@@ -88,8 +88,6 @@
 };
 
 &i2c0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c0_pins>;
 	status = "okay";
 
 	axp209: pmic at 34 {
@@ -101,8 +99,6 @@
 #include "axp209.dtsi"
 
 &i2c1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c1_pins>;
 	status = "okay";
 
 	/* Accelerometer */
@@ -115,8 +111,6 @@
 };
 
 &i2c2 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c2_pins>;
 	status = "okay";
 
 	ft5x: touchscreen at 38 {
@@ -160,8 +154,6 @@
 };
 
 &mmc0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	cd-gpios = <&pio 7 1 GPIO_ACTIVE_HIGH>; /* PH1 */
diff --git a/arch/arm/boot/dts/sun4i-a10-inet97fv2.dts b/arch/arm/boot/dts/sun4i-a10-inet97fv2.dts
index 8f57832289f3..8250c720883e 100644
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
index 71f22daefbdc..98e13cba1714 100644
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
index dcf1dd4fc90c..86f779bd9648 100644
--- a/arch/arm/boot/dts/sun4i-a10-jesurun-q5.dts
+++ b/arch/arm/boot/dts/sun4i-a10-jesurun-q5.dts
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
@@ -139,8 +135,6 @@
 };
 
 &mmc0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	cd-gpios = <&pio 7 1 GPIO_ACTIVE_HIGH>; /* PH1 */
diff --git a/arch/arm/boot/dts/sun4i-a10-marsboard.dts b/arch/arm/boot/dts/sun4i-a10-marsboard.dts
index 243f58f4323b..d9af1042b045 100644
--- a/arch/arm/boot/dts/sun4i-a10-marsboard.dts
+++ b/arch/arm/boot/dts/sun4i-a10-marsboard.dts
@@ -107,27 +107,19 @@
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
 
@@ -140,8 +132,6 @@
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
index 57ee332c560f..b8d1501ef7e6 100644
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
index b49f1f503f69..45df067cb35f 100644
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
index f50f0ff00537..d19e0ddfe353 100644
--- a/arch/arm/boot/dts/sun4i-a10-pcduino.dts
+++ b/arch/arm/boot/dts/sun4i-a10-pcduino.dts
@@ -116,8 +116,6 @@
 };
 
 &emac {
-	pinctrl-names = "default";
-	pinctrl-0 = <&emac_pins>;
 	phy = <&phy1>;
 	status = "okay";
 };
@@ -127,8 +125,6 @@
 };
 
 &i2c0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c0_pins>;
 	status = "okay";
 
 	axp209: pmic at 34 {
@@ -146,8 +142,6 @@
 };
 
 &mmc0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	cd-gpios = <&pio 7 1 GPIO_ACTIVE_HIGH>; /* PH1 */
diff --git a/arch/arm/boot/dts/sun4i-a10-pov-protab2-ips9.dts b/arch/arm/boot/dts/sun4i-a10-pov-protab2-ips9.dts
index 65a149087e5f..654a2de3414b 100644
--- a/arch/arm/boot/dts/sun4i-a10-pov-protab2-ips9.dts
+++ b/arch/arm/boot/dts/sun4i-a10-pov-protab2-ips9.dts
@@ -87,8 +87,6 @@
 };
 
 &i2c0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c0_pins>;
 	status = "okay";
 
 	axp209: pmic at 34 {
@@ -100,15 +98,11 @@
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
@@ -148,8 +142,6 @@
 };
 
 &mmc0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	cd-gpios = <&pio 7 1 GPIO_ACTIVE_HIGH>; /* PH1 */
diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
index b6e89de4c092..1876abb62ec7 100644
--- a/arch/arm/boot/dts/sun4i-a10.dtsi
+++ b/arch/arm/boot/dts/sun4i-a10.dtsi
@@ -270,6 +270,8 @@
 			dmas = <&dma SUN4I_DMA_DEDICATED 9>,
 			       <&dma SUN4I_DMA_DEDICATED 8>;
 			dma-names = "rx", "tx";
+			pinctrl-names = "default";
+			pinctrl-0 = <&spi1_pins>, <&spi1_cs0_pin>;
 			status = "disabled";
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -281,6 +283,8 @@
 			interrupts = <55>;
 			clocks = <&ccu CLK_AHB_EMAC>;
 			allwinner,sram = <&emac_sram 1>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&emac_pins>;
 			status = "disabled";
 		};
 
@@ -298,6 +302,8 @@
 			clocks = <&ccu CLK_AHB_MMC0>, <&ccu CLK_MMC0>;
 			clock-names = "ahb", "mmc";
 			interrupts = <32>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&mmc0_pins>;
 			status = "disabled";
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -816,6 +822,8 @@
 			reg = <0x01c2ac00 0x400>;
 			interrupts = <7>;
 			clocks = <&ccu CLK_APB1_I2C0>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&i2c0_pins>;
 			status = "disabled";
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -826,6 +834,8 @@
 			reg = <0x01c2b000 0x400>;
 			interrupts = <8>;
 			clocks = <&ccu CLK_APB1_I2C1>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&i2c1_pins>;
 			status = "disabled";
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -836,6 +846,8 @@
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
