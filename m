From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 27 Nov 2018 13:45:22 +0100
Subject: [PATCH 21/77] ARM: dts: sun5i: Provide default muxing for relevant
 controllers
In-Reply-To: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
References: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
Message-ID: <5df3fa47088bbebe5c1e16f917b055e37132dba3.1543321707.git-series.maxime.ripard@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The I2C's, MMC0 and MMC1 controllers have only one muxing option in the
SoC. In such a case, we can just move the muxing into the DTSI, and remove
it from the DTS.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 arch/arm/boot/dts/sun5i-a10s-auxtek-t003.dts           |  4 ----
 arch/arm/boot/dts/sun5i-a10s-auxtek-t004.dts           |  6 ------
 arch/arm/boot/dts/sun5i-a10s-mk802.dts                 |  6 ------
 arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts       | 10 ----------
 arch/arm/boot/dts/sun5i-a10s-r7-tv-dongle.dts          |  4 ----
 arch/arm/boot/dts/sun5i-a10s-wobo-i5.dts               |  4 ----
 arch/arm/boot/dts/sun5i-a10s.dtsi                      |  5 +++++
 arch/arm/boot/dts/sun5i-a13-empire-electronix-d709.dts |  6 ------
 arch/arm/boot/dts/sun5i-a13-hsg-h702.dts               |  8 --------
 arch/arm/boot/dts/sun5i-a13-licheepi-one.dts           |  8 --------
 arch/arm/boot/dts/sun5i-a13-olinuxino-micro.dts        |  8 --------
 arch/arm/boot/dts/sun5i-a13-olinuxino.dts              |  8 --------
 arch/arm/boot/dts/sun5i-gr8-chip-pro.dts               |  6 ------
 arch/arm/boot/dts/sun5i-gr8-evb.dts                    |  8 --------
 arch/arm/boot/dts/sun5i-r8-chip.dts                    |  8 --------
 arch/arm/boot/dts/sun5i.dtsi                           |  8 ++++++++
 16 files changed, 13 insertions(+), 94 deletions(-)

diff --git a/arch/arm/boot/dts/sun5i-a10s-auxtek-t003.dts b/arch/arm/boot/dts/sun5i-a10s-auxtek-t003.dts
index f5c50b66290a..64d50fcfcd3a 100644
--- a/arch/arm/boot/dts/sun5i-a10s-auxtek-t003.dts
+++ b/arch/arm/boot/dts/sun5i-a10s-auxtek-t003.dts
@@ -75,8 +75,6 @@
 };
 
 &i2c0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c0_pins>;
 	status = "okay";
 
 	axp152: pmic at 30 {
@@ -89,8 +87,6 @@
 };
 
 &mmc0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	cd-gpios = <&pio 6 1 GPIO_ACTIVE_LOW>; /* PG1 */
diff --git a/arch/arm/boot/dts/sun5i-a10s-auxtek-t004.dts b/arch/arm/boot/dts/sun5i-a10s-auxtek-t004.dts
index 648f03d2132b..fc466e05af23 100644
--- a/arch/arm/boot/dts/sun5i-a10s-auxtek-t004.dts
+++ b/arch/arm/boot/dts/sun5i-a10s-auxtek-t004.dts
@@ -85,8 +85,6 @@
 };
 
 &i2c0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c0_pins>;
 	status = "okay";
 
 	axp152: pmic at 30 {
@@ -99,8 +97,6 @@
 };
 
 &mmc0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	cd-gpios = <&pio 6 1 GPIO_ACTIVE_LOW>; /* PG1 */
@@ -108,8 +104,6 @@
 };
 
 &mmc1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc1_pins>;
 	vmmc-supply = <&reg_vmmc1>;
 	bus-width = <4>;
 	non-removable;
