From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 27 Nov 2018 13:45:49 +0100
Subject: [PATCH 48/77] ARM: dts: sun7i: Provide default muxing for relevant
 controllers
In-Reply-To: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
References: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
Message-ID: <eb75e7a19abeba628cb8976882ace5587286ef93.1543321707.git-series.maxime.ripard@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The I2C and MMC controllers have only one muxing option in the SoC. In such a
case, we can just move the muxing into the DTSI, and remove it from
the DTS.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 arch/arm/boot/dts/sun7i-a20-bananapi-m1-plus.dts       |  6 +-----
 arch/arm/boot/dts/sun7i-a20-bananapi.dts               |  6 +-----
 arch/arm/boot/dts/sun7i-a20-bananapro.dts              |  8 +------
 arch/arm/boot/dts/sun7i-a20-cubieboard2.dts            |  6 +-----
 arch/arm/boot/dts/sun7i-a20-cubietruck.dts             |  9 +-------
 arch/arm/boot/dts/sun7i-a20-hummingbird.dts            | 12 +---------
 arch/arm/boot/dts/sun7i-a20-i12-tvbox.dts              |  6 +-----
 arch/arm/boot/dts/sun7i-a20-icnova-swac.dts            |  6 +-----
 arch/arm/boot/dts/sun7i-a20-itead-ibox.dts             |  2 +--
 arch/arm/boot/dts/sun7i-a20-lamobo-r1.dts              |  6 +-----
 arch/arm/boot/dts/sun7i-a20-m3.dts                     |  6 +-----
 arch/arm/boot/dts/sun7i-a20-mk808c.dts                 |  8 +------
 arch/arm/boot/dts/sun7i-a20-olimex-som-evb-emmc.dts    |  2 +--
 arch/arm/boot/dts/sun7i-a20-olimex-som-evb.dts         | 10 +--------
 arch/arm/boot/dts/sun7i-a20-olimex-som204-evb-emmc.dts |  2 +--
 arch/arm/boot/dts/sun7i-a20-olimex-som204-evb.dts      | 10 +--------
 arch/arm/boot/dts/sun7i-a20-olinuxino-lime.dts         |  6 +-----
 arch/arm/boot/dts/sun7i-a20-olinuxino-lime2-emmc.dts   |  2 +--
 arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts        |  6 +-----
 arch/arm/boot/dts/sun7i-a20-olinuxino-micro-emmc.dts   |  2 +--
 arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts        | 10 +--------
 arch/arm/boot/dts/sun7i-a20-orangepi-mini.dts          |  6 +-----
 arch/arm/boot/dts/sun7i-a20-orangepi.dts               |  4 +---
 arch/arm/boot/dts/sun7i-a20-pcduino3-nano.dts          |  4 +---
 arch/arm/boot/dts/sun7i-a20-pcduino3.dts               |  4 +---
 arch/arm/boot/dts/sun7i-a20-wexler-tab7200.dts         |  8 +------
 arch/arm/boot/dts/sun7i-a20-wits-pro-a20-dkt.dts       | 10 +--------
 arch/arm/boot/dts/sun7i-a20.dtsi                       | 14 +++++++++++-
 28 files changed, 14 insertions(+), 167 deletions(-)

diff --git a/arch/arm/boot/dts/sun7i-a20-bananapi-m1-plus.dts b/arch/arm/boot/dts/sun7i-a20-bananapi-m1-plus.dts
index af4418de57be..e2e540380c6e 100644
--- a/arch/arm/boot/dts/sun7i-a20-bananapi-m1-plus.dts
+++ b/arch/arm/boot/dts/sun7i-a20-bananapi-m1-plus.dts
@@ -150,8 +150,6 @@
 };
 
 &i2c0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c0_pins>;
 	status = "okay";
 
 	axp209: pmic at 34 {
@@ -174,8 +172,6 @@
 };
 
 &mmc0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	cd-gpios = <&pio 7 10 GPIO_ACTIVE_LOW>; /* PH10 */
