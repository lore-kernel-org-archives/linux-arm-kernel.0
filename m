From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon,  9 Oct 2017 22:22:50 +0200
Subject: [PATCH v2 1/5] ARM: dts: sun4i: Change pinctrl nodes to avoid warning
In-Reply-To: <cover.e7363fd7884334063590603c0b0de566f66e0c18.1507580565.git-series.maxime.ripard@free-electrons.com>
References: <cover.e7363fd7884334063590603c0b0de566f66e0c18.1507580565.git-series.maxime.ripard@free-electrons.com>
Message-ID: <0a03a4b20bf3375887ac761dd50de7201b4dad8d.1507580565.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All our pinctrl nodes were using a node name convention with a unit-address
to differentiate the different muxing options. However, since those nodes
didn't have a reg property, they were generating warnings in DTC.

In order to accomodate for this, convert the old nodes to the syntax we've
been using for the new SoCs, including removing the letter suffix of the
node labels to the bank of those pins to make things more readable.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun4i-a10-a1000.dts                | 12 +--
 arch/arm/boot/dts/sun4i-a10-ba10-tvbox.dts           | 10 +-
 arch/arm/boot/dts/sun4i-a10-chuwi-v7-cw0825.dts      | 10 +-
 arch/arm/boot/dts/sun4i-a10-cubieboard.dts           | 16 +--
 arch/arm/boot/dts/sun4i-a10-dserve-dsrv9703c.dts     | 12 +--
 arch/arm/boot/dts/sun4i-a10-gemei-g9.dts             |  8 +-
 arch/arm/boot/dts/sun4i-a10-hackberry.dts            |  8 +-
 arch/arm/boot/dts/sun4i-a10-hyundai-a7hd.dts         |  6 +-
 arch/arm/boot/dts/sun4i-a10-inet1.dts                | 12 +--
 arch/arm/boot/dts/sun4i-a10-inet97fv2.dts            | 10 +-
 arch/arm/boot/dts/sun4i-a10-inet9f-rev03.dts         | 10 +-
 arch/arm/boot/dts/sun4i-a10-itead-iteaduino-plus.dts | 21 +++--
 arch/arm/boot/dts/sun4i-a10-jesurun-q5.dts           | 10 +-
 arch/arm/boot/dts/sun4i-a10-marsboard.dts            | 16 +--
 arch/arm/boot/dts/sun4i-a10-mini-xplus.dts           | 10 +-
 arch/arm/boot/dts/sun4i-a10-mk802.dts                |  4 +-
 arch/arm/boot/dts/sun4i-a10-mk802ii.dts              |  6 +-
 arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts       | 10 +-
 arch/arm/boot/dts/sun4i-a10-pcduino.dts              |  8 +-
 arch/arm/boot/dts/sun4i-a10-pov-protab2-ips9.dts     | 12 +--
 arch/arm/boot/dts/sun4i-a10.dtsi                     | 60 ++++++-------
 21 files changed, 139 insertions(+), 132 deletions(-)

diff --git a/arch/arm/boot/dts/sun4i-a10-a1000.dts b/arch/arm/boot/dts/sun4i-a10-a1000.dts
index 16e65aae99e3..769ae7f4dfbb 100644
--- a/arch/arm/boot/dts/sun4i-a10-a1000.dts
+++ b/arch/arm/boot/dts/sun4i-a10-a1000.dts
@@ -126,7 +126,7 @@
 
 &emac {
 	pinctrl-names = "default";
-	pinctrl-0 = <&emac_pins_a>;
+	pinctrl-0 = <&emac_pins>;
 	phy = <&phy1>;
 	status = "okay";
 };
@@ -137,7 +137,7 @@
 
 &i2c0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&i2c0_pins_a>;
+	pinctrl-0 = <&i2c0_pins>;
 	status = "okay";
 
 	axp209: pmic at 34 {
@@ -152,7 +152,7 @@
 
 &ir0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&ir0_rx_pins_a>;
+	pinctrl-0 = <&ir0_rx_pins>;
 	status = "okay";
 };
 
@@ -167,7 +167,7 @@
 
 &mmc0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins_a>;
