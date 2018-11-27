From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 27 Nov 2018 13:45:44 +0100
Subject: [PATCH 43/77] ARM: dts: sun7i: Change pinctrl nodes to avoid warning
In-Reply-To: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
References: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
Message-ID: <957b3c14ba05e6658aa767466d9c76b037723ce7.1543321707.git-series.maxime.ripard@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All our pinctrl nodes were using a node name convention with a unit-address
to differentiate the different muxing options. However, since those nodes
didn't have a reg property, they were generating warnings in DTC.

In order to accomodate for this, convert the old nodes to the syntax we've
been using for the new SoCs, including removing the letter suffix of the
node labels to the bank of those pins to make things more readable.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 arch/arm/boot/dts/sun7i-a20-bananapi-m1-plus.dts       | 14 +-
 arch/arm/boot/dts/sun7i-a20-bananapi.dts               | 22 +--
 arch/arm/boot/dts/sun7i-a20-bananapro.dts              | 24 +--
 arch/arm/boot/dts/sun7i-a20-cubieboard2.dts            | 12 +-
 arch/arm/boot/dts/sun7i-a20-cubietruck.dts             | 22 +--
 arch/arm/boot/dts/sun7i-a20-hummingbird.dts            | 32 ++--
 arch/arm/boot/dts/sun7i-a20-i12-tvbox.dts              | 14 +-
 arch/arm/boot/dts/sun7i-a20-icnova-swac.dts            | 10 +-
 arch/arm/boot/dts/sun7i-a20-itead-ibox.dts             |  8 +-
 arch/arm/boot/dts/sun7i-a20-lamobo-r1.dts              | 22 +--
 arch/arm/boot/dts/sun7i-a20-m3.dts                     | 12 +-
 arch/arm/boot/dts/sun7i-a20-mk808c.dts                 | 12 +-
 arch/arm/boot/dts/sun7i-a20-olimex-som-evb-emmc.dts    |  2 +-
 arch/arm/boot/dts/sun7i-a20-olimex-som-evb.dts         | 26 +--
 arch/arm/boot/dts/sun7i-a20-olimex-som204-evb-emmc.dts |  2 +-
 arch/arm/boot/dts/sun7i-a20-olimex-som204-evb.dts      | 30 ++--
 arch/arm/boot/dts/sun7i-a20-olinuxino-lime.dts         | 10 +-
 arch/arm/boot/dts/sun7i-a20-olinuxino-lime2-emmc.dts   |  2 +-
 arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts        | 10 +-
 arch/arm/boot/dts/sun7i-a20-olinuxino-micro-emmc.dts   |  2 +-
 arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts        | 26 +--
 arch/arm/boot/dts/sun7i-a20-orangepi-mini.dts          | 12 +-
 arch/arm/boot/dts/sun7i-a20-orangepi.dts               | 10 +-
 arch/arm/boot/dts/sun7i-a20-pcduino3-nano.dts          | 10 +-
 arch/arm/boot/dts/sun7i-a20-pcduino3.dts               | 10 +-
 arch/arm/boot/dts/sun7i-a20-wexler-tab7200.dts         | 12 +-
 arch/arm/boot/dts/sun7i-a20-wits-pro-a20-dkt.dts       | 14 +-
 arch/arm/boot/dts/sun7i-a20.dtsi                       | 88 +++++------
 arch/arm/boot/dts/sunxi-itead-core-common.dtsi         |  2 +-
 29 files changed, 236 insertions(+), 236 deletions(-)

diff --git a/arch/arm/boot/dts/sun7i-a20-bananapi-m1-plus.dts b/arch/arm/boot/dts/sun7i-a20-bananapi-m1-plus.dts
index ccd7b313448e..af4418de57be 100644
--- a/arch/arm/boot/dts/sun7i-a20-bananapi-m1-plus.dts
+++ b/arch/arm/boot/dts/sun7i-a20-bananapi-m1-plus.dts
@@ -128,7 +128,7 @@
 
 &gmac {
 	pinctrl-names = "default";
-	pinctrl-0 = <&gmac_pins_rgmii_a>;
+	pinctrl-0 = <&gmac_rgmii_pins>;
 	phy = <&phy1>;
 	phy-mode = "rgmii";
 	phy-supply = <&reg_gmac_3v3>;
@@ -151,7 +151,7 @@
 
 &i2c0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&i2c0_pins_a>;
+	pinctrl-0 = <&i2c0_pins>;
 	status = "okay";
 
 	axp209: pmic at 34 {
@@ -169,13 +169,13 @@
 
 &ir0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&ir0_rx_pins_a>;
+	pinctrl-0 = <&ir0_rx_pin>;
 	status = "okay";
 };
 
 &mmc0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins_a>;
+	pinctrl-0 = <&mmc0_pins>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	cd-gpios = <&pio 7 10 GPIO_ACTIVE_LOW>; /* PH10 */
@@ -186,7 +186,7 @@
 	#address-cells = <1>;
 	#size-cells = <0>;
 	pinctrl-names = "default";
-	pinctrl-0 = <&mmc3_pins_a>;
+	pinctrl-0 = <&mmc3_pins>;
 	vmmc-supply = <&reg_vcc3v3>;
 	mmc-pwrseq = <&mmc3_pwrseq>;
 	bus-width = <4>;
@@ -203,7 +203,7 @@
 	};
 };
 
-&mmc3_pins_a {
+&mmc3_pins {
 	/* AP6210 requires pull-up */
 	bias-pull-up;
 };
@@ -251,7 +251,7 @@
 
 &uart0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&uart0_pins_a>;
+	pinctrl-0 = <&uart0_pb_pins>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun7i-a20-bananapi.dts b/arch/arm/boot/dts/sun7i-a20-bananapi.dts
index 339c48a477f5..af56ae95c63f 100644
--- a/arch/arm/boot/dts/sun7i-a20-bananapi.dts
+++ b/arch/arm/boot/dts/sun7i-a20-bananapi.dts
@@ -130,7 +130,7 @@
 
 &gmac {
 	pinctrl-names = "default";
-	pinctrl-0 = <&gmac_pins_rgmii_a>;
+	pinctrl-0 = <&gmac_rgmii_pins>;
 	phy = <&phy1>;
 	phy-mode = "rgmii";
 	phy-supply = <&reg_gmac_3v3>;
@@ -153,7 +153,7 @@
 
 &i2c0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&i2c0_pins_a>;
+	pinctrl-0 = <&i2c0_pins>;
 	status = "okay";
 
 	axp209: pmic at 34 {
@@ -165,19 +165,19 @@
 
 &i2c2 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&i2c2_pins_a>;
+	pinctrl-0 = <&i2c2_pins>;
 	status = "okay";
 };
 
 &ir0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&ir0_rx_pins_a>;
+	pinctrl-0 = <&ir0_rx_pin>;
 	status = "okay";
 };
 
 &mmc0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins_a>;
+	pinctrl-0 = <&mmc0_pins>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	cd-gpios = <&pio 7 10 GPIO_ACTIVE_LOW>; /* PH10 */
@@ -296,27 +296,27 @@
 
 &spi0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&spi0_pins_a>,
-		    <&spi0_cs0_pins_a>,
-		    <&spi0_cs1_pins_a>;
+	pinctrl-0 = <&spi0_pi_pins>,
+		    <&spi0_cs0_pi_pin>,
+		    <&spi0_cs1_pi_pin>;
 	status = "okay";
 };
 
 &uart0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&uart0_pins_a>;
+	pinctrl-0 = <&uart0_pb_pins>;
 	status = "okay";
 };
 
 &uart3 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&uart3_pins_b>;