@@ -185,8 +181,6 @@
 &mmc3 {
 	#address-cells = <1>;
 	#size-cells = <0>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc3_pins>;
 	vmmc-supply = <&reg_vcc3v3>;
 	mmc-pwrseq = <&mmc3_pwrseq>;
 	bus-width = <4>;
diff --git a/arch/arm/boot/dts/sun7i-a20-bananapi.dts b/arch/arm/boot/dts/sun7i-a20-bananapi.dts
index c14c517a35af..556b1b591c5d 100644
--- a/arch/arm/boot/dts/sun7i-a20-bananapi.dts
+++ b/arch/arm/boot/dts/sun7i-a20-bananapi.dts
@@ -152,8 +152,6 @@
 };
 
 &i2c0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c0_pins>;
 	status = "okay";
 
 	axp209: pmic at 34 {
@@ -164,8 +162,6 @@
 };
 
 &i2c2 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c2_pins>;
 	status = "okay";
 };
 
@@ -176,8 +172,6 @@
 };
 
 &mmc0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	cd-gpios = <&pio 7 10 GPIO_ACTIVE_LOW>; /* PH10 */
diff --git a/arch/arm/boot/dts/sun7i-a20-bananapro.dts b/arch/arm/boot/dts/sun7i-a20-bananapro.dts
index 567bf6d493f9..0176e9de0180 100644
--- a/arch/arm/boot/dts/sun7i-a20-bananapro.dts
+++ b/arch/arm/boot/dts/sun7i-a20-bananapro.dts
@@ -120,8 +120,6 @@
 };
 
 &i2c0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c0_pins>;
 	status = "okay";
 
 	axp209: pmic at 34 {
@@ -136,8 +134,6 @@
 };
 
 &i2c2 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c2_pins>;
 	status = "okay";
 };
 
@@ -148,8 +144,6 @@
 };
 
 &mmc0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	cd-gpios = <&pio 7 10 GPIO_ACTIVE_LOW>; /* PH10 */
@@ -157,8 +151,6 @@
 };
 
 &mmc3 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc3_pins>;
 	vmmc-supply = <&reg_vcc3v3>;
 	mmc-pwrseq = <&wifi_pwrseq>;
 	bus-width = <4>;
diff --git a/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts b/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts
index 2982d0521f06..200685b0b1cb 100644
--- a/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts
+++ b/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts
@@ -135,8 +135,6 @@
 };
 
 &i2c0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c0_pins>;
 	status = "okay";
 
 	axp209: pmic at 34 {
@@ -147,8 +145,6 @@
 };
 
 &i2c1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c1_pins>;
 	status = "okay";
 };
 
@@ -159,8 +155,6 @@
 };
 
 &mmc0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	cd-gpios = <&pio 7 1 GPIO_ACTIVE_LOW>; /* PH1 */
diff --git a/arch/arm/boot/dts/sun7i-a20-cubietruck.dts b/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
index 20069542336f..95da354cecb7 100644
--- a/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
+++ b/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
@@ -168,8 +168,6 @@
 };
 
 &i2c0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c0_pins>;
 	status = "okay";
 
 	axp209: pmic at 34 {
@@ -181,13 +179,10 @@
 
 &i2c1 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&i2c1_pins>;
 	status = "okay";
 };
 
 &i2c2 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c2_pins>;
 	status = "okay";
 };
 
@@ -198,8 +193,6 @@
 };
 
 &mmc0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	cd-gpios = <&pio 7 1 GPIO_ACTIVE_LOW>; /* PH1 */
@@ -207,8 +200,6 @@
 };
 
 &mmc3 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc3_pins>;
 	vmmc-supply = <&reg_vcc3v3>;
 	mmc-pwrseq = <&mmc3_pwrseq>;
 	bus-width = <4>;
