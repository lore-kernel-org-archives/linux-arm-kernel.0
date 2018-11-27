From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 27 Nov 2018 13:45:13 +0100
Subject: [PATCH 12/77] ARM: dts: sun5i: Change pinctrl nodes to avoid warning
In-Reply-To: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
References: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
Message-ID: <96b9e11cde1c12e1bc05a5d60e0381f7ac25cd89.1543321707.git-series.maxime.ripard@bootlin.com>
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
 arch/arm/boot/dts/sun5i-a10s-auxtek-t003.dts           |  6 +-
 arch/arm/boot/dts/sun5i-a10s-auxtek-t004.dts           |  8 +-
 arch/arm/boot/dts/sun5i-a10s-mk802.dts                 |  8 +-
 arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts       | 22 +++---
 arch/arm/boot/dts/sun5i-a10s-r7-tv-dongle.dts          |  6 +-
 arch/arm/boot/dts/sun5i-a10s-wobo-i5.dts               |  8 +-
 arch/arm/boot/dts/sun5i-a10s.dtsi                      | 12 +--
 arch/arm/boot/dts/sun5i-a13-empire-electronix-d709.dts | 10 +--
 arch/arm/boot/dts/sun5i-a13-hsg-h702.dts               | 10 +--
 arch/arm/boot/dts/sun5i-a13-licheepi-one.dts           | 12 +--
 arch/arm/boot/dts/sun5i-a13-olinuxino-micro.dts        | 10 +--
 arch/arm/boot/dts/sun5i-a13-olinuxino.dts              | 10 +--
 arch/arm/boot/dts/sun5i-a13-utoo-p66.dts               |  2 +-
 arch/arm/boot/dts/sun5i-gr8-chip-pro.dts               | 18 ++---
 arch/arm/boot/dts/sun5i-gr8-evb.dts                    | 20 ++---
 arch/arm/boot/dts/sun5i-gr8.dtsi                       | 10 +--
 arch/arm/boot/dts/sun5i-r8-chip.dts                    | 18 ++---
 arch/arm/boot/dts/sun5i-reference-design-tablet.dtsi   | 12 ++-
 arch/arm/boot/dts/sun5i.dtsi                           | 44 +++++------
 19 files changed, 127 insertions(+), 119 deletions(-)

diff --git a/arch/arm/boot/dts/sun5i-a10s-auxtek-t003.dts b/arch/arm/boot/dts/sun5i-a10s-auxtek-t003.dts
index 9e076e748b78..30c8e7b5fabc 100644
--- a/arch/arm/boot/dts/sun5i-a10s-auxtek-t003.dts
+++ b/arch/arm/boot/dts/sun5i-a10s-auxtek-t003.dts
@@ -76,7 +76,7 @@
 
 &i2c0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&i2c0_pins_a>;
