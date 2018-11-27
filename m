From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 27 Nov 2018 13:46:08 +0100
Subject: [PATCH 67/77] ARM: dts: sun8i: BPI-M2M: Remove i2c nodes
In-Reply-To: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
References: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
Message-ID: <37f420d9fd609bba74fbcfbf932745a2746caf80.1543321707.git-series.maxime.ripard@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The i2c nodes were pre-populated to ease the use of overlays. However, now
that we provide default muxing options for those nodes, the one in the DTS
don't provide any content at all.

Remove them.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 arch/arm/boot/dts/sun8i-r16-bananapi-m2m.dts | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/arch/arm/boot/dts/sun8i-r16-bananapi-m2m.dts b/arch/arm/boot/dts/sun8i-r16-bananapi-m2m.dts
index f613889f445b..83d32a1a2a63 100644
--- a/arch/arm/boot/dts/sun8i-r16-bananapi-m2m.dts
+++ b/arch/arm/boot/dts/sun8i-r16-bananapi-m2m.dts
@@ -124,21 +124,6 @@
 	status = "okay";
 };
 
-/* This is the i2c bus exposed on the DSI connector for the touch panel */
-&i2c0 {
-	status = "disabled";
-};
-
-/* This is the i2c bus exposed on the GPIO header */
-&i2c1 {
-	status = "disabled";
-};
-
-/* This is the i2c bus exposed on the CSI connector to control the sensor */
-&i2c2 {
-	status = "disabled";
-};
-
 &mmc0 {
 	vmmc-supply = <&reg_dcdc1>;
 	bus-width = <4>;
-- 
git-series 0.9.1
