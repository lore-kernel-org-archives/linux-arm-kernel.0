From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 17 Apr 2014 09:31:44 +0900
Subject: [PATCH 8/8] ARM: shmobile: r8a7790: remove old style audio clock
In-Reply-To: <cover.1397694178.git.horms+renesas@verge.net.au>
References: <cover.1397694178.git.horms+renesas@verge.net.au>
Message-ID: <932616eed0308cbebbb20a079e4bed3674bf1117.1397694178.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Current sound driver moves to new style clock,
but is keeping compatiblity at this point.
Move to new style on r8a7790

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/clock-r8a7790.c | 24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-shmobile/clock-r8a7790.c b/arch/arm/mach-shmobile/clock-r8a7790.c
index 3310139..a936ae7 100644
--- a/arch/arm/mach-shmobile/clock-r8a7790.c
+++ b/arch/arm/mach-shmobile/clock-r8a7790.c
@@ -294,10 +294,6 @@ static struct clk mstp_clks[MSTP_NR] = {
 static struct clk_lookup lookups[] = {
 
 	/* main clocks */
-	CLKDEV_CON_ID("audio_clk_a",	&audio_clk_a),
-	CLKDEV_CON_ID("audio_clk_b",	&audio_clk_b),
-	CLKDEV_CON_ID("audio_clk_c",	&audio_clk_c),
-	CLKDEV_CON_ID("audio_clk_internal",	&m2_clk),
 	CLKDEV_CON_ID("extal",		&extal_clk),
 	CLKDEV_CON_ID("extal_div2",	&extal_div2_clk),
 	CLKDEV_CON_ID("main",		&main_clk),
@@ -381,16 +377,16 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_ICK_ID("clk_b", "rcar_sound", &audio_clk_b),
 	CLKDEV_ICK_ID("clk_c", "rcar_sound", &audio_clk_c),
 	CLKDEV_ICK_ID("clk_i", "rcar_sound", &m2_clk),
-	CLKDEV_ICK_ID("scu.0", "rcar_sound", &mstp_clks[MSTP1031]),
-	CLKDEV_ICK_ID("scu.1", "rcar_sound", &mstp_clks[MSTP1030]),
-	CLKDEV_ICK_ID("scu.2", "rcar_sound", &mstp_clks[MSTP1029]),
-	CLKDEV_ICK_ID("scu.3", "rcar_sound", &mstp_clks[MSTP1028]),
-	CLKDEV_ICK_ID("scu.4", "rcar_sound", &mstp_clks[MSTP1027]),
-	CLKDEV_ICK_ID("scu.5", "rcar_sound", &mstp_clks[MSTP1026]),
-	CLKDEV_ICK_ID("scu.6", "rcar_sound", &mstp_clks[MSTP1025]),
-	CLKDEV_ICK_ID("scu.7", "rcar_sound", &mstp_clks[MSTP1024]),
-	CLKDEV_ICK_ID("scu.8", "rcar_sound", &mstp_clks[MSTP1023]),
-	CLKDEV_ICK_ID("scu.9", "rcar_sound", &mstp_clks[MSTP1022]),
+	CLKDEV_ICK_ID("src.0", "rcar_sound", &mstp_clks[MSTP1031]),
+	CLKDEV_ICK_ID("src.1", "rcar_sound", &mstp_clks[MSTP1030]),
+	CLKDEV_ICK_ID("src.2", "rcar_sound", &mstp_clks[MSTP1029]),
+	CLKDEV_ICK_ID("src.3", "rcar_sound", &mstp_clks[MSTP1028]),
+	CLKDEV_ICK_ID("src.4", "rcar_sound", &mstp_clks[MSTP1027]),
+	CLKDEV_ICK_ID("src.5", "rcar_sound", &mstp_clks[MSTP1026]),
+	CLKDEV_ICK_ID("src.6", "rcar_sound", &mstp_clks[MSTP1025]),
+	CLKDEV_ICK_ID("src.7", "rcar_sound", &mstp_clks[MSTP1024]),
+	CLKDEV_ICK_ID("src.8", "rcar_sound", &mstp_clks[MSTP1023]),
+	CLKDEV_ICK_ID("src.9", "rcar_sound", &mstp_clks[MSTP1022]),
 	CLKDEV_ICK_ID("ssi.0", "rcar_sound", &mstp_clks[MSTP1015]),
 	CLKDEV_ICK_ID("ssi.1", "rcar_sound", &mstp_clks[MSTP1014]),
 	CLKDEV_ICK_ID("ssi.2", "rcar_sound", &mstp_clks[MSTP1013]),
-- 
1.8.4