diff --git a/arch/arm/boot/dts/sun7i-a20-hummingbird.dts b/arch/arm/boot/dts/sun7i-a20-hummingbird.dts
index a1af7d6726e2..fd0153f65685 100644
--- a/arch/arm/boot/dts/sun7i-a20-hummingbird.dts
+++ b/arch/arm/boot/dts/sun7i-a20-hummingbird.dts
@@ -116,8 +116,6 @@
 };
 
 &i2c0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c0_pins>;
 	status = "okay";
 
 	axp209: pmic at 34 {
@@ -131,20 +129,14 @@
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
 
 &i2c3 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c3_pins>;
 	status = "okay";
 };
 
@@ -155,8 +147,6 @@
 };
 
 &mmc0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins>;
 	vmmc-supply = <&reg_vcc3v0>;
 	bus-width = <4>;
 	cd-gpios = <&pio 7 1 GPIO_ACTIVE_LOW>; /* PH1 */
@@ -164,8 +154,6 @@
 };
 
 &mmc3 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc3_pins>;
 	vmmc-supply = <&reg_mmc3_vdd>;
 	bus-width = <4>;
 	non-removable;
diff --git a/arch/arm/boot/dts/sun7i-a20-i12-tvbox.dts b/arch/arm/boot/dts/sun7i-a20-i12-tvbox.dts
index db708332616e..6313d8a8a37c 100644
--- a/arch/arm/boot/dts/sun7i-a20-i12-tvbox.dts
+++ b/arch/arm/boot/dts/sun7i-a20-i12-tvbox.dts
@@ -126,8 +126,6 @@
 };
 
 &i2c0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c0_pins>;
 	status = "okay";
 
 	axp209: pmic at 34 {
@@ -148,8 +146,6 @@
 };
 
 &mmc0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	cd-gpios = <&pio 7 1 GPIO_ACTIVE_LOW>; /* PH1 */
@@ -157,8 +153,6 @@
 };
 
 &mmc3 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc3_pins>;
 	vmmc-supply = <&reg_vmmc3>;
 	bus-width = <4>;
 	non-removable;
diff --git a/arch/arm/boot/dts/sun7i-a20-icnova-swac.dts b/arch/arm/boot/dts/sun7i-a20-icnova-swac.dts
index 0bf70b22bac4..949494730aee 100644
--- a/arch/arm/boot/dts/sun7i-a20-icnova-swac.dts
+++ b/arch/arm/boot/dts/sun7i-a20-icnova-swac.dts
@@ -85,8 +85,6 @@
 };
 
 &i2c0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c0_pins>;
 	status = "okay";
 
 	axp209: pmic at 34 {
@@ -97,14 +95,10 @@
 };
 
 &i2c1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c1_pins>;
 	status = "okay";
 };
 
 &mmc0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	cd-gpios = <&pio 8 5 GPIO_ACTIVE_LOW>; /* PI5 */
diff --git a/arch/arm/boot/dts/sun7i-a20-itead-ibox.dts b/arch/arm/boot/dts/sun7i-a20-itead-ibox.dts
index 2bd4f281f31a..b90a7607d069 100644
--- a/arch/arm/boot/dts/sun7i-a20-itead-ibox.dts
+++ b/arch/arm/boot/dts/sun7i-a20-itead-ibox.dts
@@ -120,8 +120,6 @@
 };
 
 &mmc0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	cd-gpios = <&pio 7 1 GPIO_ACTIVE_LOW>; /* PH1 */
diff --git a/arch/arm/boot/dts/sun7i-a20-lamobo-r1.dts b/arch/arm/boot/dts/sun7i-a20-lamobo-r1.dts
index 3d4cd05813e8..6f8dfa717994 100644
--- a/arch/arm/boot/dts/sun7i-a20-lamobo-r1.dts
+++ b/arch/arm/boot/dts/sun7i-a20-lamobo-r1.dts
@@ -195,8 +195,6 @@
 };
 
 &i2c0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c0_pins>;
 	status = "okay";
 
 	axp209: pmic at 34 {
@@ -207,8 +205,6 @@
 };
 
 &i2c2 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c2_pins>;
 	status = "okay";
 };
 