+	pinctrl-0 = <&uart3_ph_pins>;
 	status = "okay";
 };
 
 &uart7 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&uart7_pins_a>;
+	pinctrl-0 = <&uart7_pi_pins>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun7i-a20-bananapro.dts b/arch/arm/boot/dts/sun7i-a20-bananapro.dts
index a4c0a38e1262..567bf6d493f9 100644
--- a/arch/arm/boot/dts/sun7i-a20-bananapro.dts
+++ b/arch/arm/boot/dts/sun7i-a20-bananapro.dts
@@ -108,7 +108,7 @@
 
 &gmac {
 	pinctrl-names = "default";
-	pinctrl-0 = <&gmac_pins_rgmii_a>;
+	pinctrl-0 = <&gmac_rgmii_pins>;
 	phy = <&phy1>;
 	phy-mode = "rgmii";
 	phy-supply = <&reg_gmac_3v3>;
@@ -121,7 +121,7 @@
 
 &i2c0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&i2c0_pins_a>;
+	pinctrl-0 = <&i2c0_pins>;
 	status = "okay";
 
 	axp209: pmic at 34 {
@@ -137,19 +137,19 @@
 
 &i2c2 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&i2c2_pins_a>;
+	pinctrl-0 = <&i2c2_pins>;
 	status = "okay";
 };
 
 &ir0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&ir0_rx_pins_a>;
+	pinctrl-0 = <&ir0_rx_pin>;
 	status = "okay";
 };
 
 &mmc0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins_a>;
+	pinctrl-0 = <&mmc0_pins>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	cd-gpios = <&pio 7 10 GPIO_ACTIVE_LOW>; /* PH10 */
@@ -158,7 +158,7 @@
 
 &mmc3 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&mmc3_pins_a>;
+	pinctrl-0 = <&mmc3_pins>;
 	vmmc-supply = <&reg_vcc3v3>;
 	mmc-pwrseq = <&wifi_pwrseq>;
 	bus-width = <4>;
@@ -194,27 +194,27 @@
 
 &spi0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&spi0_pins_a>,
-		    <&spi0_cs0_pins_a>,
-		    <&spi0_cs1_pins_a>;
+	pinctrl-0 = <&spi0_pi_pins>,
+		    <&spi0_cs0_pi_pin>,
+		    <&spi0_cs1_pi_pin>;
 	status = "okay";
 };
 
 &uart0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&uart0_pins_a>;
+	pinctrl-0 = <&uart0_pb_pins>;
 	status = "okay";
 };
 
 &uart4 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&uart4_pins_b>;
+	pinctrl-0 = <&uart4_ph_pins>;
 	status = "okay";
 };
 
 &uart7 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&uart7_pins_a>;
+	pinctrl-0 = <&uart7_pi_pins>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts b/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts
index 849244e03f3a..9a027764cda4 100644
--- a/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts
+++ b/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts
@@ -114,7 +114,7 @@
 
 &gmac {
 	pinctrl-names = "default";
-	pinctrl-0 = <&gmac_pins_mii_a>;
+	pinctrl-0 = <&gmac_mii_pins>;
 	phy = <&phy1>;
 	phy-mode = "mii";
 	status = "okay";
@@ -136,7 +136,7 @@
 
 &i2c0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&i2c0_pins_a>;
+	pinctrl-0 = <&i2c0_pins>;
 	status = "okay";
 
 	axp209: pmic at 34 {
@@ -148,19 +148,19 @@
 
 &i2c1 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&i2c1_pins_a>;
+	pinctrl-0 = <&i2c1_pins>;
 	status = "okay";
 };
 
 &ir0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&ir0_rx_pins_a>;
+	pinctrl-0 = <&ir0_rx_pin>;
 	status = "okay";
 };
 
 &mmc0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins_a>;
+	pinctrl-0 = <&mmc0_pins>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	cd-gpios = <&pio 7 1 GPIO_ACTIVE_LOW>; /* PH1 */
@@ -232,7 +232,7 @@
 
 &uart0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&uart0_pins_a>;
+	pinctrl-0 = <&uart0_pb_pins>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun7i-a20-cubietruck.dts b/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
index 0adcd0aab0aa..20069542336f 100644
--- a/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
+++ b/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
@@ -147,7 +147,7 @@
 
 &gmac {
 	pinctrl-names = "default";
-	pinctrl-0 = <&gmac_pins_rgmii_a>;
+	pinctrl-0 = <&gmac_rgmii_pins>;
 	phy = <&phy1>;
 	phy-mode = "rgmii";
 	status = "okay";
@@ -169,7 +169,7 @@
 
 &i2c0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&i2c0_pins_a>;
+	pinctrl-0 = <&i2c0_pins>;
 	status = "okay";
 
 	axp209: pmic at 34 {
@@ -181,25 +181,25 @@
 
 &i2c1 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&i2c1_pins_a>;
+	pinctrl-0 = <&i2c1_pins>;
 	status = "okay";
 };
 
 &i2c2 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&i2c2_pins_a>;
+	pinctrl-0 = <&i2c2_pins>;
 	status = "okay";
 };
 
 &ir0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&ir0_rx_pins_a>;
+	pinctrl-0 = <&ir0_rx_pin>;
 	status = "okay";
 };
 
 &mmc0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins_a>;
+	pinctrl-0 = <&mmc0_pins>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	cd-gpios = <&pio 7 1 GPIO_ACTIVE_LOW>; /* PH1 */
@@ -208,7 +208,7 @@
 
 &mmc3 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&mmc3_pins_a>;
+	pinctrl-0 = <&mmc3_pins>;
 	vmmc-supply = <&reg_vcc3v3>;
 	mmc-pwrseq = <&mmc3_pwrseq>;
 	bus-width = <4>;
@@ -224,7 +224,7 @@
 	};
 };
 
-&mmc3_pins_a {
+&mmc3_pins {
 	/* AP6210 requires pull-up */
 	bias-pull-up;
 };
@@ -243,7 +243,7 @@
 
 &pwm {
 	pinctrl-names = "default";
-	pinctrl-0 = <&pwm0_pins_a>, <&pwm1_pins_a>;
+	pinctrl-0 = <&pwm0_pin>, <&pwm1_pin>;
 	status = "okay";
 };
 
@@ -302,13 +302,13 @@
 
 &spdif {
 	pinctrl-names = "default";
-	pinctrl-0 = <&spdif_tx_pins_a>;
+	pinctrl-0 = <&spdif_tx_pin>;
 	status = "okay";
 };
 
 &uart0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&uart0_pins_a>;
+	pinctrl-0 = <&uart0_pb_pins>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun7i-a20-hummingbird.dts b/arch/arm/boot/dts/sun7i-a20-hummingbird.dts
index 6ba689354f22..9ce59d49cf49 100644
--- a/arch/arm/boot/dts/sun7i-a20-hummingbird.dts
+++ b/arch/arm/boot/dts/sun7i-a20-hummingbird.dts
@@ -99,7 +99,7 @@
 
 &gmac {
 	pinctrl-names = "default";
-	pinctrl-0 = <&gmac_pins_rgmii_a>;
+	pinctrl-0 = <&gmac_rgmii_pins>;
 	phy = <&phy1>;
 	phy-mode = "rgmii";
 	phy-supply = <&reg_gmac_vdd>;
@@ -117,7 +117,7 @@
 
 &i2c0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&i2c0_pins_a>;
+	pinctrl-0 = <&i2c0_pins>;
 	status = "okay";
 
 	axp209: pmic at 34 {
@@ -132,31 +132,31 @@
 
 &i2c1 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&i2c1_pins_a>;
+	pinctrl-0 = <&i2c1_pins>;
 	status = "okay";
 };
 
 &i2c2 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&i2c2_pins_a>;
+	pinctrl-0 = <&i2c2_pins>;
 	status = "okay";
 };
 
 &i2c3 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&i2c3_pins_a>;
+	pinctrl-0 = <&i2c3_pins>;
 	status = "okay";
 };
 
 &ir0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&ir0_rx_pins_a>;
