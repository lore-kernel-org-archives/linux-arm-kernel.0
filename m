From: wens@csie.org (Chen-Yu Tsai)
Date: Thu,  6 Mar 2014 00:27:11 +0800
Subject: [PATCH 1/5] ARM: sun6i: dt: Add pin muxing options for GMAC
In-Reply-To: <1394036835-22007-1-git-send-email-wens@csie.org>
References: <1394036835-22007-1-git-send-email-wens@csie.org>
Message-ID: <1394036835-22007-2-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The A31 SoC has a GMAC gigabit ethernet controller supporting
MII, GMII, RGMII modes. Add pin muxing options for these modes.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun6i-a31.dtsi | 42 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
index 42f310a..4d2a2bf 100644
--- a/arch/arm/boot/dts/sun6i-a31.dtsi
+++ b/arch/arm/boot/dts/sun6i-a31.dtsi
@@ -257,6 +257,48 @@
 				allwinner,drive = <0>;
 				allwinner,pull = <0>;
 			};
+
+			gmac_pins_mii_a: gmac_mii at 0 {
+				allwinner,pins = "PA0", "PA1", "PA2", "PA3",
+						"PA8", "PA9", "PA11",
+						"PA12", "PA13", "PA14", "PA19",
+						"PA20", "PA21", "PA22", "PA23",
+						"PA24", "PA26", "PA27";
+				allwinner,function = "gmac";
+				allwinner,drive = <0>;
+				allwinner,pull = <0>;
+			};
+
+			gmac_pins_gmii_a: gmac_gmii at 0 {
+				allwinner,pins = "PA0", "PA1", "PA2", "PA3",
+						"PA4", "PA5", "PA6", "PA7",
+						"PA8", "PA9", "PA10", "PA11",
+						"PA12", "PA13", "PA14",	"PA15",
+						"PA16", "PA17", "PA18", "PA19",
+						"PA20", "PA21", "PA22", "PA23",
+						"PA24", "PA25", "PA26", "PA27";
+				allwinner,function = "gmac";
+				/*
+				 * data lines in GMII mode run at 125MHz and
+				 * might need a higher signal drive strength
+				 */
+				allwinner,drive = <2>;
+				allwinner,pull = <0>;
+			};
+
+			gmac_pins_rgmii_a: gmac_rgmii at 0 {
+				allwinner,pins = "PA0", "PA1", "PA2", "PA3",
+						"PA9", "PA10", "PA11",
+						"PA12", "PA13", "PA14", "PA19",
+						"PA20", "PA25", "PA26", "PA27";
+				allwinner,function = "gmac";
+				/*
+				 * data lines in RGMII mode use DDR mode
+				 * and need a higher signal drive strength
+				 */
+				allwinner,drive = <3>;
+				allwinner,pull = <0>;
+			};
 		};
 
 		ahb1_rst: reset at 01c202c0 {
-- 
1.9.0