@@ -219,8 +215,6 @@
 };
 
 &mmc0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	cd-gpios = <&pio 7 10 GPIO_ACTIVE_LOW>; /* PH10 */
diff --git a/arch/arm/boot/dts/sun7i-a20-m3.dts b/arch/arm/boot/dts/sun7i-a20-m3.dts
index 1207e0d897b7..b8a1aaaf3976 100644
--- a/arch/arm/boot/dts/sun7i-a20-m3.dts
+++ b/arch/arm/boot/dts/sun7i-a20-m3.dts
@@ -92,8 +92,6 @@
 };
 
 &i2c0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c0_pins>;
 	status = "okay";
 
 	axp209: pmic at 34 {
@@ -114,8 +112,6 @@
 };
 
 &mmc0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	cd-gpios = <&pio 7 1 GPIO_ACTIVE_LOW>; /* PH1 */
@@ -123,8 +119,6 @@
 };
 
 &mmc2 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc2_pins>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	non-removable;
diff --git a/arch/arm/boot/dts/sun7i-a20-mk808c.dts b/arch/arm/boot/dts/sun7i-a20-mk808c.dts
index b4143a91086b..1491c603f661 100644
--- a/arch/arm/boot/dts/sun7i-a20-mk808c.dts
+++ b/arch/arm/boot/dts/sun7i-a20-mk808c.dts
@@ -106,8 +106,6 @@
 };
 
 &i2c0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c0_pins>;
 	status = "okay";
 
 	axp209: pmic at 34 {
@@ -121,20 +119,14 @@
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
 
 &mmc0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins>;
 	vmmc-supply = <&reg_vcc3v0>;
 	bus-width = <4>;
 	cd-gpios = <&pio 7 1 GPIO_ACTIVE_LOW>; /* PH1 */
diff --git a/arch/arm/boot/dts/sun7i-a20-olimex-som-evb-emmc.dts b/arch/arm/boot/dts/sun7i-a20-olimex-som-evb-emmc.dts
index ea0d620119cb..20bf09b2226c 100644
--- a/arch/arm/boot/dts/sun7i-a20-olimex-som-evb-emmc.dts
+++ b/arch/arm/boot/dts/sun7i-a20-olimex-som-evb-emmc.dts
@@ -21,8 +21,6 @@
 };
 
 &mmc2 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc2_pins>;
 	vmmc-supply = <&reg_vcc3v3>;
 	mmc-pwrseq = <&mmc2_pwrseq>;
 	bus-width = <4>;
diff --git a/arch/arm/boot/dts/sun7i-a20-olimex-som-evb.dts b/arch/arm/boot/dts/sun7i-a20-olimex-som-evb.dts
index cf3a61eed691..f0e6a96e5785 100644
--- a/arch/arm/boot/dts/sun7i-a20-olimex-som-evb.dts
+++ b/arch/arm/boot/dts/sun7i-a20-olimex-som-evb.dts
@@ -131,8 +131,6 @@
 };
 
 &i2c0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c0_pins>;
 	status = "okay";
 
 	axp209: pmic at 34 {
@@ -143,14 +141,10 @@
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
 
@@ -209,8 +203,6 @@
 };
 
 &mmc0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	cd-gpios = <&pio 7 1 GPIO_ACTIVE_LOW>; /* PH1 */
@@ -218,8 +210,6 @@
 };
 
 &mmc3 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc3_pins>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	cd-gpios = <&pio 7 0 GPIO_ACTIVE_LOW>; /* PH0 */
