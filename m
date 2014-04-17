From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 17 Apr 2014 09:31:43 +0900
Subject: [PATCH 7/8] ARM: shmobile: r8a7778: remove old style audio clock
In-Reply-To: <cover.1397694178.git.horms+renesas@verge.net.au>
References: <cover.1397694178.git.horms+renesas@verge.net.au>
Message-ID: <a9d83bd6abc00e14e2db1660e2c7d889745bb3aa.1397694178.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Current sound driver moves to new style clock,
but is keeping compatiblity at this point.
Move to new style on r8a7778

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/clock-r8a7778.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-shmobile/clock-r8a7778.c b/arch/arm/mach-shmobile/clock-r8a7778.c
index 2009a9b..201fc48 100644
--- a/arch/arm/mach-shmobile/clock-r8a7778.c
+++ b/arch/arm/mach-shmobile/clock-r8a7778.c
@@ -175,10 +175,6 @@ static struct clk mstp_clks[MSTP_NR] = {
 
 static struct clk_lookup lookups[] = {
 	/* main */
-	CLKDEV_CON_ID("audio_clk_a",	&audio_clk_a),
-	CLKDEV_CON_ID("audio_clk_b",	&audio_clk_b),
-	CLKDEV_CON_ID("audio_clk_c",	&audio_clk_c),
-	CLKDEV_CON_ID("audio_clk_internal",	&s1_clk),
 	CLKDEV_CON_ID("shyway_clk",	&s_clk),
 	CLKDEV_CON_ID("peripheral_clk",	&p_clk),
 
@@ -234,15 +230,15 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_ICK_ID("ssi.6", "rcar_sound", &mstp_clks[MSTP309]),
 	CLKDEV_ICK_ID("ssi.7", "rcar_sound", &mstp_clks[MSTP308]),
 	CLKDEV_ICK_ID("ssi.8", "rcar_sound", &mstp_clks[MSTP307]),
-	CLKDEV_ICK_ID("scu.0", "rcar_sound", &mstp_clks[MSTP531]),
-	CLKDEV_ICK_ID("scu.1", "rcar_sound", &mstp_clks[MSTP530]),
-	CLKDEV_ICK_ID("scu.2", "rcar_sound", &mstp_clks[MSTP529]),
-	CLKDEV_ICK_ID("scu.3", "rcar_sound", &mstp_clks[MSTP528]),
-	CLKDEV_ICK_ID("scu.4", "rcar_sound", &mstp_clks[MSTP527]),
-	CLKDEV_ICK_ID("scu.5", "rcar_sound", &mstp_clks[MSTP526]),
-	CLKDEV_ICK_ID("scu.6", "rcar_sound", &mstp_clks[MSTP525]),
-	CLKDEV_ICK_ID("scu.7", "rcar_sound", &mstp_clks[MSTP524]),
-	CLKDEV_ICK_ID("scu.8", "rcar_sound", &mstp_clks[MSTP523]),
+	CLKDEV_ICK_ID("src.0", "rcar_sound", &mstp_clks[MSTP531]),
+	CLKDEV_ICK_ID("src.1", "rcar_sound", &mstp_clks[MSTP530]),
+	CLKDEV_ICK_ID("src.2", "rcar_sound", &mstp_clks[MSTP529]),
+	CLKDEV_ICK_ID("src.3", "rcar_sound", &mstp_clks[MSTP528]),
+	CLKDEV_ICK_ID("src.4", "rcar_sound", &mstp_clks[MSTP527]),
+	CLKDEV_ICK_ID("src.5", "rcar_sound", &mstp_clks[MSTP526]),
+	CLKDEV_ICK_ID("src.6", "rcar_sound", &mstp_clks[MSTP525]),
+	CLKDEV_ICK_ID("src.7", "rcar_sound", &mstp_clks[MSTP524]),
+	CLKDEV_ICK_ID("src.8", "rcar_sound", &mstp_clks[MSTP523]),
 };
 
 void __init r8a7778_clock_init(void)
-- 
1.8.4