+	pinctrl-0 = <&i2c0_pins>;
 	status = "okay";
 
 	axp152: pmic at 30 {
@@ -90,7 +90,7 @@
 
 &mmc0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins_a>;
+	pinctrl-0 = <&mmc0_pins>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	cd-gpios = <&pio 6 1 GPIO_ACTIVE_LOW>; /* PG1 */
@@ -125,7 +125,7 @@
 
 &uart0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&uart0_pins_a>;
+	pinctrl-0 = <&uart0_pb_pins>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun5i-a10s-auxtek-t004.dts b/arch/arm/boot/dts/sun5i-a10s-auxtek-t004.dts
index 61d0bab8cbbd..781be07547a3 100644
--- a/arch/arm/boot/dts/sun5i-a10s-auxtek-t004.dts
+++ b/arch/arm/boot/dts/sun5i-a10s-auxtek-t004.dts
@@ -86,7 +86,7 @@
 
 &i2c0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&i2c0_pins_a>;
+	pinctrl-0 = <&i2c0_pins>;
 	status = "okay";
 
 	axp152: pmic at 30 {
@@ -100,7 +100,7 @@
 
 &mmc0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins_a>;
+	pinctrl-0 = <&mmc0_pins>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	cd-gpios = <&pio 6 1 GPIO_ACTIVE_LOW>; /* PG1 */
@@ -109,7 +109,7 @@
 
 &mmc1 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&mmc1_pins_a>;
+	pinctrl-0 = <&mmc1_pins>;
 	vmmc-supply = <&reg_vmmc1>;
 	bus-width = <4>;
 	non-removable;
@@ -146,7 +146,7 @@
 
 &uart0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&uart0_pins_a>;
+	pinctrl-0 = <&uart0_pb_pins>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun5i-a10s-mk802.dts b/arch/arm/boot/dts/sun5i-a10s-mk802.dts
index 822f1b2ac6d3..06b876c50f15 100644
--- a/arch/arm/boot/dts/sun5i-a10s-mk802.dts
+++ b/arch/arm/boot/dts/sun5i-a10s-mk802.dts
@@ -73,7 +73,7 @@
 
 &i2c0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&i2c0_pins_a>;
+	pinctrl-0 = <&i2c0_pins>;
 	status = "okay";
 
 	axp152: pmic at 30 {
@@ -87,7 +87,7 @@
 
 &mmc0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins_a>;
+	pinctrl-0 = <&mmc0_pins>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	cd-gpios = <&pio 6 1 GPIO_ACTIVE_LOW>; /* PG1 */
@@ -96,7 +96,7 @@
 
 &mmc1 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&mmc1_pins_a>;
+	pinctrl-0 = <&mmc1_pins>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	non-removable;
@@ -118,7 +118,7 @@
 
 &uart0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&uart0_pins_a>;
+	pinctrl-0 = <&uart0_pb_pins>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts b/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts
index 15889639a841..b1fe1226cb1e 100644
--- a/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts
+++ b/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts
@@ -97,7 +97,7 @@
 
 &emac {
 	pinctrl-names = "default";
-	pinctrl-0 = <&emac_pins_b>;
+	pinctrl-0 = <&emac_pa_pins>;
 	phy = <&phy1>;
 	status = "okay";
 };
@@ -118,7 +118,7 @@
 
 &i2c0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&i2c0_pins_a>;
+	pinctrl-0 = <&i2c0_pins>;
 	status = "okay";
 
 	axp152: pmic at 30 {
@@ -131,7 +131,7 @@
 
 &i2c1 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&i2c1_pins_a>;
+	pinctrl-0 = <&i2c1_pins>;
 	status = "okay";
 
 	at24 at 50 {
@@ -144,7 +144,7 @@
 
 &i2c2 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&i2c2_pins_a>;
+	pinctrl-0 = <&i2c2_pins>;
 	status = "okay";
 };
 
@@ -198,7 +198,7 @@
 
 &mmc0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins_a>;
+	pinctrl-0 = <&mmc0_pins>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	cd-gpios = <&pio 6 1 GPIO_ACTIVE_LOW>; /* PG1 */
@@ -207,7 +207,7 @@
 
 &mmc1 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&mmc1_pins_a>;
+	pinctrl-0 = <&mmc1_pins>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	cd-gpios = <&pio 6 13 GPIO_ACTIVE_LOW>; /* PG13 */
@@ -248,8 +248,8 @@
 
 &spi2 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&spi2_pins_b>,
-		    <&spi2_cs0_pins_b>;
+	pinctrl-0 = <&spi2_pb_pins>,
+		    <&spi2_cs0_pb_pin>;
 	status = "okay";
 };
 
@@ -259,19 +259,19 @@
 
 &uart0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&uart0_pins_a>;
+	pinctrl-0 = <&uart0_pb_pins>;
 	status = "okay";
 };
 
 &uart2 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&uart2_pins_b>;
+	pinctrl-0 = <&uart2_pc_pins>;
 	status = "okay";
 };
 
 &uart3 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&uart3_pins_a>;
+	pinctrl-0 = <&uart3_pg_pins>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun5i-a10s-r7-tv-dongle.dts b/arch/arm/boot/dts/sun5i-a10s-r7-tv-dongle.dts
index ba2d2e604d54..a32025e57592 100644
--- a/arch/arm/boot/dts/sun5i-a10s-r7-tv-dongle.dts
+++ b/arch/arm/boot/dts/sun5i-a10s-r7-tv-dongle.dts
@@ -77,7 +77,7 @@
 
 &mmc0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins_a>;
+	pinctrl-0 = <&mmc0_pins>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	cd-gpios = <&pio 6 1 GPIO_ACTIVE_LOW>; /* PG1 */
@@ -86,7 +86,7 @@
 
 &mmc1 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&mmc1_pins_a>;
+	pinctrl-0 = <&mmc1_pins>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	non-removable;
@@ -112,7 +112,7 @@
 
 &uart0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&uart0_pins_a>;
+	pinctrl-0 = <&uart0_pb_pins>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun5i-a10s-wobo-i5.dts b/arch/arm/boot/dts/sun5i-a10s-wobo-i5.dts
index 69581f8c4e8f..5683cc483a49 100644
--- a/arch/arm/boot/dts/sun5i-a10s-wobo-i5.dts
+++ b/arch/arm/boot/dts/sun5i-a10s-wobo-i5.dts
@@ -90,7 +90,7 @@
 
 &emac {
 	pinctrl-names = "default";
-	pinctrl-0 = <&emac_pins_a>;
+	pinctrl-0 = <&emac_pd_pins>;
 	phy = <&phy1>;
 	status = "okay";
 };
@@ -101,7 +101,7 @@
 
 &i2c0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&i2c0_pins_a>;
+	pinctrl-0 = <&i2c0_pins>;
 	status = "okay";
 
 	axp209: pmic at 34 {
@@ -123,7 +123,7 @@
 
 &mmc0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins_a>;
+	pinctrl-0 = <&mmc0_pins>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	cd-gpios = <&pio 1 3 GPIO_ACTIVE_LOW>; /* PB3 */
@@ -184,7 +184,7 @@
 
 &uart0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&uart0_pins_a>;
+	pinctrl-0 = <&uart0_pb_pins>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun5i-a10s.dtsi b/arch/arm/boot/dts/sun5i-a10s.dtsi
index 195a6a1d2c49..7b44a227ba60 100644
--- a/arch/arm/boot/dts/sun5i-a10s.dtsi
+++ b/arch/arm/boot/dts/sun5i-a10s.dtsi
@@ -124,17 +124,17 @@
 &pio {
 	compatible = "allwinner,sun5i-a10s-pinctrl";
 
-	uart0_pins_a: uart0 at 0 {
+	uart0_pb_pins: uart0-pb-pins {
 		pins = "PB19", "PB20";
 		function = "uart0";
 	};
 
-	uart2_pins_b: uart2 at 1 {
+	uart2_pc_pins: uart2-pc-pins {
 		pins = "PC18", "PC19";
 		function = "uart2";
 	};
 
-	emac_pins_b: emac0 at 1 {
+	emac_pa_pins: emac-pa-pins {
 		pins = "PA0", "PA1", "PA2",
 				"PA3", "PA4", "PA5", "PA6",
 				"PA7", "PA8", "PA9", "PA10",
@@ -143,19 +143,19 @@
 		function = "emac";
 	};
 
-	mmc1_pins_a: mmc1 at 0 {
+	mmc1_pins: mmc1-pins {
 		pins = "PG3", "PG4", "PG5",
 				 "PG6", "PG7", "PG8";
 		function = "mmc1";
 		drive-strength = <30>;
 	};
 
-	spi2_pins_b: spi2 at 1 {
+	spi2_pb_pins: spi2-pb-pins {
 		pins = "PB12", "PB13", "PB14";
 		function = "spi2";
 	};
 
-	spi2_cs0_pins_b: spi2_cs0 at 1 {
+	spi2_cs0_pb_pin: spi2-cs0-pb-pin {
 		pins = "PB11";
 		function = "spi2";
 	};
diff --git a/arch/arm/boot/dts/sun5i-a13-empire-electronix-d709.dts b/arch/arm/boot/dts/sun5i-a13-empire-electronix-d709.dts
index 4b892f609240..34c932564daf 100644
--- a/arch/arm/boot/dts/sun5i-a13-empire-electronix-d709.dts
+++ b/arch/arm/boot/dts/sun5i-a13-empire-electronix-d709.dts
@@ -79,7 +79,7 @@
 
 &i2c0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&i2c0_pins_a>;
+	pinctrl-0 = <&i2c0_pins>;
 	status = "okay";
 
 	axp209: pmic at 34 {
@@ -92,7 +92,7 @@
 
 &i2c1 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&i2c1_pins_a>;
+	pinctrl-0 = <&i2c1_pins>;
 	status = "okay";
 
 	pcf8563: rtc at 51 {
@@ -122,7 +122,7 @@
 
 &mmc0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins_a>;
+	pinctrl-0 = <&mmc0_pins>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	cd-gpios = <&pio 6 0 GPIO_ACTIVE_LOW>; /* PG0 */
@@ -149,7 +149,7 @@
 
 &pwm {
 	pinctrl-names = "default";
-	pinctrl-0 = <&pwm0_pins>;
+	pinctrl-0 = <&pwm0_pin>;
 	status = "okay";
 };
 
@@ -191,7 +191,7 @@
 
 &uart1 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&uart1_pins_b>;
+	pinctrl-0 = <&uart1_pg_pins>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun5i-a13-hsg-h702.dts b/arch/arm/boot/dts/sun5i-a13-hsg-h702.dts
index ff845f48c832..4f5b1247a427 100644
--- a/arch/arm/boot/dts/sun5i-a13-hsg-h702.dts
+++ b/arch/arm/boot/dts/sun5i-a13-hsg-h702.dts
@@ -70,7 +70,7 @@
 
 &i2c0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&i2c0_pins_a>;
+	pinctrl-0 = <&i2c0_pins>;
 	status = "okay";
 
 	axp209: pmic at 34 {
@@ -81,7 +81,7 @@
 
 &i2c1 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&i2c1_pins_a>;
+	pinctrl-0 = <&i2c1_pins>;
 	status = "okay";
 
 	pcf8563: rtc at 51 {
@@ -92,7 +92,7 @@
 
 &i2c2 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&i2c2_pins_a>;
+	pinctrl-0 = <&i2c2_pins>;
 	status = "okay";
 };
 
@@ -117,7 +117,7 @@
 
 &mmc0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins_a>;
+	pinctrl-0 = <&mmc0_pins>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	cd-gpios = <&pio 6 0 GPIO_ACTIVE_LOW>; /* PG0 */
@@ -180,7 +180,7 @@
 
 &uart1 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&uart1_pins_b>;
+	pinctrl-0 = <&uart1_pg_pins>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun5i-a13-licheepi-one.dts b/arch/arm/boot/dts/sun5i-a13-licheepi-one.dts
index 93a080e7ba2d..f2ecd81a3183 100644
--- a/arch/arm/boot/dts/sun5i-a13-licheepi-one.dts
+++ b/arch/arm/boot/dts/sun5i-a13-licheepi-one.dts
@@ -95,7 +95,7 @@
 
 &i2c0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&i2c0_pins_a>;
+	pinctrl-0 = <&i2c0_pins>;
 	status = "okay";
 
 	axp209: pmic at 34 {
@@ -110,13 +110,13 @@
 
 &i2c1 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&i2c1_pins_a>;
+	pinctrl-0 = <&i2c1_pins>;
 	status = "disabled";
 };
 
 &i2c2 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&i2c2_pins_a>;
+	pinctrl-0 = <&i2c2_pins>;
 	status = "disabled";
 };
 
@@ -134,7 +134,7 @@
 
 &mmc0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins_a>;
+	pinctrl-0 = <&mmc0_pins>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	broken-cd;
@@ -143,7 +143,7 @@
 
 &mmc2 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&mmc2_4bit_pins_a>;
+	pinctrl-0 = <&mmc2_4bit_pc_pins>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	broken-cd;
@@ -204,7 +204,7 @@
 
 &uart1 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&uart1_pins_b>;
+	pinctrl-0 = <&uart1_pg_pins>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun5i-a13-olinuxino-micro.dts b/arch/arm/boot/dts/sun5i-a13-olinuxino-micro.dts
index 8d104a0395dd..70445d28c20a 100644
--- a/arch/arm/boot/dts/sun5i-a13-olinuxino-micro.dts
+++ b/arch/arm/boot/dts/sun5i-a13-olinuxino-micro.dts
@@ -78,25 +78,25 @@
 
 &i2c0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&i2c0_pins_a>;
+	pinctrl-0 = <&i2c0_pins>;
 	status = "okay";
 };
 
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
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	cd-gpios = <&pio 6 0 GPIO_ACTIVE_LOW>; /* PG0 */
@@ -143,7 +143,7 @@
 
 &uart1 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&uart1_pins_b>;
+	pinctrl-0 = <&uart1_pg_pins>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun5i-a13-olinuxino.dts b/arch/arm/boot/dts/sun5i-a13-olinuxino.dts
index 1703b5379f6b..8855ddb78e0b 100644
--- a/arch/arm/boot/dts/sun5i-a13-olinuxino.dts
+++ b/arch/arm/boot/dts/sun5i-a13-olinuxino.dts
@@ -124,7 +124,7 @@
 
 &i2c0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&i2c0_pins_a>;
+	pinctrl-0 = <&i2c0_pins>;
 	status = "okay";
 
 	axp209: pmic at 34 {
@@ -139,13 +139,13 @@
 
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
 
@@ -191,7 +191,7 @@
 
 &mmc0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins_a>;
+	pinctrl-0 = <&mmc0_pins>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	cd-gpios = <&pio 6 0 GPIO_ACTIVE_LOW>; /* PG0 */
@@ -251,7 +251,7 @@
 
 &uart1 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&uart1_pins_b>;
+	pinctrl-0 = <&uart1_pg_pins>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun5i-a13-utoo-p66.dts b/arch/arm/boot/dts/sun5i-a13-utoo-p66.dts
index 962ec29b1934..31a4b61f1d75 100644
--- a/arch/arm/boot/dts/sun5i-a13-utoo-p66.dts
+++ b/arch/arm/boot/dts/sun5i-a13-utoo-p66.dts
@@ -81,7 +81,7 @@
 
 &mmc2 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&mmc2_pins_a>;
+	pinctrl-0 = <&mmc2_8bit_pins>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <8>;
 	non-removable;
diff --git a/arch/arm/boot/dts/sun5i-gr8-chip-pro.dts b/arch/arm/boot/dts/sun5i-gr8-chip-pro.dts
index 959dd94c7b79..7a5ba22c7354 100644
--- a/arch/arm/boot/dts/sun5i-gr8-chip-pro.dts
+++ b/arch/arm/boot/dts/sun5i-gr8-chip-pro.dts
@@ -93,7 +93,7 @@
 
 &i2c0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&i2c0_pins_a>;
+	pinctrl-0 = <&i2c0_pins>;
 	status = "okay";
 
 	axp209: pmic at 34 {
@@ -113,19 +113,19 @@
 
 &i2c1 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&i2c1_pins_a>;
+	pinctrl-0 = <&i2c1_pins>;
 	status = "disabled";
 };
 
 &i2s0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&i2s0_mclk_pins_a>, <&i2s0_data_pins_a>;
+	pinctrl-0 = <&i2s0_mclk_pin>, <&i2s0_data_pins>;
 	status = "disabled";
 };
 
 &mmc0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins_a>;
+	pinctrl-0 = <&mmc0_pins>;
 	vmmc-supply = <&reg_vcc3v3>;
 	mmc-pwrseq = <&mmc0_pwrseq>;
 	bus-width = <4>;
@@ -135,7 +135,7 @@
 
 &nfc {
 	pinctrl-names = "default";
-	pinctrl-0 = <&nand_pins_a &nand_cs0_pins_a &nand_rb0_pins_a>;
+	pinctrl-0 = <&nand_pins &nand_cs0_pin &nand_rb0_pin>;
 	status = "okay";
 
 	nand at 0 {
@@ -157,7 +157,7 @@
 
 &pwm {
 	pinctrl-names = "default";
-	pinctrl-0 = <&pwm0_pins>, <&pwm1_pins>;
+	pinctrl-0 = <&pwm0_pin>, <&pwm1_pins>;
 	status = "disabled";
 };
 
@@ -206,19 +206,19 @@
 
 &uart1 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&uart1_pins_b>, <&uart1_cts_rts_pins_a>;
+	pinctrl-0 = <&uart1_pg_pins>, <&uart1_cts_rts_pins>;
 	status = "okay";
 };
 
 &uart2 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&uart2_pins_a>, <&uart2_cts_rts_pins_a>;
+	pinctrl-0 = <&uart2_pd_pins>, <&uart2_cts_rts_pd_pins>;
 	status = "disabled";
 };
 
 &uart3 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&uart3_pins_a>, <&uart3_cts_rts_pins_a>;
+	pinctrl-0 = <&uart3_pg_pins>, <&uart3_cts_rts_pg_pins>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun5i-gr8-evb.dts b/arch/arm/boot/dts/sun5i-gr8-evb.dts
index 5196aeff75aa..ea1711a31cce 100644
--- a/arch/arm/boot/dts/sun5i-gr8-evb.dts
+++ b/arch/arm/boot/dts/sun5i-gr8-evb.dts
@@ -124,7 +124,7 @@
 
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
 
 	wm8978: codec at 1a {
@@ -161,19 +161,19 @@
 
 &i2c2 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&i2c2_pins_a>;
+	pinctrl-0 = <&i2c2_pins>;
 	status = "okay";
 };
 
 &i2s0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&i2s0_mclk_pins_a>, <&i2s0_data_pins_a>;
+	pinctrl-0 = <&i2s0_mclk_pin>, <&i2s0_data_pins>;
 	status = "okay";
 };
 
 &ir0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&ir0_rx_pins_a>;
+	pinctrl-0 = <&ir0_rx_pin>;
 	status = "okay";
 };
 
@@ -233,7 +233,7 @@
 
 &mmc0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins_a>;
+	pinctrl-0 = <&mmc0_pins>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	cd-gpios = <&pio 6 0 GPIO_ACTIVE_LOW>; /* PG0 */
@@ -242,7 +242,7 @@
 
 &nfc {
 	pinctrl-names = "default";
-	pinctrl-0 = <&nand_pins_a &nand_cs0_pins_a &nand_rb0_pins_a>;
+	pinctrl-0 = <&nand_pins &nand_cs0_pin &nand_rb0_pin>;
 
 	/* MLC Support sucks for now */
 	status = "disabled";
@@ -258,7 +258,7 @@
 
 &pwm {
 	pinctrl-names = "default";
-	pinctrl-0 = <&pwm0_pins>;
+	pinctrl-0 = <&pwm0_pin>;
 	status = "okay";
 };
 
@@ -298,7 +298,7 @@
 
 &spdif {
 	pinctrl-names = "default";
-	pinctrl-0 = <&spdif_tx_pins_a>;
+	pinctrl-0 = <&spdif_tx_pin>;
 	status = "okay";
 };
 
@@ -308,7 +308,7 @@
 
 &uart1 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&uart1_pins_b>, <&uart1_cts_rts_pins_a>;
+	pinctrl-0 = <&uart1_pg_pins>, <&uart1_cts_rts_pins>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun5i-gr8.dtsi b/arch/arm/boot/dts/sun5i-gr8.dtsi
index d3eea4cfe442..98a8fd5e89e8 100644
--- a/arch/arm/boot/dts/sun5i-gr8.dtsi
+++ b/arch/arm/boot/dts/sun5i-gr8.dtsi
@@ -98,28 +98,28 @@
 &pio {
 	compatible = "nextthing,gr8-pinctrl";
 
-	i2s0_data_pins_a: i2s0-data at 0 {
+	i2s0_data_pins: i2s0-data-pins {
 		pins = "PB6", "PB7", "PB8", "PB9";
 		function = "i2s0";
 	};
 
-	i2s0_mclk_pins_a: i2s0-mclk at 0 {
+	i2s0_mclk_pin: i2s0-mclk-pin {
 		pins = "PB5";
 		function = "i2s0";
 	};
 
-	pwm1_pins: pwm1 {
+	pwm1_pins: pwm1-pin {
 		pins = "PG13";
 		function = "pwm1";
 	};
 
-	spdif_tx_pins_a: spdif at 0 {
+	spdif_tx_pin: spdif-tx-pin {
 		pins = "PB10";
 		function = "spdif";
 		bias-pull-up;
 	};
 
-	uart1_cts_rts_pins_a: uart1-cts-rts at 0 {
+	uart1_cts_rts_pins: uart1-cts-rts-pins {
 		pins = "PG5", "PG6";
 		function = "uart1";
 	};
diff --git a/arch/arm/boot/dts/sun5i-r8-chip.dts b/arch/arm/boot/dts/sun5i-r8-chip.dts
index c97e46e4bb45..a913084c8d20 100644
--- a/arch/arm/boot/dts/sun5i-r8-chip.dts
+++ b/arch/arm/boot/dts/sun5i-r8-chip.dts
@@ -108,7 +108,7 @@
 
 &i2c0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&i2c0_pins_a>;
+	pinctrl-0 = <&i2c0_pins>;
 	status = "okay";
 
 	axp209: pmic at 34 {
@@ -136,13 +136,13 @@
 
 &i2c1 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&i2c1_pins_a>;
+	pinctrl-0 = <&i2c1_pins>;
 	status = "disabled";
 };
 
 &i2c2 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&i2c2_pins_a>;
+	pinctrl-0 = <&i2c2_pins>;
 	status = "okay";
 
 	xio: gpio at 38 {
@@ -159,13 +159,13 @@
 	};
 };
 
-&mmc0_pins_a {
+&mmc0_pins {
 	bias-pull-up;
 };
 
 &mmc0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins_a>;
+	pinctrl-0 = <&mmc0_pins>;
 	vmmc-supply = <&reg_vcc3v3>;
 	mmc-pwrseq = <&mmc0_pwrseq>;
 	bus-width = <4>;
@@ -251,7 +251,7 @@
 
 &spi2 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&spi2_pins_a>;
+	pinctrl-0 = <&spi2_pe_pins>;
 	status = "disabled";
 };
 
@@ -265,14 +265,14 @@
 
 &uart1 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&uart1_pins_b>;
+	pinctrl-0 = <&uart1_pg_pins>;
 	status = "okay";
 };
 
 &uart3 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&uart3_pins_a>,
-		    <&uart3_cts_rts_pins_a>;
+	pinctrl-0 = <&uart3_pg_pins>,
+		    <&uart3_cts_rts_pg_pins>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun5i-reference-design-tablet.dtsi b/arch/arm/boot/dts/sun5i-reference-design-tablet.dtsi
index 12c80be63693..ca7556177c1b 100644
--- a/arch/arm/boot/dts/sun5i-reference-design-tablet.dtsi
+++ b/arch/arm/boot/dts/sun5i-reference-design-tablet.dtsi
@@ -76,6 +76,8 @@
 };
 
 &i2c0 {
+	pinctrl-0 = <&i2c0_pins>;
+
 	axp209: pmic at 34 {
 		reg = <0x34>;
 		interrupts = <0>;
@@ -83,6 +85,8 @@
 };
 
 &i2c1 {
+	pinctrl-0 = <&i2c1_pins>;
+
 	/*
 	 * The gsl1680 is rated at 400KHz and it will not work reliable at
 	 * 100KHz, this has been confirmed on multiple different q8 tablets.
@@ -121,7 +125,7 @@
 
 &mmc0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins_a>;
+	pinctrl-0 = <&mmc0_pins>;
 	vmmc-supply = <&reg_vcc3v0>;
 	bus-width = <4>;
 	cd-gpios = <&pio 6 0 GPIO_ACTIVE_LOW>; /* PG0 */
@@ -146,6 +150,10 @@
 	};
 };
 
+&pwm {
+	pinctrl-0 = <&pwm0_pin>;
+};
+
 &reg_dcdc2 {
 	regulator-always-on;
 	regulator-min-microvolt = <1000000>;
@@ -184,7 +192,7 @@
 
 &uart1 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&uart1_pins_b>;
+	pinctrl-0 = <&uart1_pg_pins>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun5i.dtsi b/arch/arm/boot/dts/sun5i.dtsi
index 4ea6e1867186..acf143317540 100644
--- a/arch/arm/boot/dts/sun5i.dtsi
+++ b/arch/arm/boot/dts/sun5i.dtsi
@@ -440,7 +440,7 @@
 			#interrupt-cells = <3>;
 			#gpio-cells = <3>;
 
-			emac_pins_a: emac0 at 0 {
+			emac_pd_pins: emac-pd-pins {
 				pins = "PD6", "PD7", "PD10",
 				       "PD11", "PD12", "PD13", "PD14",
 				       "PD15", "PD18", "PD19", "PD20",
@@ -449,27 +449,27 @@
 				function = "emac";
 			};
 
-			i2c0_pins_a: i2c0 at 0 {
+			i2c0_pins: i2c0-pins {
 				pins = "PB0", "PB1";
 				function = "i2c0";
 			};
 
-			i2c1_pins_a: i2c1 at 0 {
+			i2c1_pins: i2c1-pins {
 				pins = "PB15", "PB16";
 				function = "i2c1";
 			};
 
-			i2c2_pins_a: i2c2 at 0 {
+			i2c2_pins: i2c2-pins {
 				pins = "PB17", "PB18";
 				function = "i2c2";
 			};
 
-			ir0_rx_pins_a: ir0 at 0 {
+			ir0_rx_pin: ir0-rx-pin {
 				pins = "PB4";
 				function = "ir0";
 			};
 
-			lcd_rgb565_pins: lcd_rgb565 at 0 {
+			lcd_rgb565_pins: lcd-rgb565-pins {
 				pins = "PD3", "PD4", "PD5", "PD6", "PD7",
 						 "PD10", "PD11", "PD12", "PD13", "PD14", "PD15",
 						 "PD19", "PD20", "PD21", "PD22", "PD23",
@@ -477,7 +477,7 @@
 				function = "lcd0";
 			};
 
-			lcd_rgb666_pins: lcd_rgb666 at 0 {
+			lcd_rgb666_pins: lcd-rgb666-pins {
 				pins = "PD2", "PD3", "PD4", "PD5", "PD6", "PD7",
 				       "PD10", "PD11", "PD12", "PD13", "PD14", "PD15",
 				       "PD18", "PD19", "PD20", "PD21", "PD22", "PD23",
@@ -485,7 +485,7 @@
 				function = "lcd0";
 			};
 
-			mmc0_pins_a: mmc0 at 0 {
+			mmc0_pins: mmc0-pins {
 				pins = "PF0", "PF1", "PF2", "PF3",
 				       "PF4", "PF5";
 				function = "mmc0";
@@ -493,7 +493,7 @@
 				bias-pull-up;
 			};
 
-			mmc2_pins_a: mmc2 at 0 {
+			mmc2_8bit_pins: mmc2-8bit-pins {
 				pins = "PC6", "PC7", "PC8", "PC9",
 				       "PC10", "PC11", "PC12", "PC13",
 				       "PC14", "PC15";
@@ -502,7 +502,7 @@
 				bias-pull-up;
 			};
 
-			mmc2_4bit_pins_a: mmc2-4bit at 0 {
+			mmc2_4bit_pc_pins: mmc2-4bit-pc-pins {
 				pins = "PC6", "PC7", "PC8", "PC9",
 				       "PC10", "PC11";
 				function = "mmc2";
@@ -510,7 +510,7 @@
 				bias-pull-up;
 			};
 
-			nand_pins_a: nand-base0 at 0 {
+			nand_pins: nand-pins {
 				pins = "PC0", "PC1", "PC2",
 				       "PC5", "PC8", "PC9", "PC10",
 				       "PC11", "PC12", "PC13", "PC14",
@@ -518,57 +518,57 @@
 				function = "nand0";
 			};
 
-			nand_cs0_pins_a: nand-cs at 0 {
+			nand_cs0_pin: nand-cs0-pin {
 				pins = "PC4";
 				function = "nand0";
 			};
 
-			nand_rb0_pins_a: nand-rb at 0 {
+			nand_rb0_pin: nand-rb0-pin {
 				pins = "PC6";
 				function = "nand0";
 			};
 
-			spi2_pins_a: spi2 at 0 {
+			spi2_pe_pins: spi2-pe-pins {
 				pins = "PE1", "PE2", "PE3";
 				function = "spi2";
 			};
 
-			spi2_cs0_pins_a: spi2-cs0 at 0 {
+			spi2_cs0_pe_pin: spi2-cs0-pe-pin {
 				pins = "PE0";
 				function = "spi2";
 			};
 
-			uart1_pins_a: uart1 at 0 {
+			uart1_pe_pins: uart1-pe-pins {
 				pins = "PE10", "PE11";
 				function = "uart1";
 			};
 
-			uart1_pins_b: uart1 at 1 {
+			uart1_pg_pins: uart1-pg-pins {
 				pins = "PG3", "PG4";
 				function = "uart1";
 			};
 
-			uart2_pins_a: uart2 at 0 {
+			uart2_pd_pins: uart2-pd-pins {
 				pins = "PD2", "PD3";
 				function = "uart2";
 			};
 
-			uart2_cts_rts_pins_a: uart2-cts-rts at 0 {
+			uart2_cts_rts_pd_pins: uart2-cts-rts-pd-pins {
 				pins = "PD4", "PD5";
 				function = "uart2";
 			};
 
-			uart3_pins_a: uart3 at 0 {
+			uart3_pg_pins: uart3-pg-pins {
 				pins = "PG9", "PG10";
 				function = "uart3";
 			};
 
-			uart3_cts_rts_pins_a: uart3-cts-rts at 0 {
+			uart3_cts_rts_pg_pins: uart3-cts-rts-pg-pins {
 				pins = "PG11", "PG12";
 				function = "uart3";
 			};
 
-			pwm0_pins: pwm0 {
+			pwm0_pin: pwm0-pin {
 				pins = "PB2";
 				function = "pwm";
 			};
-- 
git-series 0.9.1
