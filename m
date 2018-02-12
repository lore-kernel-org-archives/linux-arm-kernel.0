From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 12 Feb 2018 16:44:21 +0100
Subject: [PATCH 4/5] soc: renesas: Use symbols for register offsets for R-Car
 V3M power areas
In-Reply-To: <20180212154422.13900-1-horms+renesas@verge.net.au>
References: <20180212154422.13900-1-horms+renesas@verge.net.au>
Message-ID: <20180212154422.13900-5-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use symbols rather for register offsets for R-Car V3M power areas
to improve readability.

Also line-wrap at 80 columns for consistency with R-Car H3 and M3-W
implementations.

This does not have any functional change.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/soc/renesas/r8a77970-sysc.c | 39 +++++++++++++++++++++++--------------
 1 file changed, 24 insertions(+), 15 deletions(-)

diff --git a/drivers/soc/renesas/r8a77970-sysc.c b/drivers/soc/renesas/r8a77970-sysc.c
index 8c614164718e..a21066bd5ba7 100644
--- a/drivers/soc/renesas/r8a77970-sysc.c
+++ b/drivers/soc/renesas/r8a77970-sysc.c
@@ -16,21 +16,30 @@
 #include "rcar-sysc.h"
 
 static const struct rcar_sysc_area r8a77970_areas[] __initconst = {
-	{ "always-on",	    0, 0, R8A77970_PD_ALWAYS_ON, -1, PD_ALWAYS_ON },
-	{ "ca53-scu",	0x140, 0, R8A77970_PD_CA53_SCU,	R8A77970_PD_ALWAYS_ON,
-	  PD_SCU },
-	{ "ca53-cpu0",	0x200, 0, R8A77970_PD_CA53_CPU0, R8A77970_PD_CA53_SCU,
-	  PD_CPU_NOCR },
-	{ "ca53-cpu1",	0x200, 1, R8A77970_PD_CA53_CPU1, R8A77970_PD_CA53_SCU,
-	  PD_CPU_NOCR },
-	{ "cr7",	0x240, 0, R8A77970_PD_CR7,	R8A77970_PD_ALWAYS_ON },
-	{ "a3ir",	0x180, 0, R8A77970_PD_A3IR,	R8A77970_PD_ALWAYS_ON },
-	{ "a2ir0",	0x400, 0, R8A77970_PD_A2IR0,	R8A77970_PD_ALWAYS_ON },
-	{ "a2ir1",	0x400, 1, R8A77970_PD_A2IR1,	R8A77970_PD_A2IR0 },
-	{ "a2ir2",	0x400, 2, R8A77970_PD_A2IR2,	R8A77970_PD_A2IR0 },
-	{ "a2ir3",	0x400, 3, R8A77970_PD_A2IR3,	R8A77970_PD_A2IR0 },
-	{ "a2sc0",	0x400, 4, R8A77970_PD_A2SC0,	R8A77970_PD_ALWAYS_ON },
-	{ "a2sc1",	0x400, 5, R8A77970_PD_A2SC1,	R8A77970_PD_A2SC0 },
+	{ "always-on",	RCAR_GEN3_SYSCSR, 0, R8A77970_PD_ALWAYS_ON,
+	  -1, PD_ALWAYS_ON },
+	{ "ca53-scu",	RCAR_GEN3_PWRSR3, 0, R8A77970_PD_CA53_SCU,
+	  R8A77970_PD_ALWAYS_ON, PD_SCU },
+	{ "ca53-cpu0",	RCAR_GEN3_PWRSR6, 0, R8A77970_PD_CA53_CPU0,
+	  R8A77970_PD_CA53_SCU, PD_CPU_NOCR },
+	{ "ca53-cpu1",	RCAR_GEN3_PWRSR6, 1, R8A77970_PD_CA53_CPU1,
+	  R8A77970_PD_CA53_SCU, PD_CPU_NOCR },
+	{ "cr7",	RCAR_GEN3_PWRSR7, 0, R8A77970_PD_CR7,
+	  R8A77970_PD_ALWAYS_ON },
+	{ "a3ir",	RCAR_GEN3_PWRSR4, 0, R8A77970_PD_A3IR,
+	  R8A77970_PD_ALWAYS_ON },
+	{ "a2ir0",	RCAR_GEN3_PWRSR11, 0, R8A77970_PD_A2IR0,
+	  R8A77970_PD_ALWAYS_ON },
+	{ "a2ir1",	RCAR_GEN3_PWRSR11, 1, R8A77970_PD_A2IR1,
+	  R8A77970_PD_A2IR0 },
+	{ "a2ir2",	RCAR_GEN3_PWRSR11, 2, R8A77970_PD_A2IR2,
+	  R8A77970_PD_A2IR0 },
+	{ "a2ir3",	RCAR_GEN3_PWRSR11, 3, R8A77970_PD_A2IR3,
+	  R8A77970_PD_A2IR0 },
+	{ "a2sc0",	RCAR_GEN3_PWRSR11, 4, R8A77970_PD_A2SC0,
+	  R8A77970_PD_ALWAYS_ON },
+	{ "a2sc1",	RCAR_GEN3_PWRSR11, 5, R8A77970_PD_A2SC1,
+	  R8A77970_PD_A2SC0 },
 };
 
 const struct rcar_sysc_info r8a77970_sysc_info __initconst = {
-- 
2.11.0
