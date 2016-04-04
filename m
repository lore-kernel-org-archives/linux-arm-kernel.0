From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon,  4 Apr 2016 10:22:19 +0900
Subject: [PATCH 11/26] ARM: dts: kzm9g: use generic pinctrl properties
In-Reply-To: <cover.1459731908.git.horms+renesas@verge.net.au>
References: <cover.1459731908.git.horms+renesas@verge.net.au>
Message-ID: <ffff86d16ed25655643f75fdb83eb70f0a8496af.1459731908.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since 16ccaf5bb5a5 ("pinctrl: sh-pfc: Accept standard function, pins and
groups properties") renesas pfc drivers accept generic "function", "pins"
and "groups" properties.

This patch updates the kzm9g device tree to use the generic properties.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/sh73a0-kzm9g.dts | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/arch/arm/boot/dts/sh73a0-kzm9g.dts b/arch/arm/boot/dts/sh73a0-kzm9g.dts
index aa8bae3b8fcf..e40a2f23b6cd 100644
--- a/arch/arm/boot/dts/sh73a0-kzm9g.dts
+++ b/arch/arm/boot/dts/sh73a0-kzm9g.dts
@@ -329,41 +329,41 @@
 
 &pfc {
 	i2c3_pins: i2c3 {
-		renesas,groups = "i2c3_1";
-		renesas,function = "i2c3";
+		groups = "i2c3_1";
+		function = "i2c3";
 	};
 
 	mmcif_pins: mmc {
 		mux {
-			renesas,groups = "mmc0_data8_0", "mmc0_ctrl_0";
-			renesas,function = "mmc0";
+			groups = "mmc0_data8_0", "mmc0_ctrl_0";
+			function = "mmc0";
 		};
 		cfg {
-			renesas,groups = "mmc0_data8_0";
-			renesas,pins = "PORT279";
+			groups = "mmc0_data8_0";
+			pins = "PORT279";
 			bias-pull-up;
 		};
 	};
 
 	scifa4_pins: serial4 {
-		renesas,groups = "scifa4_data", "scifa4_ctrl";
-		renesas,function = "scifa4";
+		groups = "scifa4_data", "scifa4_ctrl";
+		function = "scifa4";
 	};
 
 	sdhi0_pins: sd0 {
-		renesas,groups = "sdhi0_data4", "sdhi0_ctrl", "sdhi0_cd", "sdhi0_wp";
-		renesas,function = "sdhi0";
+		groups = "sdhi0_data4", "sdhi0_ctrl", "sdhi0_cd", "sdhi0_wp";
+		function = "sdhi0";
 	};
 
 	sdhi2_pins: sd2 {
-		renesas,groups = "sdhi2_data4", "sdhi2_ctrl";
-		renesas,function = "sdhi2";
+		groups = "sdhi2_data4", "sdhi2_ctrl";
+		function = "sdhi2";
 	};
 
 	fsia_pins: sounda {
-		renesas,groups = "fsia_mclk_in", "fsia_sclk_in",
-				 "fsia_data_in", "fsia_data_out";
-		renesas,function = "fsia";
+		groups = "fsia_mclk_in", "fsia_sclk_in",
+			 "fsia_data_in", "fsia_data_out";
+		function = "fsia";
 	};
 };
 
-- 
2.1.4