diff --git a/arch/arm/boot/dts/sun5i-a10s-mk802.dts b/arch/arm/boot/dts/sun5i-a10s-mk802.dts
index 06b876c50f15..6e90ccb267aa 100644
--- a/arch/arm/boot/dts/sun5i-a10s-mk802.dts
+++ b/arch/arm/boot/dts/sun5i-a10s-mk802.dts
@@ -72,8 +72,6 @@
 };
 
 &i2c0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c0_pins>;
 	status = "okay";
 
 	axp152: pmic at 30 {
@@ -86,8 +84,6 @@
 };
 
 &mmc0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	cd-gpios = <&pio 6 1 GPIO_ACTIVE_LOW>; /* PG1 */
@@ -95,8 +91,6 @@
 };
 
 &mmc1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc1_pins>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	non-removable;
diff --git a/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts b/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts
index ae6d4a0bb9c9..262c2ffbdcfa 100644
--- a/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts
+++ b/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts
@@ -117,8 +117,6 @@
 };
 
 &i2c0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c0_pins>;
 	status = "okay";
 
 	axp152: pmic at 30 {
@@ -130,8 +128,6 @@
 #include "axp152.dtsi"
 
 &i2c1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c1_pins>;
 	status = "okay";
 
 	at24 at 50 {
@@ -143,8 +139,6 @@
 };
 
 &i2c2 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c2_pins>;
 	status = "okay";
 };
 
@@ -197,8 +191,6 @@
 };
 
 &mmc0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	cd-gpios = <&pio 6 1 GPIO_ACTIVE_LOW>; /* PG1 */
@@ -206,8 +198,6 @@
 };
 
 &mmc1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc1_pins>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	cd-gpios = <&pio 6 13 GPIO_ACTIVE_LOW>; /* PG13 */
diff --git a/arch/arm/boot/dts/sun5i-a10s-r7-tv-dongle.dts b/arch/arm/boot/dts/sun5i-a10s-r7-tv-dongle.dts
index afbda5dd773b..b2a49a216ebf 100644
--- a/arch/arm/boot/dts/sun5i-a10s-r7-tv-dongle.dts
+++ b/arch/arm/boot/dts/sun5i-a10s-r7-tv-dongle.dts
@@ -76,8 +76,6 @@
 };
 
 &mmc0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	cd-gpios = <&pio 6 1 GPIO_ACTIVE_LOW>; /* PG1 */
@@ -85,8 +83,6 @@
 };
 
 &mmc1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc1_pins>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	non-removable;
diff --git a/arch/arm/boot/dts/sun5i-a10s-wobo-i5.dts b/arch/arm/boot/dts/sun5i-a10s-wobo-i5.dts
index 5683cc483a49..b5ee8fb13a92 100644
--- a/arch/arm/boot/dts/sun5i-a10s-wobo-i5.dts
+++ b/arch/arm/boot/dts/sun5i-a10s-wobo-i5.dts
@@ -100,8 +100,6 @@
 };
 
 &i2c0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c0_pins>;
 	status = "okay";
 
 	axp209: pmic at 34 {
@@ -122,8 +120,6 @@
 };
 
 &mmc0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	cd-gpios = <&pio 1 3 GPIO_ACTIVE_LOW>; /* PB3 */
diff --git a/arch/arm/boot/dts/sun5i-a10s.dtsi b/arch/arm/boot/dts/sun5i-a10s.dtsi
index cd7119273b80..09c486b608b2 100644
--- a/arch/arm/boot/dts/sun5i-a10s.dtsi
+++ b/arch/arm/boot/dts/sun5i-a10s.dtsi
@@ -119,6 +119,11 @@
 	compatible = "allwinner,sun5i-a10s-ccu";
 };
 
