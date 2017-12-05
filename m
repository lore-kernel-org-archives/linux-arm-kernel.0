From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue,  5 Dec 2017 16:10:24 +0100
Subject: [PATCH v3 12/15] ARM: dts: sun8i: a83t: Add LVDS pins group
In-Reply-To: <cover.825a49a4c1c565a548f3de0375e7537e7e8fd3a4.1512486553.git-series.maxime.ripard@free-electrons.com>
References: <cover.825a49a4c1c565a548f3de0375e7537e7e8fd3a4.1512486553.git-series.maxime.ripard@free-electrons.com>
Message-ID: <2fc5348028da2eeb0d878796593f39265569e929.1512486553.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The A83T has an LVDS bus that can be connected to a panel or a bridge. Add
the pinctrl group for it.

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun8i-a83t.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a83t.dtsi b/arch/arm/boot/dts/sun8i-a83t.dtsi
index 7a49b9f085eb..e200df5a9058 100644
--- a/arch/arm/boot/dts/sun8i-a83t.dtsi
+++ b/arch/arm/boot/dts/sun8i-a83t.dtsi
@@ -415,6 +415,12 @@
 			#interrupt-cells = <3>;
 			#gpio-cells = <3>;
 
+			lcd_lvds_pins: lcd-lvds-pins {
+				pins = "PD18", "PD19", "PD20", "PD21", "PD22",
+				       "PD23", "PD24", "PD25", "PD26", "PD27";
+				function = "lvds0";
+			};
+
 			mmc0_pins: mmc0-pins {
 				pins = "PF0", "PF1", "PF2",
 				       "PF3", "PF4", "PF5";
-- 
git-series 0.9.1
