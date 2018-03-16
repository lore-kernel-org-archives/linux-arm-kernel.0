From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 16 Mar 2018 15:53:27 +0100
Subject: [PATCH 05/14] soc: renesas: r8a77970-sysc: fix power area parents
In-Reply-To: <cover.1521211738.git.horms+renesas@verge.net.au>
References: <cover.1521211738.git.horms+renesas@verge.net.au>
Message-ID: <40d5c8e94751f4a4fa4e0e27e3805e201a4e79c0.1521211738.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

According to the figure 9.2(b) of the R-Car Series, 3rd Generation User?s
Manual: Hardware Rev. 0.80 the A2IRn and A2SCn power areas in R8A77970 have
the A3IR area as a parent, thus the SYSC driver has those parents wrong...

Fixes: bab9b2a74fe9 ("soc: renesas: rcar-sysc: add R8A77970 support")
Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/soc/renesas/r8a77970-sysc.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/soc/renesas/r8a77970-sysc.c b/drivers/soc/renesas/r8a77970-sysc.c
index 8c614164718e..caf894f193ed 100644
--- a/drivers/soc/renesas/r8a77970-sysc.c
+++ b/drivers/soc/renesas/r8a77970-sysc.c
@@ -25,12 +25,12 @@ static const struct rcar_sysc_area r8a77970_areas[] __initconst = {
 	  PD_CPU_NOCR },
 	{ "cr7",	0x240, 0, R8A77970_PD_CR7,	R8A77970_PD_ALWAYS_ON },
 	{ "a3ir",	0x180, 0, R8A77970_PD_A3IR,	R8A77970_PD_ALWAYS_ON },
-	{ "a2ir0",	0x400, 0, R8A77970_PD_A2IR0,	R8A77970_PD_ALWAYS_ON },
-	{ "a2ir1",	0x400, 1, R8A77970_PD_A2IR1,	R8A77970_PD_A2IR0 },
-	{ "a2ir2",	0x400, 2, R8A77970_PD_A2IR2,	R8A77970_PD_A2IR0 },
-	{ "a2ir3",	0x400, 3, R8A77970_PD_A2IR3,	R8A77970_PD_A2IR0 },
-	{ "a2sc0",	0x400, 4, R8A77970_PD_A2SC0,	R8A77970_PD_ALWAYS_ON },
-	{ "a2sc1",	0x400, 5, R8A77970_PD_A2SC1,	R8A77970_PD_A2SC0 },
+	{ "a2ir0",	0x400, 0, R8A77970_PD_A2IR0,	R8A77970_PD_A3IR },
+	{ "a2ir1",	0x400, 1, R8A77970_PD_A2IR1,	R8A77970_PD_A3IR },
+	{ "a2ir2",	0x400, 2, R8A77970_PD_A2IR2,	R8A77970_PD_A3IR },
+	{ "a2ir3",	0x400, 3, R8A77970_PD_A2IR3,	R8A77970_PD_A3IR },
+	{ "a2sc0",	0x400, 4, R8A77970_PD_A2SC0,	R8A77970_PD_A3IR },
+	{ "a2sc1",	0x400, 5, R8A77970_PD_A2SC1,	R8A77970_PD_A3IR },
 };
 
 const struct rcar_sysc_info r8a77970_sysc_info __initconst = {
-- 
2.11.0