+	pinctrl-0 = <&ir0_rx_pin>;
 	status = "okay";
 };
 
 &mmc0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins_a>;
+	pinctrl-0 = <&mmc0_pins>;
 	vmmc-supply = <&reg_vcc3v0>;
 	bus-width = <4>;
 	cd-gpios = <&pio 7 1 GPIO_ACTIVE_LOW>; /* PH1 */
@@ -165,7 +165,7 @@
 
 &mmc3 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&mmc3_pins_a>;
+	pinctrl-0 = <&mmc3_pins>;
 	vmmc-supply = <&reg_mmc3_vdd>;
 	bus-width = <4>;
 	non-removable;
@@ -182,7 +182,7 @@
 
 &pwm {
 	pinctrl-names = "default";
-	pinctrl-0 = <&pwm0_pins_a>;
+	pinctrl-0 = <&pwm0_pin>;
 	status = "okay";
 };
 
@@ -202,38 +202,38 @@
 
 &spi2 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&spi2_pins_b>,
-		    <&spi2_cs0_pins_b>;
+	pinctrl-0 = <&spi2_pb_pins>,
+		    <&spi2_cs0_pb_pin>;
 	status = "okay";
 };
 
 &uart0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&uart0_pins_a>;
+	pinctrl-0 = <&uart0_pb_pins>;
 	status = "okay";
 };
 
 &uart2 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&uart2_pins_a>;
+	pinctrl-0 = <&uart2_pi_pins>;
 	status = "okay";
 };
 
 &uart3 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&uart3_pins_a>;
+	pinctrl-0 = <&uart3_pg_pins>;
 	status = "okay";
 };
 
 &uart4 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&uart4_pins_a>;
+	pinctrl-0 = <&uart4_pg_pins>;
 	status = "okay";
 };
 
 &uart5 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&uart5_pins_a>;
+	pinctrl-0 = <&uart5_pi_pins>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun7i-a20-i12-tvbox.dts b/arch/arm/boot/dts/sun7i-a20-i12-tvbox.dts
index fe2b827cfa76..db708332616e 100644
--- a/arch/arm/boot/dts/sun7i-a20-i12-tvbox.dts
+++ b/arch/arm/boot/dts/sun7i-a20-i12-tvbox.dts
@@ -114,7 +114,7 @@
 
 &gmac {
 	pinctrl-names = "default";
-	pinctrl-0 = <&gmac_pins_mii_a>;
+	pinctrl-0 = <&gmac_mii_pins>;
 	phy = <&phy1>;
 	phy-mode = "mii";
 	phy-supply = <&reg_gmac_3v3>;
@@ -127,7 +127,7 @@
 
 &i2c0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&i2c0_pins_a>;
+	pinctrl-0 = <&i2c0_pins>;
 	status = "okay";
 
 	axp209: pmic at 34 {
@@ -143,13 +143,13 @@
 
 &ir0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&ir0_rx_pins_a>;
+	pinctrl-0 = <&ir0_rx_pin>;
 	status = "okay";
 };
 
 &mmc0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins_a>;
+	pinctrl-0 = <&mmc0_pins>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	cd-gpios = <&pio 7 1 GPIO_ACTIVE_LOW>; /* PH1 */
@@ -158,7 +158,7 @@
 
 &mmc3 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&mmc3_pins_a>;
+	pinctrl-0 = <&mmc3_pins>;
 	vmmc-supply = <&reg_vmmc3>;
 	bus-width = <4>;
 	non-removable;
@@ -173,7 +173,7 @@
 	};
 };
 
-&mmc3_pins_a {
+&mmc3_pins {
 	/* AP6210 / AP6330 requires pull-up */
 	bias-pull-up;
 };
@@ -196,7 +196,7 @@
 
 &uart0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&uart0_pins_a>;
+	pinctrl-0 = <&uart0_pb_pins>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun7i-a20-icnova-swac.dts b/arch/arm/boot/dts/sun7i-a20-icnova-swac.dts
index 926fa194eb1b..0bf70b22bac4 100644
--- a/arch/arm/boot/dts/sun7i-a20-icnova-swac.dts
+++ b/arch/arm/boot/dts/sun7i-a20-icnova-swac.dts
@@ -74,7 +74,7 @@
 
 &gmac {
 	pinctrl-names = "default";
-	pinctrl-0 = <&gmac_pins_mii_a>;
+	pinctrl-0 = <&gmac_mii_pins>;
 	phy = <&phy1>;
 	phy-mode = "mii";
 	status = "okay";
@@ -86,7 +86,7 @@
 
 &i2c0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&i2c0_pins_a>;
+	pinctrl-0 = <&i2c0_pins>;
 	status = "okay";
 
 	axp209: pmic at 34 {
@@ -98,13 +98,13 @@
 
 &i2c1 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&i2c1_pins_a>;
+	pinctrl-0 = <&i2c1_pins>;
 	status = "okay";
 };
 
 &mmc0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins_a>;
+	pinctrl-0 = <&mmc0_pins>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	cd-gpios = <&pio 8 5 GPIO_ACTIVE_LOW>; /* PI5 */
@@ -156,7 +156,7 @@
 
 &uart0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&uart0_pins_a>;
+	pinctrl-0 = <&uart0_pb_pins>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun7i-a20-itead-ibox.dts b/arch/arm/boot/dts/sun7i-a20-itead-ibox.dts
index 1b05ba466e7d..ad97f6f2cc2c 100644
--- a/arch/arm/boot/dts/sun7i-a20-itead-ibox.dts
+++ b/arch/arm/boot/dts/sun7i-a20-itead-ibox.dts
@@ -96,7 +96,7 @@
 
 &gmac {
 	pinctrl-names = "default";
-	pinctrl-0 = <&gmac_pins_mii_a>;
+	pinctrl-0 = <&gmac_mii_pins>;
 	phy = <&phy1>;
 	phy-mode = "mii";
 	status = "okay";
@@ -115,13 +115,13 @@
 
 &ir0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&ir0_rx_pins_a>;
+	pinctrl-0 = <&ir0_rx_pin>;
 	status = "okay";
 };
 
 &mmc0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins_a>;
+	pinctrl-0 = <&mmc0_pins>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	cd-gpios = <&pio 7 1 GPIO_ACTIVE_LOW>; /* PH1 */
@@ -142,6 +142,6 @@
 
 &spdif {
 	pinctrl-names = "default";
-	pinctrl-0 = <&spdif_tx_pins_a>;
+	pinctrl-0 = <&spdif_tx_pin>;
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/sun7i-a20-lamobo-r1.dts b/arch/arm/boot/dts/sun7i-a20-lamobo-r1.dts
index cccfee6add35..32e204fe8c15 100644
--- a/arch/arm/boot/dts/sun7i-a20-lamobo-r1.dts
+++ b/arch/arm/boot/dts/sun7i-a20-lamobo-r1.dts
@@ -119,7 +119,7 @@
 
 &gmac {
 	pinctrl-names = "default";
-	pinctrl-0 = <&gmac_pins_rgmii_a>;
+	pinctrl-0 = <&gmac_rgmii_pins>;
 	phy-mode = "rgmii";
 	phy-supply = <&reg_gmac_3v3>;
 	status = "okay";
@@ -196,7 +196,7 @@
 
 &i2c0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&i2c0_pins_a>;
+	pinctrl-0 = <&i2c0_pins>;
 	status = "okay";
 
 	axp209: pmic at 34 {
@@ -208,19 +208,19 @@
 
 &i2c2 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&i2c2_pins_a>;
+	pinctrl-0 = <&i2c2_pins>;
 	status = "okay";
 };
 
 &ir0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&ir0_rx_pins_a>;
+	pinctrl-0 = <&ir0_rx_pin>;
 	status = "okay";
 };
 
 &mmc0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins_a>;
+	pinctrl-0 = <&mmc0_pins>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	cd-gpios = <&pio 7 10 GPIO_ACTIVE_LOW>; /* PH10 */
@@ -294,27 +294,27 @@
 
 &spi0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&spi0_pins_a>,
-		    <&spi0_cs0_pins_a>,
-		    <&spi0_cs1_pins_a>;
+	pinctrl-0 = <&spi0_pi_pins>,
+		    <&spi0_cs0_pi_pin>,
+		    <&spi0_cs1_pi_pin>;
 	status = "okay";
 };
 
 &uart0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&uart0_pins_a>;
+	pinctrl-0 = <&uart0_pb_pins>;
 	status = "okay";
 };
 
 &uart3 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&uart3_pins_b>;
+	pinctrl-0 = <&uart3_ph_pins>;
 	status = "okay";
 };
 
 &uart7 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&uart7_pins_a>;
