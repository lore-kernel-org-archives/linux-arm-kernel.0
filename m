From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 12 Mar 2018 12:21:16 +0800
Subject: [PATCH] ARM: dts: sun8i: reference tablet design: Enable PMIC power
 supplies
Message-ID: <20180312042116.18513-1-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The A23/A33 reference tablet design has a DC barrel tied to the ACIN
of the PMIC. And being a tablet, it has a Li-Po battery.

Enable both power supplies in the device tree.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun8i-reference-design-tablet.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-reference-design-tablet.dtsi b/arch/arm/boot/dts/sun8i-reference-design-tablet.dtsi
index f51f37cc721d..880096c7e252 100644
--- a/arch/arm/boot/dts/sun8i-reference-design-tablet.dtsi
+++ b/arch/arm/boot/dts/sun8i-reference-design-tablet.dtsi
@@ -124,6 +124,14 @@
 
 #include "axp223.dtsi"
 
+&ac_power_supply {
+	status = "okay";
+};
+
+&battery_power_supply {
+	status = "okay";
+};
+
 &reg_aldo1 {
 	regulator-always-on;
 	regulator-min-microvolt = <3000000>;
-- 
2.16.2
