From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon,  4 Apr 2016 10:22:11 +0900
Subject: [PATCH 03/26] ARM: dts: armadillo800eva: use generic pinctrl
 properties
In-Reply-To: <cover.1459731908.git.horms+renesas@verge.net.au>
References: <cover.1459731908.git.horms+renesas@verge.net.au>
Message-ID: <1ba1e26ededf070da2b1af117f912d2d9f05accf.1459731908.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since 16ccaf5bb5a5 ("pinctrl: sh-pfc: Accept standard function, pins and
groups properties") renesas pfc drivers accept generic "function", "pins"
and "groups" properties.

This patch updates the armadillo800eva device tree to use the generic
properties.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a7740-armadillo800eva.dts | 34 +++++++++++++--------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7740-armadillo800eva.dts b/arch/arm/boot/dts/r8a7740-armadillo800eva.dts
index c548cabb102f..2c82dab2b6f4 100644
--- a/arch/arm/boot/dts/r8a7740-armadillo800eva.dts
+++ b/arch/arm/boot/dts/r8a7740-armadillo800eva.dts
@@ -228,44 +228,44 @@
 	pinctrl-names = "default";
 
 	ether_pins: ether {
-		renesas,groups = "gether_mii", "gether_int";
-		renesas,function = "gether";
+		groups = "gether_mii", "gether_int";
+		function = "gether";
 	};
 
 	scifa1_pins: serial1 {
-		renesas,groups = "scifa1_data";
-		renesas,function = "scifa1";
+		groups = "scifa1_data";
+		function = "scifa1";
 	};
 
 	st1232_pins: touchscreen {
-		renesas,groups = "intc_irq10";
-		renesas,function = "intc";
+		groups = "intc_irq10";
+		function = "intc";
 	};
 
 	backlight_pins: backlight {
-		renesas,groups = "tpu0_to2_1";
-		renesas,function = "tpu0";
+		groups = "tpu0_to2_1";
+		function = "tpu0";
 	};
 
 	mmc0_pins: mmc0 {
-		renesas,groups = "mmc0_data8_1", "mmc0_ctrl_1";
-		renesas,function = "mmc0";
+		groups = "mmc0_data8_1", "mmc0_ctrl_1";
+		function = "mmc0";
 	};
 
 	sdhi0_pins: sd0 {
-		renesas,groups = "sdhi0_data4", "sdhi0_ctrl", "sdhi0_wp";
-		renesas,function = "sdhi0";
+		groups = "sdhi0_data4", "sdhi0_ctrl", "sdhi0_wp";
+		function = "sdhi0";
 	};
 
 	fsia_pins: sounda {
-		renesas,groups = "fsia_sclk_in", "fsia_mclk_out",
-				 "fsia_data_in_1", "fsia_data_out_0";
-		renesas,function = "fsia";
+		groups = "fsia_sclk_in", "fsia_mclk_out",
+			 "fsia_data_in_1", "fsia_data_out_0";
+		function = "fsia";
 	};
 
 	lcd0_pins: lcd0 {
-		renesas,groups = "lcd0_data24_0", "lcd0_lclk_1", "lcd0_sync";
-		renesas,function = "lcd0";
+		groups = "lcd0_data24_0", "lcd0_lclk_1", "lcd0_sync";
+		function = "lcd0";
 
 		/* DBGMD/LCDC0/FSIA MUX */
 		gpio-hog;
-- 
2.1.4