+	pinctrl-0 = <&uart7_pi_pins>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun7i-a20-m3.dts b/arch/arm/boot/dts/sun7i-a20-m3.dts
index cb8725d95e2b..1207e0d897b7 100644
--- a/arch/arm/boot/dts/sun7i-a20-m3.dts
+++ b/arch/arm/boot/dts/sun7i-a20-m3.dts
@@ -81,7 +81,7 @@
 
 &gmac {
 	pinctrl-names = "default";
-	pinctrl-0 = <&gmac_pins_mii_a>;
+	pinctrl-0 = <&gmac_mii_pins>;
 	phy = <&phy1>;
 	phy-mode = "mii";
 	status = "okay";
@@ -93,7 +93,7 @@
 
 &i2c0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&i2c0_pins_a>;
+	pinctrl-0 = <&i2c0_pins>;
 	status = "okay";
 
 	axp209: pmic at 34 {
@@ -109,13 +109,13 @@
 
 &ir0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&ir0_rx_pins_a>;
+	pinctrl-0 = <&ir0_rx_pin>;
 	status = "okay";
 };
 
 &mmc0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins_a>;
+	pinctrl-0 = <&mmc0_pins>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	cd-gpios = <&pio 7 1 GPIO_ACTIVE_LOW>; /* PH1 */
@@ -124,7 +124,7 @@
 
 &mmc2 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&mmc2_pins_a>;
+	pinctrl-0 = <&mmc2_pins>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	non-removable;
@@ -149,7 +149,7 @@
 
 &uart0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&uart0_pins_a>;
+	pinctrl-0 = <&uart0_pb_pins>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun7i-a20-mk808c.dts b/arch/arm/boot/dts/sun7i-a20-mk808c.dts
index a4c5da733fbc..a8d15d01ac1a 100644
--- a/arch/arm/boot/dts/sun7i-a20-mk808c.dts
+++ b/arch/arm/boot/dts/sun7i-a20-mk808c.dts
@@ -107,7 +107,7 @@
 
 &i2c0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&i2c0_pins_a>;
+	pinctrl-0 = <&i2c0_pins>;
 	status = "okay";
 
 	axp209: pmic at 34 {
@@ -122,19 +122,19 @@
 
 &i2c1 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&i2c1_pins_a>;
+	pinctrl-0 = <&i2c1_pins>;
 	status = "okay";
 };
 
 &i2c2 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&i2c2_pins_a>;
+	pinctrl-0 = <&i2c2_pins>;
 	status = "okay";
 };
 
 &mmc0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins_a>;
+	pinctrl-0 = <&mmc0_pins>;
 	vmmc-supply = <&reg_vcc3v0>;
 	bus-width = <4>;
 	cd-gpios = <&pio 7 1 GPIO_ACTIVE_LOW>; /* PH1 */
@@ -167,13 +167,13 @@
 
 &uart0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&uart0_pins_a>;
+	pinctrl-0 = <&uart0_pb_pins>;
 	status = "okay";
 };
 
 &uart2 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&uart2_pins_a>;
+	pinctrl-0 = <&uart2_pi_pins>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun7i-a20-olimex-som-evb-emmc.dts b/arch/arm/boot/dts/sun7i-a20-olimex-som-evb-emmc.dts
index 81ebc97b76ee..ea0d620119cb 100644
--- a/arch/arm/boot/dts/sun7i-a20-olimex-som-evb-emmc.dts
+++ b/arch/arm/boot/dts/sun7i-a20-olimex-som-evb-emmc.dts
@@ -22,7 +22,7 @@
 
 &mmc2 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&mmc2_pins_a>;
+	pinctrl-0 = <&mmc2_pins>;
 	vmmc-supply = <&reg_vcc3v3>;
 	mmc-pwrseq = <&mmc2_pwrseq>;
 	bus-width = <4>;
diff --git a/arch/arm/boot/dts/sun7i-a20-olimex-som-evb.dts b/arch/arm/boot/dts/sun7i-a20-olimex-som-evb.dts
index 2aa719338dac..8f8a77121e80 100644
--- a/arch/arm/boot/dts/sun7i-a20-olimex-som-evb.dts
+++ b/arch/arm/boot/dts/sun7i-a20-olimex-som-evb.dts
@@ -110,7 +110,7 @@
 
 &gmac {
 	pinctrl-names = "default";
-	pinctrl-0 = <&gmac_pins_rgmii_a>;
+	pinctrl-0 = <&gmac_rgmii_pins>;
 	phy = <&phy1>;
 	phy-mode = "rgmii";
 	status = "okay";
@@ -132,7 +132,7 @@
 
 &i2c0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&i2c0_pins_a>;
+	pinctrl-0 = <&i2c0_pins>;
 	status = "okay";
 
 	axp209: pmic at 34 {
@@ -144,13 +144,13 @@
 
 &i2c1 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&i2c1_pins_a>;
+	pinctrl-0 = <&i2c1_pins>;
 	status = "okay";
 };
 
 &i2c2 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&i2c2_pins_a>;
+	pinctrl-0 = <&i2c2_pins>;
 	status = "okay";
 };
 
@@ -210,7 +210,7 @@
 
 &mmc0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins_a>;
+	pinctrl-0 = <&mmc0_pins>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	cd-gpios = <&pio 7 1 GPIO_ACTIVE_LOW>; /* PH1 */
@@ -219,7 +219,7 @@
 
 &mmc3 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&mmc3_pins_a>;
+	pinctrl-0 = <&mmc3_pins>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	cd-gpios = <&pio 7 0 GPIO_ACTIVE_LOW>; /* PH0 */
@@ -292,33 +292,33 @@
 
 &spi1 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&spi1_pins_a>,
-		    <&spi1_cs0_pins_a>;
+	pinctrl-0 = <&spi1_pi_pins>,
+		    <&spi1_cs0_pi_pin>;
 	status = "okay";
 };
 
 &spi2 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&spi2_pins_a>,
