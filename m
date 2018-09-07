From: wens@csie.org (Chen-Yu Tsai)
Date: Fri,  7 Sep 2018 12:19:47 +0800
Subject: [PATCH v2 5/6] ARM: dts: sun7i: add pinmux setting for RGB888 output
 for LCD0
In-Reply-To: <20180907041948.19913-1-wens@csie.org>
References: <20180907041948.19913-1-wens@csie.org>
Message-ID: <20180907041948.19913-6-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On the A20, as well as many other Allwinner SoCs, the PD pingroup has
the LCD0 RGB output functions.

Add a pinmux setting for RGB888 output from LCD0, so boards and tablets
with parallel RGB LCD panels may reference it.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun7i-a20.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index 9c52712af241..b2c56833b0e6 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -950,6 +950,17 @@
 				pins = "PI20", "PI21";
 				function = "uart7";
 			};
+
+			lcd0_rgb888_pins: lcd0-rgb888-pins {
+				pins = "PD0", "PD1", "PD2", "PD3", "PD4",
+				       "PD5", "PD6", "PD7", "PD8", "PD9",
+				       "PD10", "PD11", "PD12", "PD13",
+				       "PD14", "PD15", "PD16", "PD17",
+				       "PD18", "PD19", "PD20", "PD21",
+				       "PD22", "PD23", "PD24", "PD25",
+				       "PD26", "PD27";
+				function = "lcd0";
+			};
 		};
 
 		timer at 1c20c00 {
-- 
2.19.0.rc1
