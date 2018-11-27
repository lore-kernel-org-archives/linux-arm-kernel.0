From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 27 Nov 2018 13:45:43 +0100
Subject: [PATCH 42/77] ARM: dts: sun7i: Remove gpio-keys warnings
In-Reply-To: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
References: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
Message-ID: <43e29cf38c94451bbd5b043177b4c3d3e19ca5cc.1543321707.git-series.maxime.ripard@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some gpio-keys definitions in our DTs were having buttons defined with a
unit-address and that would generate a DTC warning.

Change the buttons node names to remove the warnings.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 arch/arm/boot/dts/sun7i-a20-pcduino3.dts | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/sun7i-a20-pcduino3.dts b/arch/arm/boot/dts/sun7i-a20-pcduino3.dts
index fc5319836752..0c0997effdf7 100644
--- a/arch/arm/boot/dts/sun7i-a20-pcduino3.dts
+++ b/arch/arm/boot/dts/sun7i-a20-pcduino3.dts
@@ -75,21 +75,22 @@
 		};
 	};
 
-	gpio_keys {
+	gpio-keys {
 		compatible = "gpio-keys";
-		#address-cells = <1>;
-		#size-cells = <0>;
-		button at 0 {
+
+		back {
 			label = "Key Back";
 			linux,code = <KEY_BACK>;
 			gpios = <&pio 7 17 GPIO_ACTIVE_LOW>;
 		};
-		button at 1 {
+
+		home {
 			label = "Key Home";
 			linux,code = <KEY_HOME>;
 			gpios = <&pio 7 18 GPIO_ACTIVE_LOW>;
 		};
-		button at 2 {
+
+		menu {
 			label = "Key Menu";
 			linux,code = <KEY_MENU>;
 			gpios = <&pio 7 19 GPIO_ACTIVE_LOW>;
-- 
git-series 0.9.1
