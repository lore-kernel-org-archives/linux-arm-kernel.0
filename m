From: tuomas@tuxera.com (Tuomas Tynkkynen)
Date: Fri, 22 Dec 2017 22:57:37 +0200
Subject: [PATCH 1/2] ARM: dts: sunxi: Switch MMC nodes away from cd-inverted
 property
Message-ID: <20171222205738.2389-1-tuomas@tuxera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Using the cd-inverted property is not useful when GPIOs are used as card
detects since the polarity can be specified with the usual
GPIO_ACTIVE_(HIGH|LOW) GPIO flags. It has also caused confusion for
U-Boot developers, so migrate all sunxi boards away from cd-inverted.

Signed-off-by: Tuomas Tynkkynen <tuomas@tuxera.com>
---
Tested on Pcduino3 Nano.

 arch/arm/boot/dts/sun4i-a10-a1000.dts                    | 3 +--
 arch/arm/boot/dts/sun4i-a10-ba10-tvbox.dts               | 3 +--
 arch/arm/boot/dts/sun4i-a10-chuwi-v7-cw0825.dts          | 3 +--
 arch/arm/boot/dts/sun4i-a10-cubieboard.dts               | 3 +--
 arch/arm/boot/dts/sun4i-a10-dserve-dsrv9703c.dts         | 3 +--
 arch/arm/boot/dts/sun4i-a10-gemei-g9.dts                 | 3 +--
 arch/arm/boot/dts/sun4i-a10-hackberry.dts                | 3 +--
 arch/arm/boot/dts/sun4i-a10-hyundai-a7hd.dts             | 3 +--
 arch/arm/boot/dts/sun4i-a10-inet1.dts                    | 3 +--
 arch/arm/boot/dts/sun4i-a10-inet97fv2.dts                | 3 +--
 arch/arm/boot/dts/sun4i-a10-inet9f-rev03.dts             | 3 +--
 arch/arm/boot/dts/sun4i-a10-itead-iteaduino-plus.dts     | 3 +--
 arch/arm/boot/dts/sun4i-a10-jesurun-q5.dts               | 3 +--
 arch/arm/boot/dts/sun4i-a10-marsboard.dts                | 3 +--
 arch/arm/boot/dts/sun4i-a10-mini-xplus.dts               | 3 +--
 arch/arm/boot/dts/sun4i-a10-mk802.dts                    | 3 +--
 arch/arm/boot/dts/sun4i-a10-mk802ii.dts                  | 3 +--
 arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts           | 3 +--
 arch/arm/boot/dts/sun4i-a10-pcduino.dts                  | 3 +--
 arch/arm/boot/dts/sun4i-a10-pov-protab2-ips9.dts         | 3 +--
 arch/arm/boot/dts/sun5i-a10s-auxtek-t003.dts             | 3 +--
 arch/arm/boot/dts/sun5i-a10s-auxtek-t004.dts             | 3 +--
 arch/arm/boot/dts/sun5i-a10s-mk802.dts                   | 3 +--
 arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts         | 6 ++----
 arch/arm/boot/dts/sun5i-a10s-r7-tv-dongle.dts            | 3 +--
 arch/arm/boot/dts/sun5i-a10s-wobo-i5.dts                 | 3 +--
 arch/arm/boot/dts/sun5i-a13-empire-electronix-d709.dts   | 3 +--
 arch/arm/boot/dts/sun5i-a13-hsg-h702.dts                 | 3 +--
 arch/arm/boot/dts/sun5i-a13-olinuxino-micro.dts          | 3 +--
 arch/arm/boot/dts/sun5i-a13-olinuxino.dts                | 3 +--
 arch/arm/boot/dts/sun5i-gr8-evb.dts                      | 3 +--
 arch/arm/boot/dts/sun5i-reference-design-tablet.dtsi     | 3 +--
 arch/arm/boot/dts/sun6i-a31-colombus.dts                 | 3 +--
 arch/arm/boot/dts/sun6i-a31-hummingbird.dts              | 3 +--
 arch/arm/boot/dts/sun6i-a31-i7.dts                       | 3 +--
 arch/arm/boot/dts/sun6i-a31-m9.dts                       | 3 +--
 arch/arm/boot/dts/sun6i-a31-mele-a1000g-quad.dts         | 3 +--
 arch/arm/boot/dts/sun6i-a31s-primo81.dts                 | 3 +--
 arch/arm/boot/dts/sun6i-a31s-sina31s.dts                 | 3 +--
 arch/arm/boot/dts/sun6i-a31s-sinovoip-bpi-m2.dts         | 3 +--
 arch/arm/boot/dts/sun6i-a31s-yones-toptech-bs1078-v2.dts | 3 +--
 arch/arm/boot/dts/sun6i-reference-design-tablet.dtsi     | 3 +--
 arch/arm/boot/dts/sun7i-a20-bananapi-m1-plus.dts         | 3 +--
 arch/arm/boot/dts/sun7i-a20-bananapi.dts                 | 3 +--
 arch/arm/boot/dts/sun7i-a20-bananapro.dts                | 3 +--
 arch/arm/boot/dts/sun7i-a20-cubieboard2.dts              | 3 +--
 arch/arm/boot/dts/sun7i-a20-cubietruck.dts               | 3 +--
 arch/arm/boot/dts/sun7i-a20-hummingbird.dts              | 3 +--
 arch/arm/boot/dts/sun7i-a20-i12-tvbox.dts                | 3 +--
 arch/arm/boot/dts/sun7i-a20-icnova-swac.dts              | 3 +--
 arch/arm/boot/dts/sun7i-a20-itead-ibox.dts               | 3 +--
 arch/arm/boot/dts/sun7i-a20-lamobo-r1.dts                | 3 +--
 arch/arm/boot/dts/sun7i-a20-m3.dts                       | 3 +--
 arch/arm/boot/dts/sun7i-a20-mk808c.dts                   | 3 +--
 arch/arm/boot/dts/sun7i-a20-olimex-som-evb.dts           | 6 ++----
 arch/arm/boot/dts/sun7i-a20-olinuxino-lime.dts           | 3 +--
 arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts          | 3 +--
 arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts          | 6 ++----
 arch/arm/boot/dts/sun7i-a20-orangepi-mini.dts            | 6 ++----
 arch/arm/boot/dts/sun7i-a20-orangepi.dts                 | 3 +--
 arch/arm/boot/dts/sun7i-a20-pcduino3-nano.dts            | 3 +--
 arch/arm/boot/dts/sun7i-a20-pcduino3.dts                 | 3 +--
 arch/arm/boot/dts/sun7i-a20-wexler-tab7200.dts           | 3 +--
 arch/arm/boot/dts/sun7i-a20-wits-pro-a20-dkt.dts         | 3 +--
 arch/arm/boot/dts/sun8i-a23-evb.dts                      | 3 +--
 arch/arm/boot/dts/sun8i-a33-olinuxino.dts                | 3 +--
 arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts           | 3 +--
 arch/arm/boot/dts/sun8i-a83t-allwinner-h8homlet-v2.dts   | 3 +--
 arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts             | 3 +--
 arch/arm/boot/dts/sun8i-a83t-cubietruck-plus.dts         | 3 +--
 arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts        | 3 +--
 arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dts          | 3 +--
 arch/arm/boot/dts/sun8i-h3-beelink-x2.dts                | 3 +--
 arch/arm/boot/dts/sun8i-h3-libretech-all-h3-cc.dts       | 3 +--
 arch/arm/boot/dts/sun8i-h3-nanopi-neo-air.dts            | 3 +--
 arch/arm/boot/dts/sun8i-h3-nanopi.dtsi                   | 3 +--
 arch/arm/boot/dts/sun8i-h3-orangepi-2.dts                | 3 +--
 arch/arm/boot/dts/sun8i-h3-orangepi-lite.dts             | 3 +--
 arch/arm/boot/dts/sun8i-h3-orangepi-one.dts              | 3 +--
 arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts               | 3 +--
 arch/arm/boot/dts/sun8i-r16-bananapi-m2m.dts             | 3 +--
 arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts        | 3 +--
 arch/arm/boot/dts/sun8i-reference-design-tablet.dtsi     | 3 +--
 arch/arm/boot/dts/sun8i-v40-bananapi-m2-berry.dts        | 3 +--
 arch/arm/boot/dts/sun9i-a80-cubieboard4.dts              | 3 +--
 arch/arm/boot/dts/sun9i-a80-optimus.dts                  | 3 +--
 86 files changed, 90 insertions(+), 180 deletions(-)

