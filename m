From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon,  4 Apr 2016 10:22:10 +0900
Subject: [PATCH 02/26] ARM: dts: ape6evm: use generic pinctrl properties
In-Reply-To: <cover.1459731908.git.horms+renesas@verge.net.au>
References: <cover.1459731908.git.horms+renesas@verge.net.au>
Message-ID: <a32f5cff122b41f01a4ed18a9007871344b651c3.1459731908.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since 16ccaf5bb5a5 ("pinctrl: sh-pfc: Accept standard function, pins and
groups properties") renesas pfc drivers accept generic "function", "pins"
and "groups" properties.

This patch updates the ape6evm device tree to use the generic properties.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a73a4-ape6evm.dts | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm/boot/dts/r8a73a4-ape6evm.dts b/arch/arm/boot/dts/r8a73a4-ape6evm.dts
index 590257095700..93ace33e3e36 100644
--- a/arch/arm/boot/dts/r8a73a4-ape6evm.dts
+++ b/arch/arm/boot/dts/r8a73a4-ape6evm.dts
@@ -189,28 +189,28 @@
 
 &pfc {
 	scifa0_pins: serial0 {
-		renesas,groups = "scifa0_data";
-		renesas,function = "scifa0";
+		groups = "scifa0_data";
+		function = "scifa0";
 	};
 
 	mmc0_pins: mmc {
-		renesas,groups = "mmc0_data8", "mmc0_ctrl";
-		renesas,function = "mmc0";
+		groups = "mmc0_data8", "mmc0_ctrl";
+		function = "mmc0";
 	};
 
 	sdhi0_pins: sd0 {
-		renesas,groups = "sdhi0_data4", "sdhi0_ctrl", "sdhi0_cd";
-		renesas,function = "sdhi0";
+		groups = "sdhi0_data4", "sdhi0_ctrl", "sdhi0_cd";
+		function = "sdhi0";
 	};
 
 	sdhi1_pins: sd1 {
-		renesas,groups = "sdhi1_data4", "sdhi1_ctrl";
-		renesas,function = "sdhi1";
+		groups = "sdhi1_data4", "sdhi1_ctrl";
+		function = "sdhi1";
 	};
 
 	keyboard_pins: keyboard {
-		renesas,pins = "PORT324", "PORT325", "PORT326", "PORT327",
-			       "PORT328", "PORT329";
+		pins = "PORT324", "PORT325", "PORT326", "PORT327", "PORT328",
+		       "PORT329";
 		bias-pull-up;
 	};
 };
-- 
2.1.4
