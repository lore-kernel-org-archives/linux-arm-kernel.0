From: andre.przywara@arm.com (Andre Przywara)
Date: Thu, 26 Jul 2018 01:35:25 +0100
Subject: [PATCH v2 11/18] arm64: dts: allwinner: a64: Orange Pi Win: Add
 missing power rails
In-Reply-To: <20180726003532.18751-1-andre.przywara@arm.com>
References: <20180726003532.18751-1-andre.przywara@arm.com>
Message-ID: <20180726003532.18751-12-andre.przywara@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Samuel Holland <samuel@sholland.org>

The Orange Pi Win board has some of the AXP's power rails connected
on the board. Name them and adjust the voltage ranges.

Signed-off-by: Samuel Holland <samuel@sholland.org>
Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts
index ec24b7379d6d..db4f6db9347b 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts
@@ -164,10 +164,9 @@
 #include "axp803.dtsi"
 
 &reg_aldo1 {
-	regulator-always-on;
-	regulator-min-microvolt = <1800000>;
-	regulator-max-microvolt = <3300000>;
-	regulator-name = "afvcc-csi";
+	regulator-min-microvolt = <2800000>;
+	regulator-max-microvolt = <2800000>;
+	regulator-name = "vcc-csi";
 };
 
 &reg_aldo2 {
@@ -241,7 +240,13 @@
 &reg_eldo1 {
 	regulator-min-microvolt = <1800000>;
 	regulator-max-microvolt = <1800000>;
-	regulator-name = "cpvdd";
+	regulator-name = "vcc-pc";
+};
+
+&reg_eldo3 {
+	regulator-min-microvolt = <1500000>;
+	regulator-max-microvolt = <1800000>;
+	regulator-name = "dvdd-csi";
 };
 
 &reg_fldo1 {
-- 
2.14.4