+&mmc1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc1_pins>;
+};
+
 &pio {
 	compatible = "allwinner,sun5i-a10s-pinctrl";
 
diff --git a/arch/arm/boot/dts/sun5i-a13-empire-electronix-d709.dts b/arch/arm/boot/dts/sun5i-a13-empire-electronix-d709.dts
index 49eaa1920088..f3cede9beb63 100644
--- a/arch/arm/boot/dts/sun5i-a13-empire-electronix-d709.dts
+++ b/arch/arm/boot/dts/sun5i-a13-empire-electronix-d709.dts
@@ -78,8 +78,6 @@
 };
 
 &i2c0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c0_pins>;
 	status = "okay";
 
 	axp209: pmic at 34 {
@@ -91,8 +89,6 @@
 #include "axp209.dtsi"
 
 &i2c1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c1_pins>;
 	status = "okay";
 
 	pcf8563: rtc at 51 {
@@ -121,8 +117,6 @@
 };
 
 &mmc0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	cd-gpios = <&pio 6 0 GPIO_ACTIVE_LOW>; /* PG0 */
diff --git a/arch/arm/boot/dts/sun5i-a13-hsg-h702.dts b/arch/arm/boot/dts/sun5i-a13-hsg-h702.dts
index 082a1501eaf1..9369f7453beb 100644
--- a/arch/arm/boot/dts/sun5i-a13-hsg-h702.dts
+++ b/arch/arm/boot/dts/sun5i-a13-hsg-h702.dts
@@ -69,8 +69,6 @@
 };
 
 &i2c0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c0_pins>;
 	status = "okay";
 
 	axp209: pmic at 34 {
@@ -80,8 +78,6 @@
 };
 
 &i2c1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c1_pins>;
 	status = "okay";
 
 	pcf8563: rtc at 51 {
@@ -91,8 +87,6 @@
 };
 
 &i2c2 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c2_pins>;
 	status = "okay";
 };
 
@@ -116,8 +110,6 @@
 };
 
 &mmc0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	cd-gpios = <&pio 6 0 GPIO_ACTIVE_LOW>; /* PG0 */
diff --git a/arch/arm/boot/dts/sun5i-a13-licheepi-one.dts b/arch/arm/boot/dts/sun5i-a13-licheepi-one.dts
index f2ecd81a3183..ca8f3fd1ddfe 100644
--- a/arch/arm/boot/dts/sun5i-a13-licheepi-one.dts
+++ b/arch/arm/boot/dts/sun5i-a13-licheepi-one.dts
@@ -94,8 +94,6 @@
 };
 
 &i2c0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c0_pins>;
 	status = "okay";
 
 	axp209: pmic at 34 {
@@ -109,14 +107,10 @@
 };
 
 &i2c1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c1_pins>;
 	status = "disabled";
 };
 
 &i2c2 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c2_pins>;
 	status = "disabled";
 };
 
@@ -133,8 +127,6 @@
 };
 
 &mmc0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	broken-cd;
diff --git a/arch/arm/boot/dts/sun5i-a13-olinuxino-micro.dts b/arch/arm/boot/dts/sun5i-a13-olinuxino-micro.dts
index cf5f730d5efa..943868e495bc 100644
--- a/arch/arm/boot/dts/sun5i-a13-olinuxino-micro.dts
+++ b/arch/arm/boot/dts/sun5i-a13-olinuxino-micro.dts
@@ -77,26 +77,18 @@
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
 
 &mmc0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	cd-gpios = <&pio 6 0 GPIO_ACTIVE_LOW>; /* PG0 */
diff --git a/arch/arm/boot/dts/sun5i-a13-olinuxino.dts b/arch/arm/boot/dts/sun5i-a13-olinuxino.dts
index 7c506de4a1ee..54ca140fc258 100644
--- a/arch/arm/boot/dts/sun5i-a13-olinuxino.dts
+++ b/arch/arm/boot/dts/sun5i-a13-olinuxino.dts
@@ -121,8 +121,6 @@
 };
 
 &i2c0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c0_pins>;
 	status = "okay";
 
 	axp209: pmic at 34 {
@@ -136,14 +134,10 @@
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
 
@@ -188,8 +182,6 @@
 };
 
 &mmc0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	cd-gpios = <&pio 6 0 GPIO_ACTIVE_LOW>; /* PG0 */
