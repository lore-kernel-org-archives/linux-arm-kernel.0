From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 27 Nov 2018 13:45:18 +0100
Subject: [PATCH 17/77] ARM: dts: sunxi: Change LRADC node names to avoid
 warnings
In-Reply-To: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
References: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
Message-ID: <ac22e434043703cafb6340512ee3dfc7e50600aa.1543321707.git-series.maxime.ripard@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

One of the usage of the LRADC is to implement buttons. The bindings define
that we should have one subnode per button, with their associated voltage
as a property.

However, there was no reg property but we still used the voltage associated
to the button as the unit-address, which eventually generated warnings in
DTC.

Rename the node names to avoid those warnings.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 arch/arm/boot/dts/sunxi-reference-design-tablet.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/sunxi-reference-design-tablet.dtsi b/arch/arm/boot/dts/sunxi-reference-design-tablet.dtsi
index 245d0bcde441..00dc6623f30f 100644
--- a/arch/arm/boot/dts/sunxi-reference-design-tablet.dtsi
+++ b/arch/arm/boot/dts/sunxi-reference-design-tablet.dtsi
@@ -60,14 +60,14 @@
 	vref-supply = <&reg_vcc3v0>;
 	status = "okay";
 
-	button at 200 {
+	button-200 {
 		label = "Volume Up";
 		linux,code = <KEY_VOLUMEUP>;
 		channel = <0>;
 		voltage = <200000>;
 	};
 
-	button at 400 {
+	button-400 {
 		label = "Volume Down";
 		linux,code = <KEY_VOLUMEDOWN>;
 		channel = <0>;
-- 
git-series 0.9.1
