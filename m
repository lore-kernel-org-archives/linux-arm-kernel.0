From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 27 Nov 2018 13:46:10 +0100
Subject: [PATCH 69/77] ARM: dts: sun8i: v3s: Change LRADC node names to avoid
 warnings
In-Reply-To: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
References: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
Message-ID: <9845d0f35e3dc09d9ab6296618ebaa18e2305954.1543321707.git-series.maxime.ripard@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

One of the usage of the LRADC is to implement buttons. The bindings define
that we should have one subnode per button, with their associated voltage
as a property.

However, there was no reg property but we still used the voltage associated
to the button as the unit-address, which eventually generated warnings in
DTC.

Rename the node names to avoid those warnings.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun8i-v3s-licheepi-zero-dock.dts | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/sun8i-v3s-licheepi-zero-dock.dts b/arch/arm/boot/dts/sun8i-v3s-licheepi-zero-dock.dts
index ad173605b1b8..db5cd0b8574b 100644
--- a/arch/arm/boot/dts/sun8i-v3s-licheepi-zero-dock.dts
+++ b/arch/arm/boot/dts/sun8i-v3s-licheepi-zero-dock.dts
@@ -66,28 +66,28 @@
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
 		voltage = <400000>;
 	};
 
-	button at 600 {
+	button-600 {
 		label = "Select";
 		linux,code = <KEY_SELECT>;
 		channel = <0>;
 		voltage = <600000>;
 	};
 
-	button at 800 {
+	button-800 {
 		label = "Start";
 		linux,code = <KEY_OK>;
 		channel = <0>;
-- 
git-series 0.9.1