diff --git a/arch/arm/boot/dts/sun7i-a20-olimex-som204-evb-emmc.dts b/arch/arm/boot/dts/sun7i-a20-olimex-som204-evb-emmc.dts
index 093cd32c9a1c..a59755a2e7a9 100644
--- a/arch/arm/boot/dts/sun7i-a20-olimex-som204-evb-emmc.dts
+++ b/arch/arm/boot/dts/sun7i-a20-olimex-som204-evb-emmc.dts
@@ -20,8 +20,6 @@
 };
 
 &mmc2 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc2_pins>;
 	vmmc-supply = <&reg_vcc3v3>;
 	mmc-pwrseq = <&mmc2_pwrseq>;
 	bus-width = <4>;
diff --git a/arch/arm/boot/dts/sun7i-a20-olimex-som204-evb.dts b/arch/arm/boot/dts/sun7i-a20-olimex-som204-evb.dts
index 249bb57d50e0..823aabce0462 100644
--- a/arch/arm/boot/dts/sun7i-a20-olimex-som204-evb.dts
+++ b/arch/arm/boot/dts/sun7i-a20-olimex-som204-evb.dts
@@ -130,8 +130,6 @@
 };
 
 &i2c0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c0_pins>;
 	status = "okay";
 
 	axp209: pmic at 34 {
@@ -143,8 +141,6 @@
 
 /* Exposed to UEXT1 */
 &i2c1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c1_pins>;
 	status = "okay";
 
 	eeprom: eeprom at 50 {
@@ -156,8 +152,6 @@
 
 /* Exposed to UEXT2 */
 &i2c2 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c2_pins>;
 	status = "okay";
 };
 
@@ -168,8 +162,6 @@
 };
 
 &mmc0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	cd-gpios = <&pio 7 1 GPIO_ACTIVE_LOW>;
@@ -177,8 +169,6 @@
 };
 
 &mmc3 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc3_pins>;
 	vmmc-supply = <&reg_vcc3v3>;
 	mmc-pwrseq = <&rtl_pwrseq>;
 	bus-width = <4>;
diff --git a/arch/arm/boot/dts/sun7i-a20-olinuxino-lime.dts b/arch/arm/boot/dts/sun7i-a20-olinuxino-lime.dts
index 454b0c433e75..5e411194bf62 100644
--- a/arch/arm/boot/dts/sun7i-a20-olinuxino-lime.dts
+++ b/arch/arm/boot/dts/sun7i-a20-olinuxino-lime.dts
@@ -126,8 +126,6 @@
 };
 
 &i2c0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c0_pins>;
 	status = "okay";
 
 	axp209: pmic at 34 {
@@ -142,8 +140,6 @@
 };
 
 &i2c1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c1_pins>;
 	status = "okay";
 
 	eeprom: eeprom at 50 {
@@ -154,8 +150,6 @@
 };
 
 &mmc0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	cd-gpios = <&pio 7 1 GPIO_ACTIVE_LOW>; /* PH1 */
diff --git a/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2-emmc.dts b/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2-emmc.dts
index 0a2a26f9a5fb..decb014a382b 100644
--- a/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2-emmc.dts
+++ b/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2-emmc.dts
@@ -54,8 +54,6 @@
 };
 
 &mmc2 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc2_pins>;
 	vmmc-supply = <&reg_vcc3v3>;
 	vqmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
diff --git a/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts b/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
index 0a8e243d8e7b..55c9086e9344 100644
--- a/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
+++ b/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
@@ -131,8 +131,6 @@
 };
 
 &i2c0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c0_pins>;
 	status = "okay";
 
 	axp209: pmic at 34 {
@@ -143,8 +141,6 @@
 };
 
 &i2c1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c1_pins>;
 	status = "okay";
 
 	eeprom: eeprom at 50 {
@@ -159,8 +155,6 @@
 };
 
 &mmc0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	cd-gpios = <&pio 7 1 GPIO_ACTIVE_LOW>; /* PH1 */
