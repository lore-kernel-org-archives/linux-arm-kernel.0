From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 12 Oct 2017 16:05:42 +0800
Subject: [PATCH] ARM: dts: sun5i: reference-design-tablet: Enable AXP209 AC
 and battery
Message-ID: <20171012080542.21862-1-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The reference design tablet has the DC jack wired to AXP209's ACIN.
As a tablet, it also has an internal LiPo battery, wired to the PMIC's
battery charger.

Enable both.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun5i-reference-design-tablet.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/sun5i-reference-design-tablet.dtsi b/arch/arm/boot/dts/sun5i-reference-design-tablet.dtsi
index 8a4d2277826f..49229b3d5492 100644
--- a/arch/arm/boot/dts/sun5i-reference-design-tablet.dtsi
+++ b/arch/arm/boot/dts/sun5i-reference-design-tablet.dtsi
@@ -110,6 +110,14 @@
 
 #include "axp209.dtsi"
 
+&ac_power_supply {
+	status = "okay";
+};
+
+&battery_power_supply {
+	status = "okay";
+};
+
 &lradc {
 	vref-supply = <&reg_ldo2>;
 };
-- 
2.14.2
