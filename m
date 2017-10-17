From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 17 Oct 2017 11:06:26 +0200
Subject: [PATCH 19/23] arm: dts: sun8i: a83t: Add LVDS pins group
In-Reply-To: <cover.fe3d65d1ee05a55224d26e7d113388c428592b26.1508231063.git-series.maxime.ripard@free-electrons.com>
References: <cover.fe3d65d1ee05a55224d26e7d113388c428592b26.1508231063.git-series.maxime.ripard@free-electrons.com>
Message-ID: <4125c6191f39c67963e018a84441551cc1815620.1508231063.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The A83T has an LVDS bus that can be connected to a panel or a bridge. Add
the pinctrl group for it.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun8i-a83t.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a83t.dtsi b/arch/arm/boot/dts/sun8i-a83t.dtsi
index ef07a58859c7..6f1221556587 100644
--- a/arch/arm/boot/dts/sun8i-a83t.dtsi
+++ b/arch/arm/boot/dts/sun8i-a83t.dtsi
@@ -414,6 +414,12 @@
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
