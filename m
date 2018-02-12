From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 12 Feb 2018 16:44:20 +0100
Subject: [PATCH 3/5] soc: renesas: Use symbols for register offsets for R-Car
 M3-W power areas
In-Reply-To: <20180212154422.13900-1-horms+renesas@verge.net.au>
References: <20180212154422.13900-1-horms+renesas@verge.net.au>
Message-ID: <20180212154422.13900-4-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use symbols rather for register offsets for R-Car M3-W power areas
to improve readability.

This does not have any functional change.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/soc/renesas/r8a7796-sysc.c | 56 ++++++++++++++++++++++----------------
 1 file changed, 32 insertions(+), 24 deletions(-)

diff --git a/drivers/soc/renesas/r8a7796-sysc.c b/drivers/soc/renesas/r8a7796-sysc.c
index f700c842b9e1..beea0ee0d85e 100644
--- a/drivers/soc/renesas/r8a7796-sysc.c
+++ b/drivers/soc/renesas/r8a7796-sysc.c
@@ -16,30 +16,38 @@
 #include "rcar-sysc.h"
 
 static const struct rcar_sysc_area r8a7796_areas[] __initconst = {
-	{ "always-on",	    0, 0, R8A7796_PD_ALWAYS_ON,	-1, PD_ALWAYS_ON },
-	{ "ca57-scu",	0x1c0, 0, R8A7796_PD_CA57_SCU,	R8A7796_PD_ALWAYS_ON,
-	  PD_SCU },
-	{ "ca57-cpu0",	 0x80, 0, R8A7796_PD_CA57_CPU0,	R8A7796_PD_CA57_SCU,
-	  PD_CPU_NOCR },
-	{ "ca57-cpu1",	 0x80, 1, R8A7796_PD_CA57_CPU1,	R8A7796_PD_CA57_SCU,
-	  PD_CPU_NOCR },
-	{ "ca53-scu",	0x140, 0, R8A7796_PD_CA53_SCU,	R8A7796_PD_ALWAYS_ON,
-	  PD_SCU },
-	{ "ca53-cpu0",	0x200, 0, R8A7796_PD_CA53_CPU0,	R8A7796_PD_CA53_SCU,
-	  PD_CPU_NOCR },
-	{ "ca53-cpu1",	0x200, 1, R8A7796_PD_CA53_CPU1,	R8A7796_PD_CA53_SCU,
-	  PD_CPU_NOCR },
-	{ "ca53-cpu2",	0x200, 2, R8A7796_PD_CA53_CPU2,	R8A7796_PD_CA53_SCU,
-	  PD_CPU_NOCR },
-	{ "ca53-cpu3",	0x200, 3, R8A7796_PD_CA53_CPU3,	R8A7796_PD_CA53_SCU,
-	  PD_CPU_NOCR },
-	{ "cr7",	0x240, 0, R8A7796_PD_CR7,	R8A7796_PD_ALWAYS_ON },
-	{ "a3vc",	0x380, 0, R8A7796_PD_A3VC,	R8A7796_PD_ALWAYS_ON },
-	{ "a2vc0",	0x3c0, 0, R8A7796_PD_A2VC0,	R8A7796_PD_A3VC },
-	{ "a2vc1",	0x3c0, 1, R8A7796_PD_A2VC1,	R8A7796_PD_A3VC },
-	{ "3dg-a",	0x100, 0, R8A7796_PD_3DG_A,	R8A7796_PD_ALWAYS_ON },
-	{ "3dg-b",	0x100, 1, R8A7796_PD_3DG_B,	R8A7796_PD_3DG_A },
-	{ "a3ir",	0x180, 0, R8A7796_PD_A3IR,	R8A7796_PD_ALWAYS_ON },
+	{ "always-on",	RCAR_GEN3_SYSCSR, 0, R8A7796_PD_ALWAYS_ON,
+	  -1, PD_ALWAYS_ON },
+	{ "ca57-scu",	RCAR_GEN3_PWRSR5,  0, R8A7796_PD_CA57_SCU,
+	  R8A7796_PD_ALWAYS_ON, PD_SCU },
+	{ "ca57-cpu0",	RCAR_GEN3_PWRSR0,  0, R8A7796_PD_CA57_CPU0,
+	  R8A7796_PD_CA57_SCU, PD_CPU_NOCR },
+	{ "ca57-cpu1",	RCAR_GEN3_PWRSR0,  1, R8A7796_PD_CA57_CPU1,
+	  R8A7796_PD_CA57_SCU, PD_CPU_NOCR },
+	{ "ca53-scu",	RCAR_GEN3_PWRSR3,  0, R8A7796_PD_CA53_SCU,
+	  R8A7796_PD_ALWAYS_ON, PD_SCU },
+	{ "ca53-cpu0",	RCAR_GEN3_PWRSR6,  0, R8A7796_PD_CA53_CPU0,
+	  R8A7796_PD_CA53_SCU, PD_CPU_NOCR },
+	{ "ca53-cpu1",	RCAR_GEN3_PWRSR6,  1, R8A7796_PD_CA53_CPU1,
+	  R8A7796_PD_CA53_SCU, PD_CPU_NOCR },
+	{ "ca53-cpu2",	RCAR_GEN3_PWRSR6,  2, R8A7796_PD_CA53_CPU2,
+	  R8A7796_PD_CA53_SCU, PD_CPU_NOCR },
+	{ "ca53-cpu3",	RCAR_GEN3_PWRSR6,  3, R8A7796_PD_CA53_CPU3,
+	  R8A7796_PD_CA53_SCU, PD_CPU_NOCR },
+	{ "cr7",	RCAR_GEN3_PWRSR7,  0, R8A7796_PD_CR7,
+	  R8A7796_PD_ALWAYS_ON },
+	{ "a3vc",	RCAR_GEN3_PWRSR9,  0, R8A7796_PD_A3VC,
+	  R8A7796_PD_ALWAYS_ON },
+	{ "a2vc0",	RCAR_GEN3_PWRSR10, 0, R8A7796_PD_A2VC0,
+	  R8A7796_PD_A3VC },
+	{ "a2vc1",	RCAR_GEN3_PWRSR10, 1, R8A7796_PD_A2VC1,
+	  R8A7796_PD_A3VC },
+	{ "3dg-a",	RCAR_GEN3_PWRSR2,  0, R8A7796_PD_3DG_A,
+	  R8A7796_PD_ALWAYS_ON },
+	{ "3dg-b",	RCAR_GEN3_PWRSR2,  1, R8A7796_PD_3DG_B,
+	  R8A7796_PD_3DG_A },
+	{ "a3ir",	RCAR_GEN3_PWRSR4,  0, R8A7796_PD_A3IR,
+	  R8A7796_PD_ALWAYS_ON },
 };
 
 const struct rcar_sysc_info r8a7796_sysc_info __initconst = {
-- 
2.11.0
