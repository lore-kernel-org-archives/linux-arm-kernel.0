From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 12 Feb 2018 16:44:22 +0100
Subject: [PATCH 5/5] soc: renesas: Use symbols for register offsets for R-Car
 D3 power areas
In-Reply-To: <20180212154422.13900-1-horms+renesas@verge.net.au>
References: <20180212154422.13900-1-horms+renesas@verge.net.au>
Message-ID: <20180212154422.13900-6-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use symbols rather for register offsets for R-Car D3 power areas
to improve readability.

Also line-wrap at 80 columns for consistency with R-Car H3 and M3-W
implementations.

This does not have any functional change.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/soc/renesas/r8a77995-sysc.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/soc/renesas/r8a77995-sysc.c b/drivers/soc/renesas/r8a77995-sysc.c
index f718429cab02..45355a5cca34 100644
--- a/drivers/soc/renesas/r8a77995-sysc.c
+++ b/drivers/soc/renesas/r8a77995-sysc.c
@@ -17,11 +17,12 @@
 #include "rcar-sysc.h"
 
 static struct rcar_sysc_area r8a77995_areas[] __initdata = {
-	{ "always-on",     0, 0, R8A77995_PD_ALWAYS_ON, -1, PD_ALWAYS_ON },
-	{ "ca53-scu",  0x140, 0, R8A77995_PD_CA53_SCU,  R8A77995_PD_ALWAYS_ON,
-	  PD_SCU },
-	{ "ca53-cpu0", 0x200, 0, R8A77995_PD_CA53_CPU0, R8A77995_PD_CA53_SCU,
-	  PD_CPU_NOCR },
+	{ "always-on", RCAR_GEN3_SYSCSR, 0, R8A77995_PD_ALWAYS_ON,
+	  -1, PD_ALWAYS_ON },
+	{ "ca53-scu",  RCAR_GEN3_PWRSR3, 0, R8A77995_PD_CA53_SCU,
+	  R8A77995_PD_ALWAYS_ON, PD_SCU },
+	{ "ca53-cpu0", RCAR_GEN3_PWRSR6, 0, R8A77995_PD_CA53_CPU0,
+	  R8A77995_PD_CA53_SCU, PD_CPU_NOCR },
 };
 
 
-- 
2.11.0