diff --git a/arch/arm/boot/dts/sun4i-a10-a1000.dts b/arch/arm/boot/dts/sun4i-a10-a1000.dts
index 09e909576c61..6c254ec4c85b 100644
--- a/arch/arm/boot/dts/sun4i-a10-a1000.dts
+++ b/arch/arm/boot/dts/sun4i-a10-a1000.dts
@@ -164,8 +164,7 @@
 &mmc0 {
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
-	cd-gpios = <&pio 7 1 GPIO_ACTIVE_HIGH>; /* PH1 */
-	cd-inverted;
+	cd-gpios = <&pio 7 1 GPIO_ACTIVE_LOW>; /* PH1 */
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun4i-a10-ba10-tvbox.dts b/arch/arm/boot/dts/sun4i-a10-ba10-tvbox.dts
index 39ba4ccb9e2e..38a2c4134952 100644
--- a/arch/arm/boot/dts/sun4i-a10-ba10-tvbox.dts
+++ b/arch/arm/boot/dts/sun4i-a10-ba10-tvbox.dts
@@ -106,8 +106,7 @@
 &mmc0 {
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
-	cd-gpios = <&pio 7 1 GPIO_ACTIVE_HIGH>; /* PH1 */
-	cd-inverted;
+	cd-gpios = <&pio 7 1 GPIO_ACTIVE_LOW>; /* PH1 */
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun4i-a10-chuwi-v7-cw0825.dts b/arch/arm/boot/dts/sun4i-a10-chuwi-v7-cw0825.dts
index dfc88aee4fe3..cf7b392dff31 100644
--- a/arch/arm/boot/dts/sun4i-a10-chuwi-v7-cw0825.dts
+++ b/arch/arm/boot/dts/sun4i-a10-chuwi-v7-cw0825.dts
@@ -123,8 +123,7 @@
 &mmc0 {
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
-	cd-gpios = <&pio 7 1 GPIO_ACTIVE_HIGH>; /* PH1 */
-	cd-inverted;
+	cd-gpios = <&pio 7 1 GPIO_ACTIVE_LOW>; /* PH1 */
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun4i-a10-cubieboard.dts b/arch/arm/boot/dts/sun4i-a10-cubieboard.dts
index 1982c8c238c5..197a1f2b75ff 100644
--- a/arch/arm/boot/dts/sun4i-a10-cubieboard.dts
+++ b/arch/arm/boot/dts/sun4i-a10-cubieboard.dts
@@ -162,8 +162,7 @@
 &mmc0 {
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
-	cd-gpios = <&pio 7 1 GPIO_ACTIVE_HIGH>; /* PH1 */
-	cd-inverted;
+	cd-gpios = <&pio 7 1 GPIO_ACTIVE_LOW>; /* PH1 */
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun4i-a10-dserve-dsrv9703c.dts b/arch/arm/boot/dts/sun4i-a10-dserve-dsrv9703c.dts
index 147cbc5e08ac..896e27a08727 100644
--- a/arch/arm/boot/dts/sun4i-a10-dserve-dsrv9703c.dts
+++ b/arch/arm/boot/dts/sun4i-a10-dserve-dsrv9703c.dts
@@ -150,8 +150,7 @@
 &mmc0 {
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
-	cd-gpios = <&pio 7 1 GPIO_ACTIVE_HIGH>; /* PH1 */
-	cd-inverted;
+	cd-gpios = <&pio 7 1 GPIO_ACTIVE_LOW>; /* PH1 */
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun4i-a10-gemei-g9.dts b/arch/arm/boot/dts/sun4i-a10-gemei-g9.dts
index 41ca8bded89f..ea7a59dcf8f9 100644
--- a/arch/arm/boot/dts/sun4i-a10-gemei-g9.dts
+++ b/arch/arm/boot/dts/sun4i-a10-gemei-g9.dts
@@ -141,8 +141,7 @@
 &mmc0 {
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
-	cd-gpios = <&pio 7 1 GPIO_ACTIVE_HIGH>; /* PH01 */
-	cd-inverted;
+	cd-gpios = <&pio 7 1 GPIO_ACTIVE_LOW>; /* PH01 */
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun4i-a10-hackberry.dts b/arch/arm/boot/dts/sun4i-a10-hackberry.dts
index f33e42d6ce8b..cc988ccd5ca7 100644
--- a/arch/arm/boot/dts/sun4i-a10-hackberry.dts
+++ b/arch/arm/boot/dts/sun4i-a10-hackberry.dts
@@ -106,8 +106,7 @@
 &mmc0 {
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
-	cd-gpios = <&pio 7 1 GPIO_ACTIVE_HIGH>; /* PH1 */
-	cd-inverted;
+	cd-gpios = <&pio 7 1 GPIO_ACTIVE_LOW>; /* PH1 */
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun4i-a10-hyundai-a7hd.dts b/arch/arm/boot/dts/sun4i-a10-hyundai-a7hd.dts
index 35c57d065dd8..f63767cddd8e 100644
--- a/arch/arm/boot/dts/sun4i-a10-hyundai-a7hd.dts
+++ b/arch/arm/boot/dts/sun4i-a10-hyundai-a7hd.dts
@@ -78,8 +78,7 @@
 &mmc0 {
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
-	cd-gpios = <&pio 7 1 GPIO_ACTIVE_HIGH>; /* PH1 */
-	cd-inverted;
+	cd-gpios = <&pio 7 1 GPIO_ACTIVE_LOW>; /* PH1 */
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun4i-a10-inet1.dts b/arch/arm/boot/dts/sun4i-a10-inet1.dts
index 9482e831a9a1..26d0c1d6a02b 100644
--- a/arch/arm/boot/dts/sun4i-a10-inet1.dts
+++ b/arch/arm/boot/dts/sun4i-a10-inet1.dts
@@ -152,8 +152,7 @@
 &mmc0 {
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
-	cd-gpios = <&pio 7 1 GPIO_ACTIVE_HIGH>; /* PH1 */
-	cd-inverted;
+	cd-gpios = <&pio 7 1 GPIO_ACTIVE_LOW>; /* PH1 */
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun4i-a10-inet97fv2.dts b/arch/arm/boot/dts/sun4i-a10-inet97fv2.dts
index 4b5c91c8e85b..5d096528e75a 100644
--- a/arch/arm/boot/dts/sun4i-a10-inet97fv2.dts
+++ b/arch/arm/boot/dts/sun4i-a10-inet97fv2.dts
@@ -142,8 +142,7 @@
 &mmc0 {
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
-	cd-gpios = <&pio 7 1 GPIO_ACTIVE_HIGH>; /* PH1 */
-	cd-inverted;
+	cd-gpios = <&pio 7 1 GPIO_ACTIVE_LOW>; /* PH1 */
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun4i-a10-inet9f-rev03.dts b/arch/arm/boot/dts/sun4i-a10-inet9f-rev03.dts
index 13224f5ac166..221acd10f6c8 100644
--- a/arch/arm/boot/dts/sun4i-a10-inet9f-rev03.dts
+++ b/arch/arm/boot/dts/sun4i-a10-inet9f-rev03.dts
@@ -300,8 +300,7 @@
 &mmc0 {
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
-	cd-gpios = <&pio 7 1 GPIO_ACTIVE_HIGH>; /* PH1 */
-	cd-inverted;
+	cd-gpios = <&pio 7 1 GPIO_ACTIVE_LOW>; /* PH1 */
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun4i-a10-itead-iteaduino-plus.dts b/arch/arm/boot/dts/sun4i-a10-itead-iteaduino-plus.dts
index d22bd79562d8..80ecd78247ac 100644
--- a/arch/arm/boot/dts/sun4i-a10-itead-iteaduino-plus.dts
+++ b/arch/arm/boot/dts/sun4i-a10-itead-iteaduino-plus.dts
@@ -106,8 +106,7 @@
 	pinctrl-0 = <&mmc0_pins>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
-	cd-gpios = <&pio 7 1 GPIO_ACTIVE_HIGH>; /* PH1 */
-	cd-inverted;
+	cd-gpios = <&pio 7 1 GPIO_ACTIVE_LOW>; /* PH1 */
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun4i-a10-jesurun-q5.dts b/arch/arm/boot/dts/sun4i-a10-jesurun-q5.dts
index 879141ca6027..247fa27ef717 100644
--- a/arch/arm/boot/dts/sun4i-a10-jesurun-q5.dts
+++ b/arch/arm/boot/dts/sun4i-a10-jesurun-q5.dts
@@ -133,8 +133,7 @@
 &mmc0 {
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
-	cd-gpios = <&pio 7 1 GPIO_ACTIVE_HIGH>; /* PH1 */
-	cd-inverted;
+	cd-gpios = <&pio 7 1 GPIO_ACTIVE_LOW>; /* PH1 */
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun4i-a10-marsboard.dts b/arch/arm/boot/dts/sun4i-a10-marsboard.dts
index 435c551aef0f..0dbf69576512 100644
--- a/arch/arm/boot/dts/sun4i-a10-marsboard.dts
+++ b/arch/arm/boot/dts/sun4i-a10-marsboard.dts
@@ -132,8 +132,7 @@
 &mmc0 {
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
-	cd-gpios = <&pio 7 1 GPIO_ACTIVE_HIGH>; /* PH1 */
-	cd-inverted;
+	cd-gpios = <&pio 7 1 GPIO_ACTIVE_LOW>; /* PH1 */
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun4i-a10-mini-xplus.dts b/arch/arm/boot/dts/sun4i-a10-mini-xplus.dts
index 1b639e5f9172..f9d74e21031d 100644
--- a/arch/arm/boot/dts/sun4i-a10-mini-xplus.dts
+++ b/arch/arm/boot/dts/sun4i-a10-mini-xplus.dts
@@ -96,8 +96,7 @@
 &mmc0 {
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
-	cd-gpios = <&pio 7 1 GPIO_ACTIVE_HIGH>; /* PH1 */
-	cd-inverted;
+	cd-gpios = <&pio 7 1 GPIO_ACTIVE_LOW>; /* PH1 */
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun4i-a10-mk802.dts b/arch/arm/boot/dts/sun4i-a10-mk802.dts
index 7198b34e2e50..face1925ee5b 100644
--- a/arch/arm/boot/dts/sun4i-a10-mk802.dts
+++ b/arch/arm/boot/dts/sun4i-a10-mk802.dts
@@ -73,8 +73,7 @@
 &mmc0 {
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
-	cd-gpios = <&pio 7 1 GPIO_ACTIVE_HIGH>; /* PH1 */
-	cd-inverted;
+	cd-gpios = <&pio 7 1 GPIO_ACTIVE_LOW>; /* PH1 */
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun4i-a10-mk802ii.dts b/arch/arm/boot/dts/sun4i-a10-mk802ii.dts
index e460da2eb139..17dcdf031118 100644
--- a/arch/arm/boot/dts/sun4i-a10-mk802ii.dts
+++ b/arch/arm/boot/dts/sun4i-a10-mk802ii.dts
@@ -82,8 +82,7 @@
 &mmc0 {
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
-	cd-gpios = <&pio 7 1 GPIO_ACTIVE_HIGH>; /* PH1 */
-	cd-inverted;
+	cd-gpios = <&pio 7 1 GPIO_ACTIVE_LOW>; /* PH1 */
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts b/arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts
index 49247fbe6acd..f15f01955fdf 100644
--- a/arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts
+++ b/arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts
@@ -165,8 +165,7 @@
 &mmc0 {
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
-	cd-gpios = <&pio 7 1 GPIO_ACTIVE_HIGH>; /* PH1 */
-	cd-inverted;
+	cd-gpios = <&pio 7 1 GPIO_ACTIVE_LOW>; /* PH1 */
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun4i-a10-pcduino.dts b/arch/arm/boot/dts/sun4i-a10-pcduino.dts
index 6e140547b638..b97a0f2f20b9 100644
--- a/arch/arm/boot/dts/sun4i-a10-pcduino.dts
+++ b/arch/arm/boot/dts/sun4i-a10-pcduino.dts
@@ -140,8 +140,7 @@
 &mmc0 {
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
-	cd-gpios = <&pio 7 1 GPIO_ACTIVE_HIGH>; /* PH1 */
-	cd-inverted;
+	cd-gpios = <&pio 7 1 GPIO_ACTIVE_LOW>; /* PH1 */
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun4i-a10-pov-protab2-ips9.dts b/arch/arm/boot/dts/sun4i-a10-pov-protab2-ips9.dts
index 5081303f79e7..84b25be1ac94 100644
--- a/arch/arm/boot/dts/sun4i-a10-pov-protab2-ips9.dts
+++ b/arch/arm/boot/dts/sun4i-a10-pov-protab2-ips9.dts
@@ -138,8 +138,7 @@
 &mmc0 {
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
-	cd-gpios = <&pio 7 1 GPIO_ACTIVE_HIGH>; /* PH1 */
-	cd-inverted;
+	cd-gpios = <&pio 7 1 GPIO_ACTIVE_LOW>; /* PH1 */
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun5i-a10s-auxtek-t003.dts b/arch/arm/boot/dts/sun5i-a10s-auxtek-t003.dts
index d2dee8d434bf..39504d720efc 100644
--- a/arch/arm/boot/dts/sun5i-a10s-auxtek-t003.dts
+++ b/arch/arm/boot/dts/sun5i-a10s-auxtek-t003.dts
@@ -93,8 +93,7 @@
 	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_t003>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
-	cd-gpios = <&pio 6 1 GPIO_ACTIVE_HIGH>; /* PG1 */
-	cd-inverted;
+	cd-gpios = <&pio 6 1 GPIO_ACTIVE_LOW>; /* PG1 */
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun5i-a10s-auxtek-t004.dts b/arch/arm/boot/dts/sun5i-a10s-auxtek-t004.dts
index 16f839df4227..8d4fb9331212 100644
--- a/arch/arm/boot/dts/sun5i-a10s-auxtek-t004.dts
+++ b/arch/arm/boot/dts/sun5i-a10s-auxtek-t004.dts
@@ -104,8 +104,7 @@
 	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_t004>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
-	cd-gpios = <&pio 6 1 GPIO_ACTIVE_HIGH>; /* PG1 */
-	cd-inverted;
+	cd-gpios = <&pio 6 1 GPIO_ACTIVE_LOW>; /* PG1 */
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun5i-a10s-mk802.dts b/arch/arm/boot/dts/sun5i-a10s-mk802.dts
index 020aa9d6c31d..dd7fd5c3d76f 100644
--- a/arch/arm/boot/dts/sun5i-a10s-mk802.dts
+++ b/arch/arm/boot/dts/sun5i-a10s-mk802.dts
@@ -92,8 +92,7 @@
 	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_mk802>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
-	cd-gpios = <&pio 6 1 GPIO_ACTIVE_HIGH>; /* PG1 */
-	cd-inverted;
+	cd-gpios = <&pio 6 1 GPIO_ACTIVE_LOW>; /* PG1 */
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts b/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts
index da95118af4dc..2c902ed2c87a 100644
--- a/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts
+++ b/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts
@@ -201,8 +201,7 @@
 	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_olinuxino_micro>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
-	cd-gpios = <&pio 6 1 GPIO_ACTIVE_HIGH>; /* PG1 */
-	cd-inverted;
+	cd-gpios = <&pio 6 1 GPIO_ACTIVE_LOW>; /* PG1 */
 	status = "okay";
 };
 
@@ -211,8 +210,7 @@
 	pinctrl-0 = <&mmc1_pins_a>, <&mmc1_cd_pin_olinuxino_micro>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
-	cd-gpios = <&pio 6 13 GPIO_ACTIVE_HIGH>; /* PG13 */
-	cd-inverted;
+	cd-gpios = <&pio 6 13 GPIO_ACTIVE_LOW>; /* PG13 */
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun5i-a10s-r7-tv-dongle.dts b/arch/arm/boot/dts/sun5i-a10s-r7-tv-dongle.dts
index 262b3669f04d..034853d1c08f 100644
--- a/arch/arm/boot/dts/sun5i-a10s-r7-tv-dongle.dts
+++ b/arch/arm/boot/dts/sun5i-a10s-r7-tv-dongle.dts
@@ -80,8 +80,7 @@
 	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_r7>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
-	cd-gpios = <&pio 6 1 GPIO_ACTIVE_HIGH>; /* PG1 */
-	cd-inverted;
+	cd-gpios = <&pio 6 1 GPIO_ACTIVE_LOW>; /* PG1 */
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun5i-a10s-wobo-i5.dts b/arch/arm/boot/dts/sun5i-a10s-wobo-i5.dts
index 5482be174e12..3f68ef5d92a0 100644
--- a/arch/arm/boot/dts/sun5i-a10s-wobo-i5.dts
+++ b/arch/arm/boot/dts/sun5i-a10s-wobo-i5.dts
@@ -130,8 +130,7 @@
 	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_wobo_i5>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
-	cd-gpios = <&pio 1 3 GPIO_ACTIVE_HIGH>; /* PB3 */
-	cd-inverted;
+	cd-gpios = <&pio 1 3 GPIO_ACTIVE_LOW>; /* PB3 */
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun5i-a13-empire-electronix-d709.dts b/arch/arm/boot/dts/sun5i-a13-empire-electronix-d709.dts
index 3dbb0d7c2f8c..378214d8316e 100644
--- a/arch/arm/boot/dts/sun5i-a13-empire-electronix-d709.dts
+++ b/arch/arm/boot/dts/sun5i-a13-empire-electronix-d709.dts
@@ -125,8 +125,7 @@
 	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_d709>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
-	cd-gpios = <&pio 6 0 GPIO_ACTIVE_HIGH>; /* PG0 */
-	cd-inverted;
+	cd-gpios = <&pio 6 0 GPIO_ACTIVE_LOW>; /* PG0 */
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun5i-a13-hsg-h702.dts b/arch/arm/boot/dts/sun5i-a13-hsg-h702.dts
index 584fa579ded2..7ee0c3f6d7a1 100644
--- a/arch/arm/boot/dts/sun5i-a13-hsg-h702.dts
+++ b/arch/arm/boot/dts/sun5i-a13-hsg-h702.dts
@@ -120,8 +120,7 @@
 	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_h702>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
-	cd-gpios = <&pio 6 0 GPIO_ACTIVE_HIGH>; /* PG0 */
-	cd-inverted;
+	cd-gpios = <&pio 6 0 GPIO_ACTIVE_LOW>; /* PG0 */
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun5i-a13-olinuxino-micro.dts b/arch/arm/boot/dts/sun5i-a13-olinuxino-micro.dts
index 3a831eaf1dfc..aa4b34fd9126 100644
--- a/arch/arm/boot/dts/sun5i-a13-olinuxino-micro.dts
+++ b/arch/arm/boot/dts/sun5i-a13-olinuxino-micro.dts
@@ -99,8 +99,7 @@
 	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_olinuxinom>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
-	cd-gpios = <&pio 6 0 GPIO_ACTIVE_HIGH>; /* PG0 */
-	cd-inverted;
+	cd-gpios = <&pio 6 0 GPIO_ACTIVE_LOW>; /* PG0 */
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun5i-a13-olinuxino.dts b/arch/arm/boot/dts/sun5i-a13-olinuxino.dts
index 4b9af423c6d5..437ad913a373 100644
--- a/arch/arm/boot/dts/sun5i-a13-olinuxino.dts
+++ b/arch/arm/boot/dts/sun5i-a13-olinuxino.dts
@@ -194,8 +194,7 @@
 	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_olinuxino>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
-	cd-gpios = <&pio 6 0 GPIO_ACTIVE_HIGH>; /* PG0 */
-	cd-inverted;
+	cd-gpios = <&pio 6 0 GPIO_ACTIVE_LOW>; /* PG0 */
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun5i-gr8-evb.dts b/arch/arm/boot/dts/sun5i-gr8-evb.dts
index 558c16a30543..5f0adc0f7bb4 100644
--- a/arch/arm/boot/dts/sun5i-gr8-evb.dts
+++ b/arch/arm/boot/dts/sun5i-gr8-evb.dts
@@ -236,8 +236,7 @@
 	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_gr8_evb>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
-	cd-gpios = <&pio 6 0 GPIO_ACTIVE_HIGH>; /* PG0 */
-	cd-inverted;
+	cd-gpios = <&pio 6 0 GPIO_ACTIVE_LOW>; /* PG0 */
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun5i-reference-design-tablet.dtsi b/arch/arm/boot/dts/sun5i-reference-design-tablet.dtsi
index 49229b3d5492..8acbaab14fe5 100644
--- a/arch/arm/boot/dts/sun5i-reference-design-tablet.dtsi
+++ b/arch/arm/boot/dts/sun5i-reference-design-tablet.dtsi
@@ -127,8 +127,7 @@
 	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin>;
 	vmmc-supply = <&reg_vcc3v0>;
 	bus-width = <4>;
-	cd-gpios = <&pio 6 0 GPIO_ACTIVE_HIGH>; /* PG0 */
-	cd-inverted;
+	cd-gpios = <&pio 6 0 GPIO_ACTIVE_LOW>; /* PG0 */
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun6i-a31-colombus.dts b/arch/arm/boot/dts/sun6i-a31-colombus.dts
index 85eff0307ca4..939c497a6f70 100644
--- a/arch/arm/boot/dts/sun6i-a31-colombus.dts
+++ b/arch/arm/boot/dts/sun6i-a31-colombus.dts
@@ -117,8 +117,7 @@
 	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_colombus>;
 	vmmc-supply = <&reg_vcc3v0>;
 	bus-width = <4>;
-	cd-gpios = <&pio 0 8 GPIO_ACTIVE_HIGH>; /* PA8 */
-	cd-inverted;
+	cd-gpios = <&pio 0 8 GPIO_ACTIVE_LOW>; /* PA8 */
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun6i-a31-hummingbird.dts b/arch/arm/boot/dts/sun6i-a31-hummingbird.dts
index 19e382a11297..ce4f9e9834bf 100644
--- a/arch/arm/boot/dts/sun6i-a31-hummingbird.dts
+++ b/arch/arm/boot/dts/sun6i-a31-hummingbird.dts
@@ -218,8 +218,7 @@
 	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_hummingbird>;
 	vmmc-supply = <&reg_dcdc1>;
 	bus-width = <4>;
-	cd-gpios = <&pio 0 8 GPIO_ACTIVE_HIGH>; /* PA8 */
-	cd-inverted;
+	cd-gpios = <&pio 0 8 GPIO_ACTIVE_LOW>; /* PA8 */
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun6i-a31-i7.dts b/arch/arm/boot/dts/sun6i-a31-i7.dts
index 010a84c7c012..2e0a672c8031 100644
--- a/arch/arm/boot/dts/sun6i-a31-i7.dts
+++ b/arch/arm/boot/dts/sun6i-a31-i7.dts
@@ -124,8 +124,7 @@
 	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_i7>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
-	cd-gpios = <&pio 7 22 GPIO_ACTIVE_HIGH>; /* PH22 */
-	cd-inverted;
+	cd-gpios = <&pio 7 22 GPIO_ACTIVE_LOW>; /* PH22 */
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun6i-a31-m9.dts b/arch/arm/boot/dts/sun6i-a31-m9.dts
index 50605fd4449e..9698f6d38d03 100644
--- a/arch/arm/boot/dts/sun6i-a31-m9.dts
+++ b/arch/arm/boot/dts/sun6i-a31-m9.dts
@@ -107,8 +107,7 @@
 	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_m9>;
 	vmmc-supply = <&reg_dcdc1>;
 	bus-width = <4>;
-	cd-gpios = <&pio 7 22 GPIO_ACTIVE_HIGH>; /* PH22 */
-	cd-inverted;
+	cd-gpios = <&pio 7 22 GPIO_ACTIVE_LOW>; /* PH22 */
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun6i-a31-mele-a1000g-quad.dts b/arch/arm/boot/dts/sun6i-a31-mele-a1000g-quad.dts
index 5219556e9f73..bb14b171b160 100644
--- a/arch/arm/boot/dts/sun6i-a31-mele-a1000g-quad.dts
+++ b/arch/arm/boot/dts/sun6i-a31-mele-a1000g-quad.dts
@@ -107,8 +107,7 @@
 	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_m9>;
 	vmmc-supply = <&reg_dcdc1>;
 	bus-width = <4>;
-	cd-gpios = <&pio 7 22 GPIO_ACTIVE_HIGH>; /* PH22 */
-	cd-inverted;
+	cd-gpios = <&pio 7 22 GPIO_ACTIVE_LOW>; /* PH22 */
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun6i-a31s-primo81.dts b/arch/arm/boot/dts/sun6i-a31s-primo81.dts
index 0cdb38ab3377..4cb9664cdb29 100644
--- a/arch/arm/boot/dts/sun6i-a31s-primo81.dts
+++ b/arch/arm/boot/dts/sun6i-a31s-primo81.dts
@@ -151,8 +151,7 @@
 	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_primo81>;
 	vmmc-supply = <&reg_dcdc1>;
 	bus-width = <4>;
-	cd-gpios = <&pio 0 8 GPIO_ACTIVE_HIGH>; /* PA8 */
-	cd-inverted;
+	cd-gpios = <&pio 0 8 GPIO_ACTIVE_LOW>; /* PA8 */
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun6i-a31s-sina31s.dts b/arch/arm/boot/dts/sun6i-a31s-sina31s.dts
index 298476485bb4..da0ccf5a2c44 100644
--- a/arch/arm/boot/dts/sun6i-a31s-sina31s.dts
+++ b/arch/arm/boot/dts/sun6i-a31s-sina31s.dts
@@ -167,8 +167,7 @@
 	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_sina31s>;
 	vmmc-supply = <&reg_dcdc1>;
 	bus-width = <4>;
-	cd-gpios = <&pio 0 4 GPIO_ACTIVE_HIGH>; /* PA4 */
-	cd-inverted;
+	cd-gpios = <&pio 0 4 GPIO_ACTIVE_LOW>; /* PA4 */
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun6i-a31s-sinovoip-bpi-m2.dts b/arch/arm/boot/dts/sun6i-a31s-sinovoip-bpi-m2.dts
index 51e6f1d21c32..3077e8ec9cd9 100644
--- a/arch/arm/boot/dts/sun6i-a31s-sinovoip-bpi-m2.dts
+++ b/arch/arm/boot/dts/sun6i-a31s-sinovoip-bpi-m2.dts
@@ -120,8 +120,7 @@
 	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_bpi_m2>;
 	vmmc-supply = <&reg_vcc3v0>;
 	bus-width = <4>;
-	cd-gpios = <&pio 0 4 GPIO_ACTIVE_HIGH>; /* PA4 */
-	cd-inverted;
+	cd-gpios = <&pio 0 4 GPIO_ACTIVE_LOW>; /* PA4 */
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun6i-a31s-yones-toptech-bs1078-v2.dts b/arch/arm/boot/dts/sun6i-a31s-yones-toptech-bs1078-v2.dts
index f3edf9ca435c..aab6c1720ef7 100644
--- a/arch/arm/boot/dts/sun6i-a31s-yones-toptech-bs1078-v2.dts
+++ b/arch/arm/boot/dts/sun6i-a31s-yones-toptech-bs1078-v2.dts
@@ -102,8 +102,7 @@
 	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_bs1078v2>;
 	vmmc-supply = <&reg_vcc3v0>;
 	bus-width = <4>;
-	cd-gpios = <&pio 0 8 GPIO_ACTIVE_HIGH>; /* PA8 */
-	cd-inverted;
+	cd-gpios = <&pio 0 8 GPIO_ACTIVE_LOW>; /* PA8 */
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun6i-reference-design-tablet.dtsi b/arch/arm/boot/dts/sun6i-reference-design-tablet.dtsi
index 3cc4046b904a..4e72e4f3ef96 100644
--- a/arch/arm/boot/dts/sun6i-reference-design-tablet.dtsi
+++ b/arch/arm/boot/dts/sun6i-reference-design-tablet.dtsi
@@ -69,8 +69,7 @@
 	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_e708_q1>;
 	vmmc-supply = <&reg_dcdc1>;
 	bus-width = <4>;
-	cd-gpios = <&pio 0 8 GPIO_ACTIVE_HIGH>; /* PA8 */
-	cd-inverted;
+	cd-gpios = <&pio 0 8 GPIO_ACTIVE_LOW>; /* PA8 */
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun7i-a20-bananapi-m1-plus.dts b/arch/arm/boot/dts/sun7i-a20-bananapi-m1-plus.dts
index 4ed3162e3e5a..763cb03033c4 100644
--- a/arch/arm/boot/dts/sun7i-a20-bananapi-m1-plus.dts
+++ b/arch/arm/boot/dts/sun7i-a20-bananapi-m1-plus.dts
@@ -184,8 +184,7 @@
 	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_bpi_m1p>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
-	cd-gpios = <&pio 7 10 GPIO_ACTIVE_HIGH>; /* PH10 */
-	cd-inverted;
+	cd-gpios = <&pio 7 10 GPIO_ACTIVE_LOW>; /* PH10 */
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun7i-a20-bananapi.dts b/arch/arm/boot/dts/sun7i-a20-bananapi.dts
index 88a1c2363c6c..6f744f8931f0 100644
--- a/arch/arm/boot/dts/sun7i-a20-bananapi.dts
+++ b/arch/arm/boot/dts/sun7i-a20-bananapi.dts
@@ -159,8 +159,7 @@
 	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_bananapi>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
-	cd-gpios = <&pio 7 10 GPIO_ACTIVE_HIGH>; /* PH10 */
-	cd-inverted;
+	cd-gpios = <&pio 7 10 GPIO_ACTIVE_LOW>; /* PH10 */
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun7i-a20-bananapro.dts b/arch/arm/boot/dts/sun7i-a20-bananapro.dts
index e7af1b7c33d5..0898eb6162f5 100644
--- a/arch/arm/boot/dts/sun7i-a20-bananapro.dts
+++ b/arch/arm/boot/dts/sun7i-a20-bananapro.dts
@@ -158,8 +158,7 @@
 	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_bananapro>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
-	cd-gpios = <&pio 7 10 GPIO_ACTIVE_HIGH>; /* PH10 */
-	cd-inverted;
+	cd-gpios = <&pio 7 10 GPIO_ACTIVE_LOW>; /* PH10 */
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts b/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts
index 39f43e4eb742..942ac9dfd4a5 100644
--- a/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts
+++ b/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts
@@ -165,8 +165,7 @@
 	pinctrl-0 = <&mmc0_pins_a>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
-	cd-gpios = <&pio 7 1 GPIO_ACTIVE_HIGH>; /* PH1 */
-	cd-inverted;
+	cd-gpios = <&pio 7 1 GPIO_ACTIVE_LOW>; /* PH1 */
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun7i-a20-cubietruck.dts b/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
index 8c9bedc602ec..5649161de1d7 100644
--- a/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
+++ b/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
@@ -206,8 +206,7 @@
 	pinctrl-0 = <&mmc0_pins_a>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
-	cd-gpios = <&pio 7 1 GPIO_ACTIVE_HIGH>; /* PH1 */
-	cd-inverted;
+	cd-gpios = <&pio 7 1 GPIO_ACTIVE_LOW>; /* PH1 */
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun7i-a20-hummingbird.dts b/arch/arm/boot/dts/sun7i-a20-hummingbird.dts
index 6e6264cd69f8..1f0e5ecbf0c4 100644
--- a/arch/arm/boot/dts/sun7i-a20-hummingbird.dts
+++ b/arch/arm/boot/dts/sun7i-a20-hummingbird.dts
@@ -163,8 +163,7 @@
 	pinctrl-0 = <&mmc0_pins_a>;
 	vmmc-supply = <&reg_vcc3v0>;
 	bus-width = <4>;
-	cd-gpios = <&pio 7 1 GPIO_ACTIVE_HIGH>; /* PH1 */
-	cd-inverted;
+	cd-gpios = <&pio 7 1 GPIO_ACTIVE_LOW>; /* PH1 */
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun7i-a20-i12-tvbox.dts b/arch/arm/boot/dts/sun7i-a20-i12-tvbox.dts
index 55809973a568..2e3f2f29d124 100644
--- a/arch/arm/boot/dts/sun7i-a20-i12-tvbox.dts
+++ b/arch/arm/boot/dts/sun7i-a20-i12-tvbox.dts
@@ -160,8 +160,7 @@
 	pinctrl-0 = <&mmc0_pins_a>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
-	cd-gpios = <&pio 7 1 GPIO_ACTIVE_HIGH>; /* PH1 */
-	cd-inverted;
+	cd-gpios = <&pio 7 1 GPIO_ACTIVE_LOW>; /* PH1 */
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun7i-a20-icnova-swac.dts b/arch/arm/boot/dts/sun7i-a20-icnova-swac.dts
index 794e7617f545..926fa194eb1b 100644
--- a/arch/arm/boot/dts/sun7i-a20-icnova-swac.dts
+++ b/arch/arm/boot/dts/sun7i-a20-icnova-swac.dts
@@ -107,8 +107,7 @@
 	pinctrl-0 = <&mmc0_pins_a>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
-	cd-gpios = <&pio 8 5 GPIO_ACTIVE_HIGH>; /* PI5 */
-	cd-inverted;
+	cd-gpios = <&pio 8 5 GPIO_ACTIVE_LOW>; /* PI5 */
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun7i-a20-itead-ibox.dts b/arch/arm/boot/dts/sun7i-a20-itead-ibox.dts
index 8a8a6dbcd414..1b05ba466e7d 100644
--- a/arch/arm/boot/dts/sun7i-a20-itead-ibox.dts
+++ b/arch/arm/boot/dts/sun7i-a20-itead-ibox.dts
@@ -124,8 +124,7 @@
 	pinctrl-0 = <&mmc0_pins_a>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
-	cd-gpios = <&pio 7 1 GPIO_ACTIVE_HIGH>; /* PH1 */
-	cd-inverted;
+	cd-gpios = <&pio 7 1 GPIO_ACTIVE_LOW>; /* PH1 */
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun7i-a20-lamobo-r1.dts b/arch/arm/boot/dts/sun7i-a20-lamobo-r1.dts
index 442f3c755f36..b1ab7c1c33e3 100644
--- a/arch/arm/boot/dts/sun7i-a20-lamobo-r1.dts
+++ b/arch/arm/boot/dts/sun7i-a20-lamobo-r1.dts
@@ -227,8 +227,7 @@
 	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_lamobo_r1>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
-	cd-gpios = <&pio 7 10 GPIO_ACTIVE_HIGH>; /* PH10 */
-	cd-inverted;
+	cd-gpios = <&pio 7 10 GPIO_ACTIVE_LOW>; /* PH10 */
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun7i-a20-m3.dts b/arch/arm/boot/dts/sun7i-a20-m3.dts
index 43c94787ef07..e91a209850bc 100644
--- a/arch/arm/boot/dts/sun7i-a20-m3.dts
+++ b/arch/arm/boot/dts/sun7i-a20-m3.dts
@@ -120,8 +120,7 @@
 	pinctrl-0 = <&mmc0_pins_a>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
-	cd-gpios = <&pio 7 1 GPIO_ACTIVE_HIGH>; /* PH1 */
-	cd-inverted;
+	cd-gpios = <&pio 7 1 GPIO_ACTIVE_LOW>; /* PH1 */
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun7i-a20-mk808c.dts b/arch/arm/boot/dts/sun7i-a20-mk808c.dts
index f7413094183c..ce3f09aaeed2 100644
--- a/arch/arm/boot/dts/sun7i-a20-mk808c.dts
+++ b/arch/arm/boot/dts/sun7i-a20-mk808c.dts
@@ -112,8 +112,7 @@
 	pinctrl-0 = <&mmc0_pins_a>;
 	vmmc-supply = <&reg_vcc3v0>;
 	bus-width = <4>;
-	cd-gpios = <&pio 7 1 GPIO_ACTIVE_HIGH>; /* PH1 */
-	cd-inverted;
+	cd-gpios = <&pio 7 1 GPIO_ACTIVE_LOW>; /* PH1 */
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun7i-a20-olimex-som-evb.dts b/arch/arm/boot/dts/sun7i-a20-olimex-som-evb.dts
index 64c8ef9a2756..8f34731dee34 100644
--- a/arch/arm/boot/dts/sun7i-a20-olimex-som-evb.dts
+++ b/arch/arm/boot/dts/sun7i-a20-olimex-som-evb.dts
@@ -190,8 +190,7 @@
 	pinctrl-0 = <&mmc0_pins_a>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
-	cd-gpios = <&pio 7 1 GPIO_ACTIVE_HIGH>; /* PH1 */
-	cd-inverted;
+	cd-gpios = <&pio 7 1 GPIO_ACTIVE_LOW>; /* PH1 */
 	status = "okay";
 };
 
@@ -200,8 +199,7 @@
 	pinctrl-0 = <&mmc3_pins_a>, <&mmc3_cd_pin_olimex_som_evb>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
-	cd-gpios = <&pio 7 0 GPIO_ACTIVE_HIGH>; /* PH0 */
-	cd-inverted;
+	cd-gpios = <&pio 7 0 GPIO_ACTIVE_LOW>; /* PH0 */
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun7i-a20-olinuxino-lime.dts b/arch/arm/boot/dts/sun7i-a20-olinuxino-lime.dts
index edf9c3c6c0d7..d20fd03596e9 100644
--- a/arch/arm/boot/dts/sun7i-a20-olinuxino-lime.dts
+++ b/arch/arm/boot/dts/sun7i-a20-olinuxino-lime.dts
@@ -158,8 +158,7 @@
 	pinctrl-0 = <&mmc0_pins_a>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
-	cd-gpios = <&pio 7 1 GPIO_ACTIVE_HIGH>; /* PH1 */
-	cd-inverted;
+	cd-gpios = <&pio 7 1 GPIO_ACTIVE_LOW>; /* PH1 */
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts b/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
index ba250189d07f..b828677f331d 100644
--- a/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
+++ b/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
@@ -159,8 +159,7 @@
 	pinctrl-0 = <&mmc0_pins_a>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
-	cd-gpios = <&pio 7 1 GPIO_ACTIVE_HIGH>; /* PH1 */
-	cd-inverted;
+	cd-gpios = <&pio 7 1 GPIO_ACTIVE_LOW>; /* PH1 */
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts b/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
index dffbaa24b3ee..866d230593be 100644
--- a/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
+++ b/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
@@ -226,8 +226,7 @@
 	pinctrl-0 = <&mmc0_pins_a>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
-	cd-gpios = <&pio 7 1 GPIO_ACTIVE_HIGH>; /* PH1 */
-	cd-inverted;
+	cd-gpios = <&pio 7 1 GPIO_ACTIVE_LOW>; /* PH1 */
 	status = "okay";
 };
 
@@ -236,8 +235,7 @@
 	pinctrl-0 = <&mmc3_pins_a>, <&mmc3_cd_pin_olinuxinom>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
-	cd-gpios = <&pio 7 11 GPIO_ACTIVE_HIGH>; /* PH11 */
-	cd-inverted;
+	cd-gpios = <&pio 7 11 GPIO_ACTIVE_LOW>; /* PH11 */
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun7i-a20-orangepi-mini.dts b/arch/arm/boot/dts/sun7i-a20-orangepi-mini.dts
index 7af4c8fc1865..a5ae0c55bf5b 100644
--- a/arch/arm/boot/dts/sun7i-a20-orangepi-mini.dts
+++ b/arch/arm/boot/dts/sun7i-a20-orangepi-mini.dts
@@ -144,8 +144,7 @@
 	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_orangepi>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
-	cd-gpios = <&pio 7 10 GPIO_ACTIVE_HIGH>; /* PH10 */
-	cd-inverted;
+	cd-gpios = <&pio 7 10 GPIO_ACTIVE_LOW>; /* PH10 */
 	status = "okay";
 };
 
@@ -154,8 +153,7 @@
 	pinctrl-0 = <&mmc3_pins_a>, <&mmc3_cd_pin_orangepi>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
-	cd-gpios = <&pio 7 11 GPIO_ACTIVE_HIGH>; /* PH11 */
-	cd-inverted;
+	cd-gpios = <&pio 7 11 GPIO_ACTIVE_LOW>; /* PH11 */
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun7i-a20-orangepi.dts b/arch/arm/boot/dts/sun7i-a20-orangepi.dts
index 0a8d4a05e8a0..7a4244e57589 100644
--- a/arch/arm/boot/dts/sun7i-a20-orangepi.dts
+++ b/arch/arm/boot/dts/sun7i-a20-orangepi.dts
@@ -135,8 +135,7 @@
 	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_orangepi>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
-	cd-gpios = <&pio 7 10 GPIO_ACTIVE_HIGH>; /* PH10 */
-	cd-inverted;
+	cd-gpios = <&pio 7 10 GPIO_ACTIVE_LOW>; /* PH10 */
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun7i-a20-pcduino3-nano.dts b/arch/arm/boot/dts/sun7i-a20-pcduino3-nano.dts
index fb591f32252c..bfca960b03e0 100644
--- a/arch/arm/boot/dts/sun7i-a20-pcduino3-nano.dts
+++ b/arch/arm/boot/dts/sun7i-a20-pcduino3-nano.dts
@@ -158,8 +158,7 @@
 	pinctrl-0 = <&mmc0_pins_a>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
-	cd-gpios = <&pio 7 1 GPIO_ACTIVE_HIGH>; /* PH1 */
-	cd-inverted;
+	cd-gpios = <&pio 7 1 GPIO_ACTIVE_LOW>; /* PH1 */
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun7i-a20-pcduino3.dts b/arch/arm/boot/dts/sun7i-a20-pcduino3.dts
index 777152a3df0f..c576f101fbde 100644
--- a/arch/arm/boot/dts/sun7i-a20-pcduino3.dts
+++ b/arch/arm/boot/dts/sun7i-a20-pcduino3.dts
@@ -159,8 +159,7 @@
 	pinctrl-0 = <&mmc0_pins_a>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
-	cd-gpios = <&pio 7 1 GPIO_ACTIVE_HIGH>; /* PH1 */
-	cd-inverted;
+	cd-gpios = <&pio 7 1 GPIO_ACTIVE_LOW>; /* PH1 */
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun7i-a20-wexler-tab7200.dts b/arch/arm/boot/dts/sun7i-a20-wexler-tab7200.dts
index f8d0aafb9f88..8202c87ca6a3 100644
--- a/arch/arm/boot/dts/sun7i-a20-wexler-tab7200.dts
+++ b/arch/arm/boot/dts/sun7i-a20-wexler-tab7200.dts
@@ -154,8 +154,7 @@
 	pinctrl-0 = <&mmc0_pins_a>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
-	cd-gpios = <&pio 7 1 GPIO_ACTIVE_HIGH>; /* PH1 */
-	cd-inverted;
+	cd-gpios = <&pio 7 1 GPIO_ACTIVE_LOW>; /* PH1 */
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun7i-a20-wits-pro-a20-dkt.dts b/arch/arm/boot/dts/sun7i-a20-wits-pro-a20-dkt.dts
index 7f8405a0dd0f..ff5c1086585c 100644
--- a/arch/arm/boot/dts/sun7i-a20-wits-pro-a20-dkt.dts
+++ b/arch/arm/boot/dts/sun7i-a20-wits-pro-a20-dkt.dts
@@ -123,8 +123,7 @@
 	pinctrl-0 = <&mmc0_pins_a>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
-	cd-gpios = <&pio 7 1 GPIO_ACTIVE_HIGH>; /* PH1 */
-	cd-inverted;
+	cd-gpios = <&pio 7 1 GPIO_ACTIVE_LOW>; /* PH1 */
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun8i-a23-evb.dts b/arch/arm/boot/dts/sun8i-a23-evb.dts
index 87289a60c520..8a93697df3a5 100644
--- a/arch/arm/boot/dts/sun8i-a23-evb.dts
+++ b/arch/arm/boot/dts/sun8i-a23-evb.dts
@@ -107,8 +107,7 @@
 	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_evb>;
 	vmmc-supply = <&reg_vcc3v0>;
 	bus-width = <4>;
-	cd-gpios = <&pio 1 4 GPIO_ACTIVE_HIGH>; /* PB4 */
-	cd-inverted;
+	cd-gpios = <&pio 1 4 GPIO_ACTIVE_LOW>; /* PB4 */
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun8i-a33-olinuxino.dts b/arch/arm/boot/dts/sun8i-a33-olinuxino.dts
index be9a6b8d7a1e..9757265c58d4 100644
--- a/arch/arm/boot/dts/sun8i-a33-olinuxino.dts
+++ b/arch/arm/boot/dts/sun8i-a33-olinuxino.dts
@@ -81,8 +81,7 @@
 	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_olinuxino>;
 	vmmc-supply = <&reg_dcdc1>;
 	bus-width = <4>;
-	cd-gpios = <&pio 1 4 GPIO_ACTIVE_HIGH>; /* PB4 */
-	cd-inverted;
+	cd-gpios = <&pio 1 4 GPIO_ACTIVE_LOW>; /* PB4 */
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts b/arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts
index 433cf2a2a9a2..541acb4d2b91 100644
--- a/arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts
+++ b/arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts
@@ -144,8 +144,7 @@
 	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_sina33>;
 	vmmc-supply = <&reg_dcdc1>;
 	bus-width = <4>;
-	cd-gpios = <&pio 1 4 GPIO_ACTIVE_HIGH>; /* PB4 */
-	cd-inverted;
+	cd-gpios = <&pio 1 4 GPIO_ACTIVE_LOW>; /* PB4 */
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun8i-a83t-allwinner-h8homlet-v2.dts b/arch/arm/boot/dts/sun8i-a83t-allwinner-h8homlet-v2.dts
index 5091cecbcd1e..36ecebaff3c0 100644
--- a/arch/arm/boot/dts/sun8i-a83t-allwinner-h8homlet-v2.dts
+++ b/arch/arm/boot/dts/sun8i-a83t-allwinner-h8homlet-v2.dts
@@ -87,9 +87,8 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc0_pins>;
 	vmmc-supply = <&reg_dcdc1>;
-	cd-gpios = <&pio 5 6 GPIO_ACTIVE_HIGH>; /* PF6 */
+	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>; /* PF6 */
 	bus-width = <4>;
-	cd-inverted;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts b/arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts
index 6550bf0e594b..1890d41b7fae 100644
--- a/arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts
+++ b/arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts
@@ -112,8 +112,7 @@
 	pinctrl-0 = <&mmc0_pins>;
 	vmmc-supply = <&reg_dcdc1>;
 	bus-width = <4>;
-	cd-gpios = <&pio 5 6 GPIO_ACTIVE_HIGH>; /* PF6 */
-	cd-inverted;
+	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>; /* PF6 */
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun8i-a83t-cubietruck-plus.dts b/arch/arm/boot/dts/sun8i-a83t-cubietruck-plus.dts
index 6da08cd0e107..88decb0747ac 100644
--- a/arch/arm/boot/dts/sun8i-a83t-cubietruck-plus.dts
+++ b/arch/arm/boot/dts/sun8i-a83t-cubietruck-plus.dts
@@ -176,8 +176,7 @@
 	pinctrl-0 = <&mmc0_pins>;
 	vmmc-supply = <&reg_dcdc1>;
 	bus-width = <4>;
-	cd-gpios = <&pio 5 6 GPIO_ACTIVE_HIGH>; /* PF6 */
-	cd-inverted;
+	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>; /* PF6 */
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts b/arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts
index 6713d0f2b3f4..9a5017bb1440 100644
--- a/arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts
+++ b/arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts
@@ -116,8 +116,7 @@
 	pinctrl-0 = <&mmc0_pins_a>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
-	cd-gpios = <&pio 5 6 GPIO_ACTIVE_HIGH>; /* PF6 */
-	cd-inverted;
+	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>; /* PF6 */
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dts b/arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dts
index f1c3f1cc4d97..3a196a86a984 100644
--- a/arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dts
+++ b/arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dts
@@ -140,8 +140,7 @@
 	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
-	cd-gpios = <&pio 5 6 GPIO_ACTIVE_HIGH>; /* PF6 */
-	cd-inverted;
+	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>; /* PF6 */
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun8i-h3-beelink-x2.dts b/arch/arm/boot/dts/sun8i-h3-beelink-x2.dts
index 10da56e86ab8..7824f0dbf022 100644
--- a/arch/arm/boot/dts/sun8i-h3-beelink-x2.dts
+++ b/arch/arm/boot/dts/sun8i-h3-beelink-x2.dts
@@ -119,8 +119,7 @@
 	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
-	cd-gpios = <&pio 5 6 GPIO_ACTIVE_HIGH>; /* PF6 */
-	cd-inverted;
+	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>; /* PF6 */
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun8i-h3-libretech-all-h3-cc.dts b/arch/arm/boot/dts/sun8i-h3-libretech-all-h3-cc.dts
index d406571a0dd6..d9dc14fe2aa3 100644
--- a/arch/arm/boot/dts/sun8i-h3-libretech-all-h3-cc.dts
+++ b/arch/arm/boot/dts/sun8i-h3-libretech-all-h3-cc.dts
@@ -154,8 +154,7 @@
 	pinctrl-0 = <&mmc0_pins_a>;
 	vmmc-supply = <&reg_vcc_io>;
 	bus-width = <4>;
-	cd-gpios = <&pio 5 6 GPIO_ACTIVE_HIGH>; /* PF6 */
-	cd-inverted;
+	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>; /* PF6 */
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun8i-h3-nanopi-neo-air.dts b/arch/arm/boot/dts/sun8i-h3-nanopi-neo-air.dts
index 03ff6f8b93ff..52eb3287c192 100644
--- a/arch/arm/boot/dts/sun8i-h3-nanopi-neo-air.dts
+++ b/arch/arm/boot/dts/sun8i-h3-nanopi-neo-air.dts
@@ -79,8 +79,7 @@
 	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
-	cd-gpios = <&pio 5 6 GPIO_ACTIVE_HIGH>; /* PF6 */
-	cd-inverted;
+	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>; /* PF6 */
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun8i-h3-nanopi.dtsi b/arch/arm/boot/dts/sun8i-h3-nanopi.dtsi
index 7646e331bd29..e9af61394f5d 100644
--- a/arch/arm/boot/dts/sun8i-h3-nanopi.dtsi
+++ b/arch/arm/boot/dts/sun8i-h3-nanopi.dtsi
@@ -95,8 +95,7 @@
 
 &mmc0 {
 	bus-width = <4>;
-	cd-gpios = <&pio 5 6 GPIO_ACTIVE_HIGH>;
-	cd-inverted;
+	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin>;
 	status = "okay";
diff --git a/arch/arm/boot/dts/sun8i-h3-orangepi-2.dts b/arch/arm/boot/dts/sun8i-h3-orangepi-2.dts
index b20be95b49d5..629f76b85005 100644
--- a/arch/arm/boot/dts/sun8i-h3-orangepi-2.dts
+++ b/arch/arm/boot/dts/sun8i-h3-orangepi-2.dts
@@ -136,8 +136,7 @@
 	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
-	cd-gpios = <&pio 5 6 GPIO_ACTIVE_HIGH>; /* PF6 */
-	cd-inverted;
+	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>; /* PF6 */
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun8i-h3-orangepi-lite.dts b/arch/arm/boot/dts/sun8i-h3-orangepi-lite.dts
index a70a1daf4e2c..398f975b380d 100644
--- a/arch/arm/boot/dts/sun8i-h3-orangepi-lite.dts
+++ b/arch/arm/boot/dts/sun8i-h3-orangepi-lite.dts
@@ -110,8 +110,7 @@
 	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
-	cd-gpios = <&pio 5 6 GPIO_ACTIVE_HIGH>; /* PF6 */
-	cd-inverted;
+	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>; /* PF6 */
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun8i-h3-orangepi-one.dts b/arch/arm/boot/dts/sun8i-h3-orangepi-one.dts
index 82e5d28cd698..40941fef4ff3 100644
--- a/arch/arm/boot/dts/sun8i-h3-orangepi-one.dts
+++ b/arch/arm/boot/dts/sun8i-h3-orangepi-one.dts
@@ -110,8 +110,7 @@
 	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
-	cd-gpios = <&pio 5 6 GPIO_ACTIVE_HIGH>; /* PF6 */
-	cd-inverted;
+	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>; /* PF6 */
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts b/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts
index d22546df1b82..c4769def8cd6 100644
--- a/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts
+++ b/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts
@@ -132,8 +132,7 @@
 	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
-	cd-gpios = <&pio 5 6 GPIO_ACTIVE_HIGH>; /* PF6 */
-	cd-inverted;
+	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>; /* PF6 */
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun8i-r16-bananapi-m2m.dts b/arch/arm/boot/dts/sun8i-r16-bananapi-m2m.dts
index eaf09666720d..0dbdb29a8fff 100644
--- a/arch/arm/boot/dts/sun8i-r16-bananapi-m2m.dts
+++ b/arch/arm/boot/dts/sun8i-r16-bananapi-m2m.dts
@@ -150,8 +150,7 @@
 	pinctrl-0 = <&mmc0_pins_a>;
 	vmmc-supply = <&reg_dcdc1>;
 	bus-width = <4>;
-	cd-gpios = <&pio 1 4 GPIO_ACTIVE_HIGH>; /* PB4 */
-	cd-inverted;
+	cd-gpios = <&pio 1 4 GPIO_ACTIVE_LOW>; /* PB4 */
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts b/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts
index 8c5efe2a9881..27d9ccd0ef2f 100644
--- a/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts
+++ b/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts
@@ -164,8 +164,7 @@
 &mmc0 {
 	vmmc-supply = <&reg_dcdc1>;
 	bus-width = <4>;
-	cd-gpios = <&pio 7 13 GPIO_ACTIVE_HIGH>; /* PH13 */
-	cd-inverted;
+	cd-gpios = <&pio 7 13 GPIO_ACTIVE_LOW>; /* PH13 */
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun8i-reference-design-tablet.dtsi b/arch/arm/boot/dts/sun8i-reference-design-tablet.dtsi
index d6bd15898db6..f51f37cc721d 100644
--- a/arch/arm/boot/dts/sun8i-reference-design-tablet.dtsi
+++ b/arch/arm/boot/dts/sun8i-reference-design-tablet.dtsi
@@ -85,8 +85,7 @@
 	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin>;
 	vmmc-supply = <&reg_dcdc1>;
 	bus-width = <4>;
-	cd-gpios = <&pio 1 4 GPIO_ACTIVE_HIGH>; /* PB4 */
-	cd-inverted;
+	cd-gpios = <&pio 1 4 GPIO_ACTIVE_LOW>; /* PB4 */
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun8i-v40-bananapi-m2-berry.dts b/arch/arm/boot/dts/sun8i-v40-bananapi-m2-berry.dts
index fe16fc0eb518..a26d72c3f9b5 100644
--- a/arch/arm/boot/dts/sun8i-v40-bananapi-m2-berry.dts
+++ b/arch/arm/boot/dts/sun8i-v40-bananapi-m2-berry.dts
@@ -150,8 +150,7 @@
 &mmc0 {
 	vmmc-supply = <&reg_dcdc1>;
 	bus-width = <4>;
-	cd-gpios = <&pio 7 13 GPIO_ACTIVE_HIGH>; /* PH13 */
-	cd-inverted;
+	cd-gpios = <&pio 7 13 GPIO_ACTIVE_LOW>; /* PH13 */
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun9i-a80-cubieboard4.dts b/arch/arm/boot/dts/sun9i-a80-cubieboard4.dts
index 4024639aa005..31b06ecbc306 100644
--- a/arch/arm/boot/dts/sun9i-a80-cubieboard4.dts
+++ b/arch/arm/boot/dts/sun9i-a80-cubieboard4.dts
@@ -88,8 +88,7 @@
 	pinctrl-0 = <&mmc0_pins>;
 	vmmc-supply = <&reg_dcdc1>;
 	bus-width = <4>;
-	cd-gpios = <&pio 7 18 GPIO_ACTIVE_HIGH>; /* PH18 */
-	cd-inverted;
+	cd-gpios = <&pio 7 18 GPIO_ACTIVE_LOW>; /* PH18 */
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun9i-a80-optimus.dts b/arch/arm/boot/dts/sun9i-a80-optimus.dts
index a9b807be99a0..58a199b0e494 100644
--- a/arch/arm/boot/dts/sun9i-a80-optimus.dts
+++ b/arch/arm/boot/dts/sun9i-a80-optimus.dts
@@ -125,8 +125,7 @@
 	pinctrl-0 = <&mmc0_pins>;
 	vmmc-supply = <&reg_dcdc1>;
 	bus-width = <4>;
-	cd-gpios = <&pio 7 18 GPIO_ACTIVE_HIGH>; /* PH8 */
-	cd-inverted;
+	cd-gpios = <&pio 7 18 GPIO_ACTIVE_LOW>; /* PH8 */
 	status = "okay";
 };
 
-- 
2.15.0
