From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 27 Nov 2018 13:45:02 +0100
Subject: [PATCH 01/77] ARM: dts: sun4i: Fix gpio-keys warning
In-Reply-To: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
References: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
Message-ID: <7176711cb25c70abfcd6807d90b7e8f368618dc9.1543321707.git-series.maxime.ripard@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix the 'unnecessary #address-cells/#size-cells without "ranges" or child
"reg" property' DTC warning for the gpio-keys DT node on A10 boards.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 arch/arm/boot/dts/sun4i-a10-inet9f-rev03.dts | 2 --
 arch/arm/boot/dts/sun4i-a10-pcduino.dts      | 2 --
 2 files changed, 4 deletions(-)

diff --git a/arch/arm/boot/dts/sun4i-a10-inet9f-rev03.dts b/arch/arm/boot/dts/sun4i-a10-inet9f-rev03.dts
index 221acd10f6c8..2f0d966f39ad 100644
--- a/arch/arm/boot/dts/sun4i-a10-inet9f-rev03.dts
+++ b/arch/arm/boot/dts/sun4i-a10-inet9f-rev03.dts
@@ -63,8 +63,6 @@
 		compatible = "gpio-keys-polled";
 		pinctrl-names = "default";
 		pinctrl-0 = <&key_pins_inet9f>;
-		#address-cells = <1>;
-		#size-cells = <0>;
 		poll-interval = <20>;
 
 		left-joystick-left {
diff --git a/arch/arm/boot/dts/sun4i-a10-pcduino.dts b/arch/arm/boot/dts/sun4i-a10-pcduino.dts
index b97a0f2f20b9..d82a604f3d9c 100644
--- a/arch/arm/boot/dts/sun4i-a10-pcduino.dts
+++ b/arch/arm/boot/dts/sun4i-a10-pcduino.dts
@@ -76,8 +76,6 @@
 
 	gpio-keys {
 		compatible = "gpio-keys";
-		#address-cells = <1>;
-		#size-cells = <0>;
 
 		back {
 			label = "Key Back";
-- 
git-series 0.9.1