diff --git a/arch/arm/boot/dts/sun7i-a20-olinuxino-micro-emmc.dts b/arch/arm/boot/dts/sun7i-a20-olinuxino-micro-emmc.dts
index 58fd3519ab7d..2337b44a88aa 100644
--- a/arch/arm/boot/dts/sun7i-a20-olinuxino-micro-emmc.dts
+++ b/arch/arm/boot/dts/sun7i-a20-olinuxino-micro-emmc.dts
@@ -54,8 +54,6 @@
 };
 
 &mmc2 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc2_pins>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	non-removable;
diff --git a/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts b/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
index 718b5209643b..840ae1194a66 100644
--- a/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
+++ b/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
@@ -138,8 +138,6 @@
 };
 
 &i2c0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c0_pins>;
 	status = "okay";
 
 	axp209: pmic at 34 {
@@ -150,8 +148,6 @@
 };
 
 &i2c1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c1_pins>;
 	status = "okay";
 
 	eeprom: eeprom at 50 {
@@ -162,8 +158,6 @@
 };
 
 &i2c2 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c2_pins>;
 	status = "okay";
 };
 
@@ -222,8 +216,6 @@
 };
 
 &mmc0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	cd-gpios = <&pio 7 1 GPIO_ACTIVE_LOW>; /* PH1 */
@@ -231,8 +223,6 @@
 };
 
 &mmc3 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc3_pins>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	cd-gpios = <&pio 7 11 GPIO_ACTIVE_LOW>; /* PH11 */
diff --git a/arch/arm/boot/dts/sun7i-a20-orangepi-mini.dts b/arch/arm/boot/dts/sun7i-a20-orangepi-mini.dts
index ddb713209bb2..15881081cac4 100644
--- a/arch/arm/boot/dts/sun7i-a20-orangepi-mini.dts
+++ b/arch/arm/boot/dts/sun7i-a20-orangepi-mini.dts
@@ -141,8 +141,6 @@
 };
 
 &i2c0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c0_pins>;
 	status = "okay";
 
 	axp209: pmic at 34 {
@@ -161,8 +159,6 @@
 };
 
 &mmc0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	cd-gpios = <&pio 7 10 GPIO_ACTIVE_LOW>; /* PH10 */
@@ -170,8 +166,6 @@
 };
 
 &mmc3 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc3_pins>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	cd-gpios = <&pio 7 11 GPIO_ACTIVE_LOW>; /* PH11 */
diff --git a/arch/arm/boot/dts/sun7i-a20-orangepi.dts b/arch/arm/boot/dts/sun7i-a20-orangepi.dts
index d35705345c10..d64de2e73a9f 100644
--- a/arch/arm/boot/dts/sun7i-a20-orangepi.dts
+++ b/arch/arm/boot/dts/sun7i-a20-orangepi.dts
@@ -107,8 +107,6 @@
 };
 
 &i2c0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c0_pins>;
 	status = "okay";
 
 	axp209: pmic at 34 {
@@ -127,8 +125,6 @@
 };
 
 &mmc0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	cd-gpios = <&pio 7 10 GPIO_ACTIVE_LOW>; /* PH10 */
diff --git a/arch/arm/boot/dts/sun7i-a20-pcduino3-nano.dts b/arch/arm/boot/dts/sun7i-a20-pcduino3-nano.dts
index 6e64315d1a8b..538ea15fa32f 100644
--- a/arch/arm/boot/dts/sun7i-a20-pcduino3-nano.dts
+++ b/arch/arm/boot/dts/sun7i-a20-pcduino3-nano.dts
@@ -134,8 +134,6 @@
 };
 
 &i2c0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c0_pins>;
 	status = "okay";
 
 	axp209: pmic at 34 {
@@ -152,8 +150,6 @@
 };
 
 &mmc0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	cd-gpios = <&pio 7 1 GPIO_ACTIVE_LOW>; /* PH1 */