diff --git a/arch/arm/boot/dts/sun5i-gr8-chip-pro.dts b/arch/arm/boot/dts/sun5i-gr8-chip-pro.dts
index 7a5ba22c7354..3f70b8c53132 100644
--- a/arch/arm/boot/dts/sun5i-gr8-chip-pro.dts
+++ b/arch/arm/boot/dts/sun5i-gr8-chip-pro.dts
@@ -92,8 +92,6 @@
 };
 
 &i2c0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c0_pins>;
 	status = "okay";
 
 	axp209: pmic at 34 {
@@ -112,8 +110,6 @@
 #include "axp209.dtsi"
 
 &i2c1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c1_pins>;
 	status = "disabled";
 };
 
@@ -124,8 +120,6 @@
 };
 
 &mmc0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins>;
 	vmmc-supply = <&reg_vcc3v3>;
 	mmc-pwrseq = <&mmc0_pwrseq>;
 	bus-width = <4>;
diff --git a/arch/arm/boot/dts/sun5i-gr8-evb.dts b/arch/arm/boot/dts/sun5i-gr8-evb.dts
index ea1711a31cce..86e46aa59134 100644
--- a/arch/arm/boot/dts/sun5i-gr8-evb.dts
+++ b/arch/arm/boot/dts/sun5i-gr8-evb.dts
@@ -123,8 +123,6 @@
 };
 
 &i2c0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c0_pins>;
 	status = "okay";
 
 	axp209: pmic at 34 {
@@ -143,8 +141,6 @@
 #include "axp209.dtsi"
 
 &i2c1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c1_pins>;
 	status = "okay";
 
 	wm8978: codec at 1a {
@@ -160,8 +156,6 @@
 };
 
 &i2c2 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c2_pins>;
 	status = "okay";
 };
 
@@ -232,8 +226,6 @@
 };
 
 &mmc0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	cd-gpios = <&pio 6 0 GPIO_ACTIVE_LOW>; /* PG0 */
diff --git a/arch/arm/boot/dts/sun5i-r8-chip.dts b/arch/arm/boot/dts/sun5i-r8-chip.dts
index 3c9f4f35d43b..f4298facf9dc 100644
--- a/arch/arm/boot/dts/sun5i-r8-chip.dts
+++ b/arch/arm/boot/dts/sun5i-r8-chip.dts
@@ -107,8 +107,6 @@
 };
 
 &i2c0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c0_pins>;
 	status = "okay";
 
 	axp209: pmic at 34 {
@@ -135,14 +133,10 @@
 };
 
 &i2c1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c1_pins>;
 	status = "disabled";
 };
 
 &i2c2 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c2_pins>;
 	status = "okay";
 
 	xio: gpio at 38 {
@@ -164,8 +158,6 @@
 };
 
 &mmc0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins>;
 	vmmc-supply = <&reg_vcc3v3>;
 	mmc-pwrseq = <&mmc0_pwrseq>;
 	bus-width = <4>;
diff --git a/arch/arm/boot/dts/sun5i.dtsi b/arch/arm/boot/dts/sun5i.dtsi
index b6b67d84ddda..ccd793795e58 100644
--- a/arch/arm/boot/dts/sun5i.dtsi
+++ b/arch/arm/boot/dts/sun5i.dtsi
@@ -320,6 +320,8 @@
 			clocks = <&ccu CLK_AHB_MMC0>, <&ccu CLK_MMC0>;
 			clock-names = "ahb", "mmc";
 			interrupts = <32>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&mmc0_pins>;
 			status = "disabled";
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -672,6 +674,8 @@
 			reg = <0x01c2ac00 0x400>;
 			interrupts = <7>;
 			clocks = <&ccu CLK_APB1_I2C0>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&i2c0_pins>;
 			status = "disabled";
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -682,6 +686,8 @@
 			reg = <0x01c2b000 0x400>;
 			interrupts = <8>;
 			clocks = <&ccu CLK_APB1_I2C1>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&i2c1_pins>;
 			status = "disabled";
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -692,6 +698,8 @@
 			reg = <0x01c2b400 0x400>;
 			interrupts = <9>;
 			clocks = <&ccu CLK_APB1_I2C2>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&i2c2_pins>;
 			status = "disabled";
 			#address-cells = <1>;
 			#size-cells = <0>;
-- 
git-series 0.9.1
