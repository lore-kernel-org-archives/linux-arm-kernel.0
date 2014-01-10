From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 10 Jan 2014 15:00:13 +0800
Subject: [PATCH v2 12/16] ARM: dts: sun7i: Add pin muxing options for the GMAC
In-Reply-To: <1389337217-29032-1-git-send-email-wens@csie.org>
References: <1389337217-29032-1-git-send-email-wens@csie.org>
Message-ID: <1389337217-29032-13-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The A20 has EMAC and GMAC muxed on the same pins.
Add pin sets with gmac function for MII and RGMII mode to the DTSI.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun7i-a20.dtsi | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index 18d211e..b18f18f 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -463,6 +463,32 @@
 				allwinner,drive = <0>;
 				allwinner,pull = <0>;
 			};
+
+			gmac_pins_mii_a: gmac_mii at 0 {
+				allwinner,pins = "PA0", "PA1", "PA2",
+						"PA3", "PA4", "PA5", "PA6",
+						"PA7", "PA8", "PA9", "PA10",
+						"PA11", "PA12", "PA13", "PA14",
+						"PA15", "PA16";
+				allwinner,function = "gmac";
+				allwinner,drive = <0>;
+				allwinner,pull = <0>;
+			};
+
+			gmac_pins_rgmii_a: gmac_rgmii at 0 {
+				allwinner,pins = "PA0", "PA1", "PA2",
+						"PA3", "PA4", "PA5", "PA6",
+						"PA7", "PA8", "PA10",
+						"PA11", "PA12", "PA13",
+						"PA15", "PA16";
+				allwinner,function = "gmac";
+				/*
+				 * data lines in RGMII mode use DDR mode
+				 * and need a higher signal drive strength
+				 */
+				allwinner,drive = <3>;
+				allwinner,pull = <0>;
+			};
 		};
 
 		timer at 01c20c00 {
-- 
1.8.5.2
