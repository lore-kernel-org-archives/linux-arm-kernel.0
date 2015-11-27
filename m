From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 27 Nov 2015 10:55:45 +0900
Subject: [PATCH 02/15] ARM: shmobile: bockw dts: define sdhi0 pins with
 pull-ups
In-Reply-To: <cover.1448586938.git.horms+renesas@verge.net.au>
References: <cover.1448586938.git.horms+renesas@verge.net.au>
Message-ID: <781f278a16fbd74ffa2acf3f14134953631f076d.1448586938.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>

Ensures that the pull-ups for pins SD0_CD and SD0_WP are enabled.

This is one of two features from the DT reference platform that are
still missing in MP.

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7778-bockw.dts | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7778-bockw.dts b/arch/arm/boot/dts/r8a7778-bockw.dts
index 90543b12d7e2..8a5407678717 100644
--- a/arch/arm/boot/dts/r8a7778-bockw.dts
+++ b/arch/arm/boot/dts/r8a7778-bockw.dts
@@ -137,10 +137,14 @@
 	};
 
 	sdhi0_pins: sd0 {
-		renesas,groups = "sdhi0_data4", "sdhi0_ctrl",
-				  "sdhi0_cd";
+		renesas,groups = "sdhi0_data4", "sdhi0_ctrl";
 		renesas,function = "sdhi0";
 	};
+	sdhi0_pup_pins: sd0_pup {
+		renesas,groups = "sdhi0_cd", "sdhi0_wp";
+		renesas,function = "sdhi0";
+		bias-pull-up;
+	};
 
 	hspi0_pins: hspi0 {
 		renesas,groups = "hspi0_a";
@@ -169,7 +173,7 @@
 };
 
 &sdhi0 {
-	pinctrl-0 = <&sdhi0_pins>;
+	pinctrl-0 = <&sdhi0_pins>, <&sdhi0_pup_pins>;
 	pinctrl-names = "default";
 
 	vmmc-supply = <&fixedregulator3v3>;
-- 
2.1.4