+	pinctrl-0 = <&mmc0_pins>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	cd-gpios = <&pio 7 1 GPIO_ACTIVE_HIGH>; /* PH1 */
@@ -220,13 +220,13 @@
 
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
 
diff --git a/arch/arm/boot/dts/sun4i-a10-ba10-tvbox.dts b/arch/arm/boot/dts/sun4i-a10-ba10-tvbox.dts
index 97f2cd1c2932..64a67b954d2a 100644
--- a/arch/arm/boot/dts/sun4i-a10-ba10-tvbox.dts
+++ b/arch/arm/boot/dts/sun4i-a10-ba10-tvbox.dts
@@ -69,7 +69,7 @@
 
 &emac {
 	pinctrl-names = "default";
-	pinctrl-0 = <&emac_pins_a>;
+	pinctrl-0 = <&emac_pins>;
 	phy = <&phy1>;
 	status = "okay";
 };
@@ -80,7 +80,7 @@
 
 &i2c0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&i2c0_pins_a>;
+	pinctrl-0 = <&i2c0_pins>;
 	status = "okay";
 
 	axp209: pmic at 34 {
@@ -95,7 +95,7 @@
 
 &ir0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&ir0_rx_pins_a>;
+	pinctrl-0 = <&ir0_rx_pins>;
 	status = "okay";
 };
 
@@ -109,7 +109,7 @@
 
 &mmc0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins_a>;
+	pinctrl-0 = <&mmc0_pins>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	cd-gpios = <&pio 7 1 GPIO_ACTIVE_HIGH>; /* PH1 */
@@ -141,7 +141,7 @@
 
 &uart0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&uart0_pins_a>;
+	pinctrl-0 = <&uart0_pb_pins>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun4i-a10-chuwi-v7-cw0825.dts b/arch/arm/boot/dts/sun4i-a10-chuwi-v7-cw0825.dts
index 68f68e74910f..1afbf6bc8b7d 100644
--- a/arch/arm/boot/dts/sun4i-a10-chuwi-v7-cw0825.dts
+++ b/arch/arm/boot/dts/sun4i-a10-chuwi-v7-cw0825.dts
@@ -66,7 +66,7 @@
 
 &i2c0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&i2c0_pins_a>;
+	pinctrl-0 = <&i2c0_pins>;
 	status = "okay";
 
 	axp209: pmic at 34 {
@@ -81,13 +81,13 @@
 
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
 
 	ft5306de4: touchscreen at 38 {
@@ -128,7 +128,7 @@
 
 &mmc0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins_a>;
+	pinctrl-0 = <&mmc0_pins>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	cd-gpios = <&pio 7 1 GPIO_ACTIVE_HIGH>; /* PH1 */
@@ -164,7 +164,7 @@
 
 &uart0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&uart0_pins_a>;
+	pinctrl-0 = <&uart0_pb_pins>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun4i-a10-cubieboard.dts b/arch/arm/boot/dts/sun4i-a10-cubieboard.dts
index 404ce7694899..d240209bfe85 100644
--- a/arch/arm/boot/dts/sun4i-a10-cubieboard.dts
+++ b/arch/arm/boot/dts/sun4i-a10-cubieboard.dts
@@ -100,7 +100,7 @@
 
 &emac {
 	pinctrl-names = "default";
-	pinctrl-0 = <&emac_pins_a>;
+	pinctrl-0 = <&emac_pins>;
 	phy = <&phy1>;
 	status = "okay";
 };
@@ -111,7 +111,7 @@
 
 &i2c0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&i2c0_pins_a>;
+	pinctrl-0 = <&i2c0_pins>;
 	status = "okay";
 
 	axp209: pmic at 34 {
@@ -122,13 +122,13 @@
 
 &i2c1 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&i2c1_pins_a>;
+	pinctrl-0 = <&i2c1_pins>;
 	status = "okay";
 };
 
 &ir0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&ir0_rx_pins_a>;
+	pinctrl-0 = <&ir0_rx_pins>;
 	status = "okay";
 };
 
@@ -142,7 +142,7 @@
 
 &mmc0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins_a>;
+	pinctrl-0 = <&mmc0_pins>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	cd-gpios = <&pio 7 1 GPIO_ACTIVE_HIGH>; /* PH1 */
@@ -221,14 +221,14 @@
 
 &spi0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&spi0_pins_a>,
-		    <&spi0_cs0_pins_a>;
+	pinctrl-0 = <&spi0_pi_pins>,
+		    <&spi0_cs0_pi_pin>;
 	status = "okay";
 };
 
 &uart0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&uart0_pins_a>;