-		    <&spi2_cs0_pins_a>;
+	pinctrl-0 = <&spi2_pc_pins>,
+		    <&spi2_cs0_pc_pin>;
 	status = "okay";
 };
 
 &uart0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&uart0_pins_a>;
+	pinctrl-0 = <&uart0_pb_pins>;
 	status = "okay";
 };
 
 &uart6 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&uart6_pins_a>;
+	pinctrl-0 = <&uart6_pi_pins>;
 	status = "okay";
 };
 
 &uart7 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&uart7_pins_a>;
+	pinctrl-0 = <&uart7_pi_pins>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun7i-a20-olimex-som204-evb-emmc.dts b/arch/arm/boot/dts/sun7i-a20-olimex-som204-evb-emmc.dts
index c56620a8fb20..093cd32c9a1c 100644
--- a/arch/arm/boot/dts/sun7i-a20-olimex-som204-evb-emmc.dts
+++ b/arch/arm/boot/dts/sun7i-a20-olimex-som204-evb-emmc.dts
@@ -21,7 +21,7 @@
 
 &mmc2 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&mmc2_pins_a>;
+	pinctrl-0 = <&mmc2_pins>;
 	vmmc-supply = <&reg_vcc3v3>;
 	mmc-pwrseq = <&mmc2_pwrseq>;
 	bus-width = <4>;
diff --git a/arch/arm/boot/dts/sun7i-a20-olimex-som204-evb.dts b/arch/arm/boot/dts/sun7i-a20-olimex-som204-evb.dts
index 3d7b5c848fef..631a80ae958e 100644
--- a/arch/arm/boot/dts/sun7i-a20-olimex-som204-evb.dts
+++ b/arch/arm/boot/dts/sun7i-a20-olimex-som204-evb.dts
@@ -78,7 +78,7 @@
 
 &can0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&can0_pins_a>;
+	pinctrl-0 = <&can_ph_pins>;
 	status = "okay";
 };
 
@@ -104,7 +104,7 @@
 
 &gmac {
 	pinctrl-names = "default";
-	pinctrl-0 = <&gmac_pins_rgmii_a>;
+	pinctrl-0 = <&gmac_rgmii_pins>;
 	phy = <&phy3>;
 	phy-mode = "rgmii";
 	phy-supply = <&reg_vcc3v3>;
@@ -131,7 +131,7 @@
 
 &i2c0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&i2c0_pins_a>;
+	pinctrl-0 = <&i2c0_pins>;
 	status = "okay";
 
 	axp209: pmic at 34 {
@@ -144,7 +144,7 @@
 /* Exposed to UEXT1 */
 &i2c1 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&i2c1_pins_a>;
+	pinctrl-0 = <&i2c1_pins>;
 	status = "okay";
 
 	eeprom: eeprom at 50 {
@@ -157,19 +157,19 @@
 /* Exposed to UEXT2 */
 &i2c2 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&i2c2_pins_a>;
+	pinctrl-0 = <&i2c2_pins>;
 	status = "okay";
 };
 
 &ir0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&ir0_rx_pins_a>;
+	pinctrl-0 = <&ir0_rx_pin>;
 	status = "okay";
 };
 
 &mmc0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins_a>;
+	pinctrl-0 = <&mmc0_pins>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	cd-gpios = <&pio 7 1 GPIO_ACTIVE_LOW>;
@@ -178,7 +178,7 @@
 
 &mmc3 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&mmc3_pins_a>;
+	pinctrl-0 = <&mmc3_pins>;
 	vmmc-supply = <&reg_vcc3v3>;
 	mmc-pwrseq = <&rtl_pwrseq>;
 	bus-width = <4>;
@@ -274,22 +274,22 @@
 /* Exposed to UEXT1 */
 &spi1 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&spi1_pins_a>,
-		    <&spi1_cs0_pins_a>;
+	pinctrl-0 = <&spi1_pi_pins>,
+		    <&spi1_cs0_pi_pin>;
 	status = "okay";
 };
 
 /* Exposed to UEXT2 */
 &spi2 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&spi2_pins_a>,
-		    <&spi2_cs0_pins_a>;
+	pinctrl-0 = <&spi2_pc_pins>,
+		    <&spi2_cs0_pc_pin>;
 	status = "okay";
 };
 
 &uart0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&uart0_pins_a>;
+	pinctrl-0 = <&uart0_pb_pins>;
 	status = "okay";
 };
 
@@ -303,14 +303,14 @@
 /* Exposed to UEXT1 */
 &uart4 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&uart4_pins_a>;
+	pinctrl-0 = <&uart4_pg_pins>;
 	status = "okay";
 };
 
 /* Exposed to UEXT2 */
 &uart7 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&uart7_pins_a>;
