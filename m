From: jbrunet@baylibre.com (Jerome Brunet)
Date: Tue,  1 Aug 2017 17:22:24 +0200
Subject: [PATCH] ARM64: dts: meson-gxbb: p20x: add card regulator settle times
Message-ID: <20170801152224.15754-1-jbrunet@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changing the card voltage on the p200 is not instantaneous, especially
when switching from 3.3v to 1.8v.

I take at least 70ms for the regulator to go from 3.3v to 1.8v. Add
margin to that to make sure we don't upset the sdcard during the voltage
switch

Fixes: ef8d2ffedf18 ("ARM64: dts: meson-gxbb: add MMC support")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi
index 9603a635c7af..d3b194c20b72 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi
@@ -84,6 +84,9 @@
 		/* Based on P200 schematics, signal CARD_1.8V/3.3V_CTR */
 		states = <1800000 0
 			  3300000 1>;
+
+		regulator-settling-time-up-us = <10000>;
+		regulator-settling-time-down-us = <150000>;
 	};
 
 	vddio_boot: regulator-vddio_boot {
-- 
2.9.4