diff --git a/arch/arm/boot/dts/sun7i-a20-pcduino3.dts b/arch/arm/boot/dts/sun7i-a20-pcduino3.dts
index b6a9cef86c31..a72ed4318d04 100644
--- a/arch/arm/boot/dts/sun7i-a20-pcduino3.dts
+++ b/arch/arm/boot/dts/sun7i-a20-pcduino3.dts
@@ -132,8 +132,6 @@
 };
 
 &i2c0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c0_pins>;
 	status = "okay";
 
 	axp209: pmic at 34 {
@@ -152,8 +150,6 @@
 };
 
 &mmc0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	cd-gpios = <&pio 7 1 GPIO_ACTIVE_LOW>; /* PH1 */
diff --git a/arch/arm/boot/dts/sun7i-a20-wexler-tab7200.dts b/arch/arm/boot/dts/sun7i-a20-wexler-tab7200.dts
index 3b1fc4cb61d3..ffade253d129 100644
--- a/arch/arm/boot/dts/sun7i-a20-wexler-tab7200.dts
+++ b/arch/arm/boot/dts/sun7i-a20-wexler-tab7200.dts
@@ -89,8 +89,6 @@
 };
 
 &i2c0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c0_pins>;
 	status = "okay";
 
 	axp209: pmic at 34 {
@@ -103,14 +101,10 @@
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
 
 	gt911: touchscreen at 5d {
@@ -144,8 +138,6 @@
 };
 
 &mmc0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	cd-gpios = <&pio 7 1 GPIO_ACTIVE_LOW>; /* PH1 */
diff --git a/arch/arm/boot/dts/sun7i-a20-wits-pro-a20-dkt.dts b/arch/arm/boot/dts/sun7i-a20-wits-pro-a20-dkt.dts
index ae4febdea552..c27e56091fb1 100644
--- a/arch/arm/boot/dts/sun7i-a20-wits-pro-a20-dkt.dts
+++ b/arch/arm/boot/dts/sun7i-a20-wits-pro-a20-dkt.dts
@@ -91,8 +91,6 @@
 };
 
 &i2c0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c0_pins>;
 	status = "okay";
 
 	axp209: pmic at 34 {
@@ -103,22 +101,16 @@
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
 
 #include "axp209.dtsi"
 
 &mmc0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	cd-gpios = <&pio 7 1 GPIO_ACTIVE_LOW>; /* PH1 */
@@ -126,8 +118,6 @@
 };
 
 &mmc3 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc3_pins>;
 	vmmc-supply = <&reg_vcc3v3>;
 	mmc-pwrseq = <&mmc3_pwrseq>;
 	bus-width = <4>;
diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index 1b247369ec86..86158528ed93 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -514,6 +514,8 @@
 				      "output",
 				      "sample";
 			interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&mmc0_pins>;
 			status = "disabled";
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -548,6 +550,8 @@
 				      "output",
 				      "sample";
 			interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&mmc2_pins>;
 			status = "disabled";
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -565,6 +569,8 @@
 				      "output",
 				      "sample";
 			interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&mmc3_pins>;
 			status = "disabled";
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -1218,6 +1224,8 @@
 			reg = <0x01c2ac00 0x400>;
 			interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&ccu CLK_APB1_I2C0>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&i2c0_pins>;
 			status = "disabled";
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -1229,6 +1237,8 @@
 			reg = <0x01c2b000 0x400>;
 			interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&ccu CLK_APB1_I2C1>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&i2c1_pins>;
 			status = "disabled";
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -1240,6 +1250,8 @@
 			reg = <0x01c2b400 0x400>;
 			interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&ccu CLK_APB1_I2C2>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&i2c2_pins>;
 			status = "disabled";
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -1251,6 +1263,8 @@
 			reg = <0x01c2b800 0x400>;
 			interrupts = <GIC_SPI 88 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&ccu CLK_APB1_I2C3>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&i2c3_pins>;
 			status = "disabled";
 			#address-cells = <1>;
 			#size-cells = <0>;
-- 
git-series 0.9.1