+	pinctrl-0 = <&uart7_pi_pins>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun7i-a20-olinuxino-lime.dts b/arch/arm/boot/dts/sun7i-a20-olinuxino-lime.dts
index 46cd00ba8a74..7d6a90678025 100644
--- a/arch/arm/boot/dts/sun7i-a20-olinuxino-lime.dts
+++ b/arch/arm/boot/dts/sun7i-a20-olinuxino-lime.dts
@@ -105,7 +105,7 @@
 
 &gmac {
 	pinctrl-names = "default";
-	pinctrl-0 = <&gmac_pins_mii_a>;
+	pinctrl-0 = <&gmac_mii_pins>;
 	phy = <&phy1>;
 	phy-mode = "mii";
 	status = "okay";
@@ -127,7 +127,7 @@
 
 &i2c0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&i2c0_pins_a>;
+	pinctrl-0 = <&i2c0_pins>;
 	status = "okay";
 
 	axp209: pmic at 34 {
@@ -143,7 +143,7 @@
 
 &i2c1 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&i2c1_pins_a>;
+	pinctrl-0 = <&i2c1_pins>;
 	status = "okay";
 
 	eeprom: eeprom at 50 {
@@ -155,7 +155,7 @@
 
 &mmc0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins_a>;
+	pinctrl-0 = <&mmc0_pins>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	cd-gpios = <&pio 7 1 GPIO_ACTIVE_LOW>; /* PH1 */
@@ -213,7 +213,7 @@
 
 &uart0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&uart0_pins_a>;
+	pinctrl-0 = <&uart0_pb_pins>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2-emmc.dts b/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2-emmc.dts
index 727dffe1db05..0a2a26f9a5fb 100644
--- a/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2-emmc.dts
+++ b/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2-emmc.dts
@@ -55,7 +55,7 @@
 
 &mmc2 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&mmc2_pins_a>;
+	pinctrl-0 = <&mmc2_pins>;
 	vmmc-supply = <&reg_vcc3v3>;
 	vqmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
diff --git a/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts b/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
index ed6f4e1e94b3..9ea84cf6437b 100644
--- a/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
+++ b/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
@@ -110,7 +110,7 @@
 
 &gmac {
 	pinctrl-names = "default";
-	pinctrl-0 = <&gmac_pins_rgmii_a>;
+	pinctrl-0 = <&gmac_rgmii_pins>;
 	phy = <&phy1>;
 	phy-mode = "rgmii";
 	status = "okay";
@@ -132,7 +132,7 @@
 
 &i2c0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&i2c0_pins_a>;
+	pinctrl-0 = <&i2c0_pins>;
 	status = "okay";
 
 	axp209: pmic at 34 {
@@ -144,7 +144,7 @@
 
 &i2c1 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&i2c1_pins_a>;
+	pinctrl-0 = <&i2c1_pins>;
 	status = "okay";
 
 	eeprom: eeprom at 50 {
@@ -160,7 +160,7 @@
 
 &mmc0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins_a>;
+	pinctrl-0 = <&mmc0_pins>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	cd-gpios = <&pio 7 1 GPIO_ACTIVE_LOW>; /* PH1 */
@@ -261,7 +261,7 @@
 
 &uart0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&uart0_pins_a>;
+	pinctrl-0 = <&uart0_pb_pins>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun7i-a20-olinuxino-micro-emmc.dts b/arch/arm/boot/dts/sun7i-a20-olinuxino-micro-emmc.dts
index d99e7b193efe..58fd3519ab7d 100644
--- a/arch/arm/boot/dts/sun7i-a20-olinuxino-micro-emmc.dts
+++ b/arch/arm/boot/dts/sun7i-a20-olinuxino-micro-emmc.dts
@@ -55,7 +55,7 @@
 
 &mmc2 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&mmc2_pins_a>;
+	pinctrl-0 = <&mmc2_pins>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	non-removable;
diff --git a/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts b/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
index f78f18fd7c1c..4cef69e90b2f 100644
--- a/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
+++ b/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
@@ -117,7 +117,7 @@
 
 &gmac {
 	pinctrl-names = "default";
-	pinctrl-0 = <&gmac_pins_mii_a>, <&gmac_txerr>;
+	pinctrl-0 = <&gmac_mii_pins>, <&gmac_txerr>;
 	phy = <&phy1>;
 	phy-mode = "mii";
 	status = "okay";
@@ -139,7 +139,7 @@
 
 &i2c0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&i2c0_pins_a>;
+	pinctrl-0 = <&i2c0_pins>;
 	status = "okay";
 
 	axp209: pmic at 34 {
@@ -151,7 +151,7 @@
 
 &i2c1 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&i2c1_pins_a>;
+	pinctrl-0 = <&i2c1_pins>;
 	status = "okay";
 
 	eeprom: eeprom at 50 {
@@ -163,7 +163,7 @@
 
 &i2c2 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&i2c2_pins_a>;
+	pinctrl-0 = <&i2c2_pins>;
 	status = "okay";
 };
 
@@ -223,7 +223,7 @@
 
 &mmc0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins_a>;
+	pinctrl-0 = <&mmc0_pins>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	cd-gpios = <&pio 7 1 GPIO_ACTIVE_LOW>; /* PH1 */
@@ -232,7 +232,7 @@
 
 &mmc3 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&mmc3_pins_a>;
+	pinctrl-0 = <&mmc3_pins>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	cd-gpios = <&pio 7 11 GPIO_ACTIVE_LOW>; /* PH11 */
@@ -325,33 +325,33 @@
 
 &spi1 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&spi1_pins_a>,
-		    <&spi1_cs0_pins_a>;
+	pinctrl-0 = <&spi1_pi_pins>,
+		    <&spi1_cs0_pi_pin>;
 	status = "okay";
 };
 
 &spi2 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&spi2_pins_a>,
-		    <&spi2_cs0_pins_a>;
+	pinctrl-0 = <&spi2_pc_pins>,
+		    <&spi2_cs0_pc_pin>;
 	status = "okay";
 };
 
 &uart0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&uart0_pins_a>;
+	pinctrl-0 = <&uart0_pb_pins>;
 	status = "okay";
 };
 
 &uart6 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&uart6_pins_a>;
+	pinctrl-0 = <&uart6_pi_pins>;
 	status = "okay";
 };
 
 &uart7 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&uart7_pins_a>;
+	pinctrl-0 = <&uart7_pi_pins>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun7i-a20-orangepi-mini.dts b/arch/arm/boot/dts/sun7i-a20-orangepi-mini.dts
index c138e39ac072..192d907fee71 100644
--- a/arch/arm/boot/dts/sun7i-a20-orangepi-mini.dts
+++ b/arch/arm/boot/dts/sun7i-a20-orangepi-mini.dts
@@ -119,7 +119,7 @@
 
 &gmac {
 	pinctrl-names = "default";
-	pinctrl-0 = <&gmac_pins_rgmii_a>;
+	pinctrl-0 = <&gmac_rgmii_pins>;
 	phy = <&phy1>;
 	phy-mode = "rgmii";
 	phy-supply = <&reg_gmac_3v3>;
@@ -142,7 +142,7 @@
 
 &i2c0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&i2c0_pins_a>;
+	pinctrl-0 = <&i2c0_pins>;
 	status = "okay";
 
 	axp209: pmic at 34 {
@@ -156,13 +156,13 @@
 
 &ir0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&ir0_rx_pins_a>;
+	pinctrl-0 = <&ir0_rx_pin>;
 	status = "okay";
 };
 
 &mmc0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins_a>;
+	pinctrl-0 = <&mmc0_pins>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	cd-gpios = <&pio 7 10 GPIO_ACTIVE_LOW>; /* PH10 */
@@ -171,7 +171,7 @@
 
 &mmc3 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&mmc3_pins_a>;
+	pinctrl-0 = <&mmc3_pins>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	cd-gpios = <&pio 7 11 GPIO_ACTIVE_LOW>; /* PH11 */
@@ -231,7 +231,7 @@
 
 &uart0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&uart0_pins_a>;
+	pinctrl-0 = <&uart0_pb_pins>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun7i-a20-orangepi.dts b/arch/arm/boot/dts/sun7i-a20-orangepi.dts
index 4f4821d6466d..c71d819cd0af 100644
--- a/arch/arm/boot/dts/sun7i-a20-orangepi.dts
+++ b/arch/arm/boot/dts/sun7i-a20-orangepi.dts
@@ -95,7 +95,7 @@
 
 &gmac {
 	pinctrl-names = "default";
-	pinctrl-0 = <&gmac_pins_rgmii_a>;
+	pinctrl-0 = <&gmac_rgmii_pins>;
 	phy = <&phy1>;
 	phy-mode = "rgmii";
 	phy-supply = <&reg_gmac_3v3>;
@@ -108,7 +108,7 @@
 
 &i2c0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&i2c0_pins_a>;
+	pinctrl-0 = <&i2c0_pins>;
 	status = "okay";
 
 	axp209: pmic at 34 {
@@ -122,13 +122,13 @@
 
 &ir0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&ir0_rx_pins_a>;
+	pinctrl-0 = <&ir0_rx_pin>;
 	status = "okay";
 };
 
 &mmc0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins_a>;
+	pinctrl-0 = <&mmc0_pins>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	cd-gpios = <&pio 7 10 GPIO_ACTIVE_LOW>; /* PH10 */
@@ -188,7 +188,7 @@
 
 &uart0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&uart0_pins_a>;
+	pinctrl-0 = <&uart0_pb_pins>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun7i-a20-pcduino3-nano.dts b/arch/arm/boot/dts/sun7i-a20-pcduino3-nano.dts
index 5e538a23476c..1ba1dd6de244 100644
--- a/arch/arm/boot/dts/sun7i-a20-pcduino3-nano.dts
+++ b/arch/arm/boot/dts/sun7i-a20-pcduino3-nano.dts
@@ -113,7 +113,7 @@
 
 &gmac {
 	pinctrl-names = "default";
-	pinctrl-0 = <&gmac_pins_rgmii_a>;
+	pinctrl-0 = <&gmac_rgmii_pins>;
 	phy = <&phy1>;
 	phy-mode = "rgmii";
 	status = "okay";
@@ -135,7 +135,7 @@
 
 &i2c0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&i2c0_pins_a>;
+	pinctrl-0 = <&i2c0_pins>;
 	status = "okay";
 
 	axp209: pmic at 34 {
@@ -147,13 +147,13 @@
 
 &ir0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&ir0_rx_pins_a>;
+	pinctrl-0 = <&ir0_rx_pin>;
 	status = "okay";
 };
 
 &mmc0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins_a>;
+	pinctrl-0 = <&mmc0_pins>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	cd-gpios = <&pio 7 1 GPIO_ACTIVE_LOW>; /* PH1 */
@@ -220,7 +220,7 @@
 
 &uart0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&uart0_pins_a>;
+	pinctrl-0 = <&uart0_pb_pins>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun7i-a20-pcduino3.dts b/arch/arm/boot/dts/sun7i-a20-pcduino3.dts
index 0c0997effdf7..77a49e8b3d20 100644
--- a/arch/arm/boot/dts/sun7i-a20-pcduino3.dts
+++ b/arch/arm/boot/dts/sun7i-a20-pcduino3.dts
@@ -121,7 +121,7 @@
 
 &gmac {
 	pinctrl-names = "default";
-	pinctrl-0 = <&gmac_pins_mii_a>;
+	pinctrl-0 = <&gmac_mii_pins>;
 	phy = <&phy1>;
 	phy-mode = "mii";
 	status = "okay";
@@ -133,7 +133,7 @@
 
 &i2c0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&i2c0_pins_a>;
+	pinctrl-0 = <&i2c0_pins>;
 	status = "okay";
 
 	axp209: pmic at 34 {
@@ -147,13 +147,13 @@
 
 &ir0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&ir0_rx_pins_a>;
+	pinctrl-0 = <&ir0_rx_pin>;
 	status = "okay";
 };
 
 &mmc0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins_a>;
+	pinctrl-0 = <&mmc0_pins>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	cd-gpios = <&pio 7 1 GPIO_ACTIVE_LOW>; /* PH1 */
@@ -220,7 +220,7 @@
 
 &uart0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&uart0_pins_a>;
+	pinctrl-0 = <&uart0_pb_pins>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun7i-a20-wexler-tab7200.dts b/arch/arm/boot/dts/sun7i-a20-wexler-tab7200.dts
index 8fd85c6597bf..23b7d127e14f 100644
--- a/arch/arm/boot/dts/sun7i-a20-wexler-tab7200.dts
+++ b/arch/arm/boot/dts/sun7i-a20-wexler-tab7200.dts
@@ -90,7 +90,7 @@
 
 &i2c0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&i2c0_pins_a>;
+	pinctrl-0 = <&i2c0_pins>;
 	status = "okay";
 
 	axp209: pmic at 34 {
@@ -104,13 +104,13 @@
 
 &i2c1 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&i2c1_pins_a>;
+	pinctrl-0 = <&i2c1_pins>;
 	status = "okay";
 };
 
 &i2c2 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&i2c2_pins_a>;
+	pinctrl-0 = <&i2c2_pins>;
 	status = "okay";
 
 	gt911: touchscreen at 5d {
@@ -145,7 +145,7 @@
 
 &mmc0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins_a>;
+	pinctrl-0 = <&mmc0_pins>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	cd-gpios = <&pio 7 1 GPIO_ACTIVE_LOW>; /* PH1 */
@@ -174,7 +174,7 @@
 
 &pwm {
 	pinctrl-names = "default";
-	pinctrl-0 = <&pwm0_pins_a>;
+	pinctrl-0 = <&pwm0_pin>;
 	status = "okay";
 };
 
@@ -217,7 +217,7 @@
 
 &uart0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&uart0_pins_a>;
+	pinctrl-0 = <&uart0_pb_pins>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun7i-a20-wits-pro-a20-dkt.dts b/arch/arm/boot/dts/sun7i-a20-wits-pro-a20-dkt.dts
index bf4f51160737..1df18959d2a9 100644
--- a/arch/arm/boot/dts/sun7i-a20-wits-pro-a20-dkt.dts
+++ b/arch/arm/boot/dts/sun7i-a20-wits-pro-a20-dkt.dts
@@ -80,7 +80,7 @@
 
 &gmac {
 	pinctrl-names = "default";
-	pinctrl-0 = <&gmac_pins_rgmii_a>;
+	pinctrl-0 = <&gmac_rgmii_pins>;
 	phy = <&phy1>;
 	phy-mode = "rgmii";
 	status = "okay";
@@ -92,7 +92,7 @@
 
 &i2c0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&i2c0_pins_a>;
+	pinctrl-0 = <&i2c0_pins>;
 	status = "okay";
 
 	axp209: pmic at 34 {
@@ -104,13 +104,13 @@
 
 &i2c1 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&i2c1_pins_a>;
+	pinctrl-0 = <&i2c1_pins>;
 	status = "okay";
 };
 
 &i2c2 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&i2c2_pins_a>;
+	pinctrl-0 = <&i2c2_pins>;
 	status = "okay";
 };
 
@@ -118,7 +118,7 @@
 
 &mmc0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins_a>;
+	pinctrl-0 = <&mmc0_pins>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	cd-gpios = <&pio 7 1 GPIO_ACTIVE_LOW>; /* PH1 */
@@ -127,7 +127,7 @@
 
 &mmc3 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&mmc3_pins_a>;
+	pinctrl-0 = <&mmc3_pins>;
 	vmmc-supply = <&reg_vcc3v3>;
 	mmc-pwrseq = <&mmc3_pwrseq>;
 	bus-width = <4>;
@@ -202,7 +202,7 @@
 
 &uart0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&uart0_pins_a>;
+	pinctrl-0 = <&uart0_pb_pins>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index c5a6b7a65c52..75669fc51de5 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -747,22 +747,22 @@
 			#interrupt-cells = <3>;
 			#gpio-cells = <3>;
 
-			can0_pins_a: can0 at 0 {
+			can_ph_pins: can-ph-pins {
 				pins = "PH20", "PH21";
 				function = "can";
 			};
 
-			clk_out_a_pins_a: clk_out_a at 0 {
+			clk_out_a_pin: clk-out-a-pin {
 				pins = "PI12";
 				function = "clk_out_a";
 			};
 
-			clk_out_b_pins_a: clk_out_b at 0 {
+			clk_out_b_pin: clk-out-b-pin {
 				pins = "PI13";
 				function = "clk_out_b";
 			};
 
-			emac_pins_a: emac0 at 0 {
+			emac_pa_pins: emac-pa-pins {
 				pins = "PA0", "PA1", "PA2",
 				       "PA3", "PA4", "PA5", "PA6",
 				       "PA7", "PA8", "PA9", "PA10",
@@ -771,7 +771,7 @@
 				function = "emac";
 			};
 
-			gmac_pins_mii_a: gmac_mii at 0 {
+			gmac_mii_pins: gmac-mii-pins {
 				pins = "PA0", "PA1", "PA2",
 				       "PA3", "PA4", "PA5", "PA6",
 				       "PA7", "PA8", "PA9", "PA10",
@@ -780,7 +780,7 @@
 				function = "gmac";
 			};
 
-			gmac_pins_rgmii_a: gmac_rgmii at 0 {
+			gmac_rgmii_pins: gmac-rgmii-pins {
 				pins = "PA0", "PA1", "PA2",
 				       "PA3", "PA4", "PA5", "PA6",
 				        "PA7", "PA8", "PA10",
@@ -794,47 +794,47 @@
 				drive-strength = <40>;
 			};
 
-			i2c0_pins_a: i2c0 at 0 {
+			i2c0_pins: i2c0-pins {
 				pins = "PB0", "PB1";
 				function = "i2c0";
 			};
 
-			i2c1_pins_a: i2c1 at 0 {
+			i2c1_pins: i2c1-pins {
 				pins = "PB18", "PB19";
 				function = "i2c1";
 			};
 
-			i2c2_pins_a: i2c2 at 0 {
+			i2c2_pins: i2c2-pins {
 				pins = "PB20", "PB21";
 				function = "i2c2";
 			};
 
-			i2c3_pins_a: i2c3 at 0 {
+			i2c3_pins: i2c3-pins {
 				pins = "PI0", "PI1";
 				function = "i2c3";
 			};
 
-			ir0_rx_pins_a: ir0 at 0 {
+			ir0_rx_pin: ir0-rx-pin {
 				pins = "PB4";
 				function = "ir0";
 			};
 
-			ir0_tx_pins_a: ir0 at 1 {
+			ir0_tx_pin: ir0-tx-pin {
 				pins = "PB3";
 				function = "ir0";
 			};
 
-			ir1_rx_pins_a: ir1 at 0 {
+			ir1_rx_pin: ir1-rx-pin {
 				pins = "PB23";
 				function = "ir1";
 			};
 
-			ir1_tx_pins_a: ir1 at 1 {
+			ir1_tx_pin: ir1-tx-pin {
 				pins = "PB22";
 				function = "ir1";
 			};
 
-			mmc0_pins_a: mmc0 at 0 {
+			mmc0_pins: mmc0-pins {
 				pins = "PF0", "PF1", "PF2",
 				       "PF3", "PF4", "PF5";
 				function = "mmc0";
@@ -842,7 +842,7 @@
 				bias-pull-up;
 			};
 
-			mmc2_pins_a: mmc2 at 0 {
+			mmc2_pins: mmc2-pins {
 				pins = "PC6", "PC7", "PC8",
 				       "PC9", "PC10", "PC11";
 				function = "mmc2";
@@ -850,7 +850,7 @@
 				bias-pull-up;
 			};
 
-			mmc3_pins_a: mmc3 at 0 {
+			mmc3_pins: mmc3-pins {
 				pins = "PI4", "PI5", "PI6",
 				       "PI7", "PI8", "PI9";
 				function = "mmc3";
@@ -858,118 +858,118 @@
 				bias-pull-up;
 			};
 
-			ps20_pins_a: ps20 at 0 {
+			ps2_0_pins: ps2-0-pins {
 				pins = "PI20", "PI21";
 				function = "ps2";
 			};
 
-			ps21_pins_a: ps21 at 0 {
+			ps2_1_ph_pins: ps2-1-ph-pins {
 				pins = "PH12", "PH13";
 				function = "ps2";
 			};
 
-			pwm0_pins_a: pwm0 at 0 {
+			pwm0_pin: pwm0-pin {
 				pins = "PB2";
 				function = "pwm";
 			};
 
-			pwm1_pins_a: pwm1 at 0 {
+			pwm1_pin: pwm1-pin {
 				pins = "PI3";
 				function = "pwm";
 			};
 
-			spdif_tx_pins_a: spdif at 0 {
+			spdif_tx_pin: spdif-tx-pin {
 				pins = "PB13";
 				function = "spdif";
 				bias-pull-up;
 			};
 
-			spi0_pins_a: spi0 at 0 {
+			spi0_pi_pins: spi0-pi-pins {
 				pins = "PI11", "PI12", "PI13";
 				function = "spi0";
 			};
 
-			spi0_cs0_pins_a: spi0_cs0 at 0 {
+			spi0_cs0_pi_pin: spi0-cs0-pi-pin {
 				pins = "PI10";
 				function = "spi0";
 			};
 
-			spi0_cs1_pins_a: spi0_cs1 at 0 {
+			spi0_cs1_pi_pin: spi0-cs1-pi-pin {
 				pins = "PI14";
 				function = "spi0";
 			};
 
-			spi1_pins_a: spi1 at 0 {
+			spi1_pi_pins: spi1-pi-pins {
 				pins = "PI17", "PI18", "PI19";
 				function = "spi1";
 			};
 
-			spi1_cs0_pins_a: spi1_cs0 at 0 {
+			spi1_cs0_pi_pin: spi1-cs0-pi-pin {
 				pins = "PI16";
 				function = "spi1";
 			};
 
-			spi2_pins_a: spi2 at 0 {
-				pins = "PC20", "PC21", "PC22";
+			spi2_pb_pins: spi2-pb-pins {
+				pins = "PB15", "PB16", "PB17";
 				function = "spi2";
 			};
 
-			spi2_pins_b: spi2 at 1 {
-				pins = "PB15", "PB16", "PB17";
+			spi2_cs0_pb_pin: spi2-cs0-pb-pin {
+				pins = "PB14";
 				function = "spi2";
 			};
 
-			spi2_cs0_pins_a: spi2_cs0 at 0 {
-				pins = "PC19";
+			spi2_pc_pins: spi2-pc-pins {
+				pins = "PC20", "PC21", "PC22";
 				function = "spi2";
 			};
 
-			spi2_cs0_pins_b: spi2_cs0 at 1 {
-				pins = "PB14";
+			spi2_cs0_pc_pin: spi2-cs0-pc-pin {
+				pins = "PC19";
 				function = "spi2";
 			};
 
-			uart0_pins_a: uart0 at 0 {
+			uart0_pb_pins: uart0-pb-pins {
 				pins = "PB22", "PB23";
 				function = "uart0";
 			};
 
-			uart2_pins_a: uart2 at 0 {
+			uart2_pi_pins: uart2-pi-pins {
 				pins = "PI16", "PI17", "PI18", "PI19";
 				function = "uart2";
 			};
 
-			uart3_pins_a: uart3 at 0 {
+			uart3_pg_pins: uart3-pg-pins {
 				pins = "PG6", "PG7", "PG8", "PG9";
 				function = "uart3";
 			};
 
-			uart3_pins_b: uart3 at 1 {
+			uart3_ph_pins: uart3-ph-pins {
 				pins = "PH0", "PH1";
 				function = "uart3";
 			};
 
-			uart4_pins_a: uart4 at 0 {
+			uart4_pg_pins: uart4-pg-pins {
 				pins = "PG10", "PG11";
 				function = "uart4";
 			};
 
-			uart4_pins_b: uart4 at 1 {
+			uart4_ph_pins: uart4-ph-pins {
 				pins = "PH4", "PH5";
 				function = "uart4";
 			};
 
-			uart5_pins_a: uart5 at 0 {
+			uart5_pi_pins: uart5-pi-pins {
 				pins = "PI10", "PI11";
 				function = "uart5";
 			};
 
-			uart6_pins_a: uart6 at 0 {
+			uart6_pi_pins: uart6-pi-pins {
 				pins = "PI12", "PI13";
 				function = "uart6";
 			};
 
-			uart7_pins_a: uart7 at 0 {
+			uart7_pi_pins: uart7-pi-pins {
 				pins = "PI20", "PI21";
 				function = "uart7";
 			};
diff --git a/arch/arm/boot/dts/sunxi-itead-core-common.dtsi b/arch/arm/boot/dts/sunxi-itead-core-common.dtsi
index ddf4e722ea93..0d002f83a259 100644
--- a/arch/arm/boot/dts/sunxi-itead-core-common.dtsi
+++ b/arch/arm/boot/dts/sunxi-itead-core-common.dtsi
@@ -121,7 +121,7 @@
 
 &uart0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&uart0_pins_a>;
+	pinctrl-0 = <&uart0_pb_pins>;
 	status = "okay";
 };
 
-- 
git-series 0.9.1
