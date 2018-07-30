From: andre.przywara@arm.com (Andre Przywara)
Date: Mon, 30 Jul 2018 13:31:30 +0100
Subject: [PATCH v3 12/19] arm64: dts: allwinner: a64: Orange Pi Win: Adjust
 CSI power rails
In-Reply-To: <20180730123137.923-1-andre.przywara@arm.com>
References: <20180730123137.923-1-andre.przywara@arm.com>
Message-ID: <20180730123137.923-13-andre.przywara@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Samuel Holland <samuel@sholland.org>

The Orange Pi Win board uses the AXP's ALDO1 power rail to drive the
VCC-CSI line, which, according to the schematic, needs to be set to 2.8V.

Also the ELDO3 power rail is connected to the CSI, with somewhat unclear
voltage requirements. Add this regulator and allow the voltage to be set
between 1.5V and 1.8V, which are the voltages mentioned in the
schematic.

Signed-off-by: Samuel Holland <samuel@sholland.org>
Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts
index 3f9c5c8b0264..63812576449f 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts
@@ -160,9 +160,8 @@
 #include "axp803.dtsi"
 
 &reg_aldo1 {
-	regulator-always-on;
-	regulator-min-microvolt = <1800000>;
-	regulator-max-microvolt = <3300000>;
+	regulator-min-microvolt = <2800000>;
+	regulator-max-microvolt = <2800000>;
 	regulator-name = "afvcc-csi";
 };
 
@@ -240,6 +239,12 @@
 	regulator-name = "cpvdd";
 };
 
+&reg_eldo3 {
+	regulator-min-microvolt = <1500000>;
+	regulator-max-microvolt = <1800000>;
+	regulator-name = "dvdd-csi";
+};
+
 &reg_fldo1 {
 	regulator-min-microvolt = <1200000>;
 	regulator-max-microvolt = <1200000>;
-- 
2.14.4
