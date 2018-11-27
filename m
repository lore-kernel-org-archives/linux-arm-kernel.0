From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 27 Nov 2018 13:46:07 +0100
Subject: [PATCH 66/77] ARM: dts: sun8i: a23/a33: Provide default muxing for
 relevant controllers
In-Reply-To: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
References: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
Message-ID: <09a0b2b3db79496027cf0c5d1f66b0b0259b76e3.1543321707.git-series.maxime.ripard@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The I2C's and MMC0 controllers have only one muxing option in the SoC. In
such a case, we can just move the muxing into the DTSI, and remove it from
the DTS.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 arch/arm/boot/dts/sun8i-a23-a33.dtsi                 | 8 ++++++++
 arch/arm/boot/dts/sun8i-a23-evb.dts                  | 6 ------
 arch/arm/boot/dts/sun8i-a33-olinuxino.dts            | 2 --
 arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts       | 2 --
 arch/arm/boot/dts/sun8i-r16-bananapi-m2m.dts         | 8 --------
 arch/arm/boot/dts/sun8i-r16-parrot.dts               | 4 ----
 arch/arm/boot/dts/sun8i-reference-design-tablet.dtsi | 2 --
 7 files changed, 8 insertions(+), 24 deletions(-)

diff --git a/arch/arm/boot/dts/sun8i-a23-a33.dtsi b/arch/arm/boot/dts/sun8i-a23-a33.dtsi
index bcb5b30a02f0..c2ff8975ac60 100644
--- a/arch/arm/boot/dts/sun8i-a23-a33.dtsi
+++ b/arch/arm/boot/dts/sun8i-a23-a33.dtsi
@@ -169,6 +169,8 @@
 			resets = <&ccu RST_BUS_MMC0>;
 			reset-names = "ahb";
 			interrupts = <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&mmc0_pins>;
 			status = "disabled";
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -499,6 +501,8 @@
 			interrupts = <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&ccu CLK_BUS_I2C0>;
 			resets = <&ccu RST_BUS_I2C0>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&i2c0_pins>;
 			status = "disabled";
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -510,6 +514,8 @@
 			interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&ccu CLK_BUS_I2C1>;
 			resets = <&ccu RST_BUS_I2C1>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&i2c1_pins>;
 			status = "disabled";
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -521,6 +527,8 @@
 			interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&ccu CLK_BUS_I2C2>;
 			resets = <&ccu RST_BUS_I2C2>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&i2c2_pins>;
 			status = "disabled";
 			#address-cells = <1>;
 			#size-cells = <0>;
diff --git a/arch/arm/boot/dts/sun8i-a23-evb.dts b/arch/arm/boot/dts/sun8i-a23-evb.dts
index 36896155f2b9..53fb1be0401a 100644
--- a/arch/arm/boot/dts/sun8i-a23-evb.dts
+++ b/arch/arm/boot/dts/sun8i-a23-evb.dts
@@ -65,14 +65,10 @@
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
 
@@ -103,8 +99,6 @@
 };
 
 &mmc0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins>;
 	vmmc-supply = <&reg_vcc3v0>;
 	bus-width = <4>;
 	cd-gpios = <&pio 1 4 GPIO_ACTIVE_LOW>; /* PB4 */
diff --git a/arch/arm/boot/dts/sun8i-a33-olinuxino.dts b/arch/arm/boot/dts/sun8i-a33-olinuxino.dts
index 9ad7eeba9df4..3d78169cdeed 100644
--- a/arch/arm/boot/dts/sun8i-a33-olinuxino.dts
+++ b/arch/arm/boot/dts/sun8i-a33-olinuxino.dts
@@ -82,8 +82,6 @@
 };
 
 &mmc0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins>;
 	vmmc-supply = <&reg_dcdc1>;
 	bus-width = <4>;
 	cd-gpios = <&pio 1 4 GPIO_ACTIVE_LOW>; /* PB4 */
diff --git a/arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts b/arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts
index b161a0ce03af..577144d953e0 100644
--- a/arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts
+++ b/arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts
@@ -133,8 +133,6 @@
 };
 
 &mmc0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins>;
 	vmmc-supply = <&reg_dcdc1>;
 	bus-width = <4>;
 	cd-gpios = <&pio 1 4 GPIO_ACTIVE_LOW>; /* PB4 */
diff --git a/arch/arm/boot/dts/sun8i-r16-bananapi-m2m.dts b/arch/arm/boot/dts/sun8i-r16-bananapi-m2m.dts
index a44d80c24416..f613889f445b 100644
--- a/arch/arm/boot/dts/sun8i-r16-bananapi-m2m.dts
+++ b/arch/arm/boot/dts/sun8i-r16-bananapi-m2m.dts
@@ -126,28 +126,20 @@
 
 /* This is the i2c bus exposed on the DSI connector for the touch panel */
 &i2c0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c0_pins>;
 	status = "disabled";
 };
 
 /* This is the i2c bus exposed on the GPIO header */
 &i2c1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c1_pins>;
 	status = "disabled";
 };
 
 /* This is the i2c bus exposed on the CSI connector to control the sensor */
 &i2c2 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c2_pins>;
 	status = "disabled";
 };
 
 &mmc0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins>;
 	vmmc-supply = <&reg_dcdc1>;
 	bus-width = <4>;
 	cd-gpios = <&pio 1 4 GPIO_ACTIVE_LOW>; /* PB4 */
diff --git a/arch/arm/boot/dts/sun8i-r16-parrot.dts b/arch/arm/boot/dts/sun8i-r16-parrot.dts
index 85576092f5d9..058bc84bbfa5 100644
--- a/arch/arm/boot/dts/sun8i-r16-parrot.dts
+++ b/arch/arm/boot/dts/sun8i-r16-parrot.dts
@@ -95,8 +95,6 @@
 };
 
 &i2c1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c1_pins>;
 	status = "okay";
 
 	/*
@@ -126,8 +124,6 @@
 };
 
 &mmc0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins>;
 	vmmc-supply = <&reg_dcdc1>;
 	cd-gpios = <&pio 3 14 GPIO_ACTIVE_LOW>; /* PD14 */
 	bus-width = <4>;
diff --git a/arch/arm/boot/dts/sun8i-reference-design-tablet.dtsi b/arch/arm/boot/dts/sun8i-reference-design-tablet.dtsi
index 0111e6c6f177..189e479eb95a 100644
--- a/arch/arm/boot/dts/sun8i-reference-design-tablet.dtsi
+++ b/arch/arm/boot/dts/sun8i-reference-design-tablet.dtsi
@@ -80,8 +80,6 @@
 };
 
 &mmc0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins>;
 	vmmc-supply = <&reg_dcdc1>;
 	bus-width = <4>;
 	cd-gpios = <&pio 1 4 GPIO_ACTIVE_LOW>; /* PB4 */
-- 
git-series 0.9.1