+	pinctrl-0 = <&uart0_pb_pins>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun4i-a10-dserve-dsrv9703c.dts b/arch/arm/boot/dts/sun4i-a10-dserve-dsrv9703c.dts
index f3d0435fa7d1..e527b86de8c6 100644
--- a/arch/arm/boot/dts/sun4i-a10-dserve-dsrv9703c.dts
+++ b/arch/arm/boot/dts/sun4i-a10-dserve-dsrv9703c.dts
@@ -100,7 +100,7 @@
 
 &i2c0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&i2c0_pins_a>;
+	pinctrl-0 = <&i2c0_pins>;
 	status = "okay";
 
 	axp209: pmic at 34 {
@@ -113,14 +113,14 @@
 
 &i2c1 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&i2c1_pins_a>;
+	pinctrl-0 = <&i2c1_pins>;
 	/* pull-ups and devices require AXP209 LDO3 */
 	status = "failed";
 };
 
 &i2c2 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&i2c2_pins_a>;
+	pinctrl-0 = <&i2c2_pins>;
 	status = "okay";
 
 	ft5406ee8: touchscreen at 38 {
@@ -155,7 +155,7 @@
 
 &mmc0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins_a>;
+	pinctrl-0 = <&mmc0_pins>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	cd-gpios = <&pio 7 1 GPIO_ACTIVE_HIGH>; /* PH1 */
@@ -183,7 +183,7 @@
 
 &pwm {
 	pinctrl-names = "default";
-	pinctrl-0 = <&pwm0_pins_a>;
+	pinctrl-0 = <&pwm0_pin>;
 	status = "okay";
 };
 
@@ -222,7 +222,7 @@
 
 &uart0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&uart0_pins_a>;
+	pinctrl-0 = <&uart0_pb_pins>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun4i-a10-gemei-g9.dts b/arch/arm/boot/dts/sun4i-a10-gemei-g9.dts
index d97085c47001..de78e28ecb84 100644
--- a/arch/arm/boot/dts/sun4i-a10-gemei-g9.dts
+++ b/arch/arm/boot/dts/sun4i-a10-gemei-g9.dts
@@ -90,7 +90,7 @@
 
 &i2c0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&i2c0_pins_a>;
+	pinctrl-0 = <&i2c0_pins>;
 	status = "okay";
 
 	axp209: pmic at 34 {
@@ -103,7 +103,7 @@
 
 &i2c1 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&i2c1_pins_a>;
+	pinctrl-0 = <&i2c1_pins>;
 	status = "okay";
 
 	/* Accelerometer */
@@ -144,7 +144,7 @@
 
 &mmc0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins_a>;
+	pinctrl-0 = <&mmc0_pins>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	cd-gpios = <&pio 7 1 GPIO_ACTIVE_HIGH>; /* PH01 */
@@ -188,7 +188,7 @@
 
 &uart0  {
 	pinctrl-names = "default";
-	pinctrl-0 = <&uart0_pins_a>;
+	pinctrl-0 = <&uart0_pb_pins>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun4i-a10-hackberry.dts b/arch/arm/boot/dts/sun4i-a10-hackberry.dts
index 872163c9e209..e59ae6085870 100644
--- a/arch/arm/boot/dts/sun4i-a10-hackberry.dts
+++ b/arch/arm/boot/dts/sun4i-a10-hackberry.dts
@@ -81,7 +81,7 @@
 
 &emac {
 	pinctrl-names = "default";
-	pinctrl-0 = <&emac_pins_a>;
+	pinctrl-0 = <&emac_pins>;
 	phy = <&phy0>;
 	status = "okay";
 };
@@ -92,7 +92,7 @@
 
 &ir0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&ir0_rx_pins_a>;
+	pinctrl-0 = <&ir0_rx_pins>;
 	status = "okay";
 };
 
@@ -107,7 +107,7 @@
 
 &mmc0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins_a>;
+	pinctrl-0 = <&mmc0_pins>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	cd-gpios = <&pio 7 1 GPIO_ACTIVE_HIGH>; /* PH1 */
@@ -140,6 +140,6 @@
 
 &uart0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&uart0_pins_a>;
+	pinctrl-0 = <&uart0_pb_pins>;
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/sun4i-a10-hyundai-a7hd.dts b/arch/arm/boot/dts/sun4i-a10-hyundai-a7hd.dts
index 6506595268b2..0c4437f0ef5c 100644
--- a/arch/arm/boot/dts/sun4i-a10-hyundai-a7hd.dts
+++ b/arch/arm/boot/dts/sun4i-a10-hyundai-a7hd.dts
@@ -64,7 +64,7 @@
 
 &i2c0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&i2c0_pins_a>;
+	pinctrl-0 = <&i2c0_pins>;
 	status = "okay";
 
 	axp209: pmic at 34 {
@@ -79,7 +79,7 @@
 
 &mmc0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins_a>;
+	pinctrl-0 = <&mmc0_pins>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	cd-gpios = <&pio 7 1 GPIO_ACTIVE_HIGH>; /* PH1 */
@@ -116,7 +116,7 @@
 
 &uart0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&uart0_pins_a>;
+	pinctrl-0 = <&uart0_pb_pins>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun4i-a10-inet1.dts b/arch/arm/boot/dts/sun4i-a10-inet1.dts
index 7b3ebc354ac3..1f69d69ee266 100644
--- a/arch/arm/boot/dts/sun4i-a10-inet1.dts
+++ b/arch/arm/boot/dts/sun4i-a10-inet1.dts
@@ -87,7 +87,7 @@
 
 &i2c0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&i2c0_pins_a>;
+	pinctrl-0 = <&i2c0_pins>;
 	status = "okay";
 
 	axp209: pmic at 34 {
@@ -100,7 +100,7 @@
 
 &i2c1 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&i2c1_pins_a>;
+	pinctrl-0 = <&i2c1_pins>;
 	status = "okay";
 
 	/* Accelerometer */
@@ -114,7 +114,7 @@
 
 &i2c2 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&i2c2_pins_a>;
+	pinctrl-0 = <&i2c2_pins>;
 	status = "okay";
 
 	ft5x: touchscreen at 38 {
@@ -157,7 +157,7 @@
 
 &mmc0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins_a>;
+	pinctrl-0 = <&mmc0_pins>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	cd-gpios = <&pio 7 1 GPIO_ACTIVE_HIGH>; /* PH1 */
@@ -189,7 +189,7 @@
 
 &pwm {
 	pinctrl-names = "default";
-	pinctrl-0 = <&pwm0_pins_a>;
+	pinctrl-0 = <&pwm0_pin>;
 	status = "okay";
 };
 
@@ -232,7 +232,7 @@
 
 &uart0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&uart0_pins_a>;
+	pinctrl-0 = <&uart0_pb_pins>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun4i-a10-inet97fv2.dts b/arch/arm/boot/dts/sun4i-a10-inet97fv2.dts
index f1b79a5ecb27..ab3a8071c45f 100644
--- a/arch/arm/boot/dts/sun4i-a10-inet97fv2.dts
+++ b/arch/arm/boot/dts/sun4i-a10-inet97fv2.dts
@@ -73,7 +73,7 @@
 
 &i2c0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&i2c0_pins_a>;
+	pinctrl-0 = <&i2c0_pins>;
 	status = "okay";
 
 	axp209: pmic at 34 {
@@ -86,13 +86,13 @@
 
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
 
 	ft5406ee8: touchscreen at 38 {
@@ -147,7 +147,7 @@
 
 &mmc0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins_a>;
+	pinctrl-0 = <&mmc0_pins>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	cd-gpios = <&pio 7 1 GPIO_ACTIVE_HIGH>; /* PH1 */
@@ -208,7 +208,7 @@
 
 &uart0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&uart0_pins_a>;
+	pinctrl-0 = <&uart0_pb_pins>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun4i-a10-inet9f-rev03.dts b/arch/arm/boot/dts/sun4i-a10-inet9f-rev03.dts
index 4fa5de28edde..c9498d93dde8 100644
--- a/arch/arm/boot/dts/sun4i-a10-inet9f-rev03.dts
+++ b/arch/arm/boot/dts/sun4i-a10-inet9f-rev03.dts
@@ -223,7 +223,7 @@
 
 &i2c0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&i2c0_pins_a>;
+	pinctrl-0 = <&i2c0_pins>;
 	status = "okay";
 
 	axp209: pmic at 34 {
@@ -236,7 +236,7 @@
 
 &i2c1 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&i2c1_pins_a>;
+	pinctrl-0 = <&i2c1_pins>;
 	status = "okay";
 
 	/* Accelerometer */
@@ -250,7 +250,7 @@
 
 &i2c2 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&i2c2_pins_a>;
+	pinctrl-0 = <&i2c2_pins>;
 	status = "okay";
 
 	ft5406ee8: touchscreen at 38 {
@@ -305,7 +305,7 @@
 
 &mmc0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins_a>;
+	pinctrl-0 = <&mmc0_pins>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	cd-gpios = <&pio 7 1 GPIO_ACTIVE_HIGH>; /* PH1 */
@@ -376,7 +376,7 @@
 
 &uart0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&uart0_pins_a>;
+	pinctrl-0 = <&uart0_pb_pins>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun4i-a10-itead-iteaduino-plus.dts b/arch/arm/boot/dts/sun4i-a10-itead-iteaduino-plus.dts
index 92e3e030ced3..d22bd79562d8 100644
--- a/arch/arm/boot/dts/sun4i-a10-itead-iteaduino-plus.dts
+++ b/arch/arm/boot/dts/sun4i-a10-itead-iteaduino-plus.dts
@@ -57,7 +57,7 @@
 
 &emac {
 	pinctrl-names = "default";
-	pinctrl-0 = <&emac_pins_a>;
+	pinctrl-0 = <&emac_pins>;
 	phy = <&phy1>;
 	status = "okay";
 };
@@ -67,6 +67,9 @@
 };
 
 &i2c0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c0_pins>;
+
 	axp209: pmic at 34 {
 		interrupts = <0>;
 	};
@@ -74,19 +77,19 @@
 
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
+	pinctrl-0 = <&ir0_rx_pins>;
 	status = "okay";
 };
 
@@ -100,7 +103,7 @@
 
 &mmc0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins_a>;
+	pinctrl-0 = <&mmc0_pins>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	cd-gpios = <&pio 7 1 GPIO_ACTIVE_HIGH>; /* PH1 */
@@ -114,7 +117,11 @@
 
 &spi0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&spi0_pins_a>,
-		    <&spi0_cs0_pins_a>;
+	pinctrl-0 = <&spi0_pi_pins>,
+		    <&spi0_cs0_pi_pin>;
 	status = "okay";
 };
+
+&uart0 {
+	pinctrl-0 = <&uart0_pb_pins>;
+};
diff --git a/arch/arm/boot/dts/sun4i-a10-jesurun-q5.dts b/arch/arm/boot/dts/sun4i-a10-jesurun-q5.dts
index 3880b38ce80b..6558cd7dda10 100644
--- a/arch/arm/boot/dts/sun4i-a10-jesurun-q5.dts
+++ b/arch/arm/boot/dts/sun4i-a10-jesurun-q5.dts
@@ -95,7 +95,7 @@
 
 &emac {
 	pinctrl-names = "default";
-	pinctrl-0 = <&emac_pins_a>;
+	pinctrl-0 = <&emac_pins>;
 	phy = <&phy1>;
 	status = "okay";
 };
@@ -106,7 +106,7 @@
 
 &i2c0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&i2c0_pins_a>;
+	pinctrl-0 = <&i2c0_pins>;
 	status = "okay";
 
 	axp209: pmic at 34 {
@@ -121,7 +121,7 @@
 
 &ir0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&ir0_rx_pins_a>;
+	pinctrl-0 = <&ir0_rx_pins>;
 	status = "okay";
 };
 
@@ -136,7 +136,7 @@
 
 &mmc0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins_a>;
+	pinctrl-0 = <&mmc0_pins>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	cd-gpios = <&pio 7 1 GPIO_ACTIVE_HIGH>; /* PH1 */
@@ -171,7 +171,7 @@
 
 &uart0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&uart0_pins_a>;
+	pinctrl-0 = <&uart0_pb_pins>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun4i-a10-marsboard.dts b/arch/arm/boot/dts/sun4i-a10-marsboard.dts
index cba8a1b3cc54..fb98c2a290c9 100644
--- a/arch/arm/boot/dts/sun4i-a10-marsboard.dts
+++ b/arch/arm/boot/dts/sun4i-a10-marsboard.dts
@@ -106,26 +106,26 @@
 
 &emac {
 	pinctrl-names = "default";
-	pinctrl-0 = <&emac_pins_a>;
+	pinctrl-0 = <&emac_pins>;
 	phy = <&phy1>;
 	status = "okay";
 };
 
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
 
@@ -139,7 +139,7 @@
 
 &mmc0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins_a>;
+	pinctrl-0 = <&mmc0_pins>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	cd-gpios = <&pio 7 1 GPIO_ACTIVE_HIGH>; /* PH1 */
@@ -177,14 +177,14 @@
 
 &spi0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&spi0_pins_a>,
-		    <&spi0_cs0_pins_a>;
+	pinctrl-0 = <&spi0_pi_pins>,
+		    <&spi0_cs0_pi_pin>;
 	status = "okay";
 };
 
 &uart0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&uart0_pins_a>;
+	pinctrl-0 = <&uart0_pb_pins>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun4i-a10-mini-xplus.dts b/arch/arm/boot/dts/sun4i-a10-mini-xplus.dts
index a5ed9e4e22c6..3d3992d02b0e 100644
--- a/arch/arm/boot/dts/sun4i-a10-mini-xplus.dts
+++ b/arch/arm/boot/dts/sun4i-a10-mini-xplus.dts
@@ -71,7 +71,7 @@
 
 &i2c0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&i2c0_pins_a>;
+	pinctrl-0 = <&i2c0_pins>;
 	status = "okay";
 
 	axp209: pmic at 34 {
@@ -86,18 +86,18 @@
 
 &ir0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&ir0_rx_pins_a>;
+	pinctrl-0 = <&ir0_rx_pins>;
 	status = "okay";
 };
 
-&ir0_rx_pins_a {
+&ir0_rx_pins {
 	/* The ir receiver is not always populated */
 	bias-pull-up;
 };
 
 &mmc0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins_a>;
+	pinctrl-0 = <&mmc0_pins>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	cd-gpios = <&pio 7 1 GPIO_ACTIVE_HIGH>; /* PH1 */
@@ -132,7 +132,7 @@
 
 &uart0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&uart0_pins_a>;
+	pinctrl-0 = <&uart0_pb_pins>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun4i-a10-mk802.dts b/arch/arm/boot/dts/sun4i-a10-mk802.dts
index c4bc51316b03..112f14aba3d1 100644
--- a/arch/arm/boot/dts/sun4i-a10-mk802.dts
+++ b/arch/arm/boot/dts/sun4i-a10-mk802.dts
@@ -72,7 +72,7 @@
 
 &mmc0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins_a>;
+	pinctrl-0 = <&mmc0_pins>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	cd-gpios = <&pio 7 1 GPIO_ACTIVE_HIGH>; /* PH1 */
@@ -103,7 +103,7 @@
 
 &uart0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&uart0_pins_a>;
+	pinctrl-0 = <&uart0_pb_pins>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun4i-a10-mk802ii.dts b/arch/arm/boot/dts/sun4i-a10-mk802ii.dts
index e74a881fd9a7..e86e765070d4 100644
--- a/arch/arm/boot/dts/sun4i-a10-mk802ii.dts
+++ b/arch/arm/boot/dts/sun4i-a10-mk802ii.dts
@@ -68,7 +68,7 @@
 
 &i2c0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&i2c0_pins_a>;
+	pinctrl-0 = <&i2c0_pins>;
 	status = "okay";
 
 	axp209: pmic at 34 {
@@ -83,7 +83,7 @@
 
 &mmc0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins_a>;
+	pinctrl-0 = <&mmc0_pins>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	cd-gpios = <&pio 7 1 GPIO_ACTIVE_HIGH>; /* PH1 */
@@ -105,7 +105,7 @@
 
 &uart0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&uart0_pins_a>;
+	pinctrl-0 = <&uart0_pb_pins>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts b/arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts
index 40e9aa8f075f..855627142f32 100644
--- a/arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts
+++ b/arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts
@@ -99,7 +99,7 @@
 
 &emac {
 	pinctrl-names = "default";
-	pinctrl-0 = <&emac_pins_a>;
+	pinctrl-0 = <&emac_pins>;
 	phy = <&phy1>;
 	status = "okay";
 };
@@ -110,7 +110,7 @@
 
 &i2c0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&i2c0_pins_a>;
+	pinctrl-0 = <&i2c0_pins>;
 	status = "okay";
 
 	axp209: pmic at 34 {
@@ -125,7 +125,7 @@
 
 &i2c1 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&i2c1_pins_a>;
+	pinctrl-0 = <&i2c1_pins>;
 	status = "okay";
 
 	eeprom: eeprom at 50 {
@@ -145,7 +145,7 @@
 
 &mmc0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins_a>;
+	pinctrl-0 = <&mmc0_pins>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	cd-gpios = <&pio 7 1 GPIO_ACTIVE_HIGH>; /* PH1 */
@@ -204,7 +204,7 @@
 
 &uart0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&uart0_pins_a>;
+	pinctrl-0 = <&uart0_pb_pins>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun4i-a10-pcduino.dts b/arch/arm/boot/dts/sun4i-a10-pcduino.dts
index cbc39609c332..fc74c0924163 100644
--- a/arch/arm/boot/dts/sun4i-a10-pcduino.dts
+++ b/arch/arm/boot/dts/sun4i-a10-pcduino.dts
@@ -113,7 +113,7 @@
 
 &emac {
 	pinctrl-names = "default";
-	pinctrl-0 = <&emac_pins_a>;
+	pinctrl-0 = <&emac_pins>;
 	phy = <&phy1>;
 	status = "okay";
 };
@@ -124,7 +124,7 @@
 
 &i2c0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&i2c0_pins_a>;
+	pinctrl-0 = <&i2c0_pins>;
 	status = "okay";
 
 	axp209: pmic at 34 {
@@ -143,7 +143,7 @@
 
 &mmc0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins_a>;
+	pinctrl-0 = <&mmc0_pins>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	cd-gpios = <&pio 7 1 GPIO_ACTIVE_HIGH>; /* PH1 */
@@ -200,7 +200,7 @@
 
 &uart0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&uart0_pins_a>;
+	pinctrl-0 = <&uart0_pb_pins>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun4i-a10-pov-protab2-ips9.dts b/arch/arm/boot/dts/sun4i-a10-pov-protab2-ips9.dts
index 1385a20f2329..660ea9ce6c01 100644
--- a/arch/arm/boot/dts/sun4i-a10-pov-protab2-ips9.dts
+++ b/arch/arm/boot/dts/sun4i-a10-pov-protab2-ips9.dts
@@ -84,7 +84,7 @@
 
 &i2c0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&i2c0_pins_a>;
+	pinctrl-0 = <&i2c0_pins>;
 	status = "okay";
 
 	axp209: pmic at 34 {
@@ -97,14 +97,14 @@
 
 &i2c1 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&i2c1_pins_a>;
+	pinctrl-0 = <&i2c1_pins>;
 	/* pull-ups and devices require AXP209 LDO3 */
 	status = "failed";
 };
 
 &i2c2 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&i2c2_pins_a>;
+	pinctrl-0 = <&i2c2_pins>;
 	status = "okay";
 
 	pixcir_ts at 5c {
@@ -143,7 +143,7 @@
 
 &mmc0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins_a>;
+	pinctrl-0 = <&mmc0_pins>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	cd-gpios = <&pio 7 1 GPIO_ACTIVE_HIGH>; /* PH1 */
@@ -171,7 +171,7 @@
 
 &pwm {
 	pinctrl-names = "default";
-	pinctrl-0 = <&pwm0_pins_a>;
+	pinctrl-0 = <&pwm0_pin>;
 	status = "okay";
 };
 
@@ -210,7 +210,7 @@
 
 &uart0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&uart0_pins_a>;
+	pinctrl-0 = <&uart0_pb_pins>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
index 54303dd3a310..e6fed58ac364 100644
--- a/arch/arm/boot/dts/sun4i-a10.dtsi
+++ b/arch/arm/boot/dts/sun4i-a10.dtsi
@@ -470,12 +470,12 @@
 			#interrupt-cells = <3>;
 			#gpio-cells = <3>;
 
-			can0_pins_a: can0 at 0 {
+			can0_ph_pins: can0-ph-pins {
 				pins = "PH20", "PH21";
 				function = "can";
 			};
 
-			emac_pins_a: emac0 at 0 {
+			emac_pins: emac0-pins {
 				pins = "PA0", "PA1", "PA2",
 				       "PA3", "PA4", "PA5", "PA6",
 				       "PA7", "PA8", "PA9", "PA10",
@@ -484,42 +484,42 @@
 				function = "emac";
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
 
-			ir0_rx_pins_a: ir0 at 0 {
+			ir0_rx_pins: ir0-rx-pin {
 				pins = "PB4";
 				function = "ir0";
 			};
 
-			ir0_tx_pins_a: ir0 at 1 {
+			ir0_tx_pins: ir0-tx-pin {
 				pins = "PB3";
 				function = "ir0";
 			};
 
-			ir1_rx_pins_a: ir1 at 0 {
+			ir1_rx_pins: ir1-rx-pin {
 				pins = "PB23";
 				function = "ir1";
 			};
 
-			ir1_tx_pins_a: ir1 at 1 {
+			ir1_tx_pins: ir1-tx-pin {
 				pins = "PB22";
 				function = "ir1";
 			};
 
-			mmc0_pins_a: mmc0 at 0 {
+			mmc0_pins: mmc0-pins {
 				pins = "PF0", "PF1", "PF2",
 				       "PF3", "PF4", "PF5";
 				function = "mmc0";
@@ -527,83 +527,83 @@
 				bias-pull-up;
 			};
 
-			ps20_pins_a: ps20 at 0 {
+			ps2_ch0_pins: ps2-ch0-pins {
 				pins = "PI20", "PI21";
 				function = "ps2";
 			};
 
-			ps21_pins_a: ps21 at 0 {
+			ps2_ch1_ph_pins: ps2-ch1-ph-pins {
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
 
-			spi1_pins_a: spi1 at 0 {
+			spi1_pins: spi1-pins {
 				pins = "PI17", "PI18", "PI19";
 				function = "spi1";
 			};
 
-			spi1_cs0_pins_a: spi1_cs0 at 0 {
+			spi1_cs0_pin: spi1-cs0-pin {
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
+			spi2_pc_pins: spi2-pc-pins {
+				pins = "PC20", "PC21", "PC22";
 				function = "spi2";
 			};
 
-			spi2_cs0_pins_a: spi2_cs0 at 0 {
-				pins = "PC19";
+			spi2_cs0_pb_pin: spi2-cs0-pb-pin {
+				pins = "PB14";
 				function = "spi2";
 			};
 
-			spi2_cs0_pins_b: spi2_cs0 at 1 {
-				pins = "PB14";
+			spi2_cs0_pc_pins: spi2-cs0-pc-pin {
+				pins = "PC19";
 				function = "spi2";
 			};
 
-			uart0_pins_a: uart0 at 0 {
+			uart0_pb_pins: uart0-pb-pins {
 				pins = "PB22", "PB23";
 				function = "uart0";
 			};
 
-			uart0_pins_b: uart0 at 1 {
+			uart0_pf_pins: uart0-pf-pins {
 				pins = "PF2", "PF4";
 				function = "uart0";
 			};
 
-			uart1_pins_a: uart1 at 0 {
+			uart1_pins: uart1-pins {
 				pins = "PA10", "PA11";
 				function = "uart1";
 			};
-- 
git-series 0.9.1
