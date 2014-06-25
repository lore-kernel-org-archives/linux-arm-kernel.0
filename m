From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 25 Jun 2014 16:35:23 +0900
Subject: [PATCH 11/14] ARM: shmobile: rcar-gen2: Remove useless copied section
 for LongTrail
In-Reply-To: <cover.1403681315.git.horms+renesas@verge.net.au>
References: <cover.1403681315.git.horms+renesas@verge.net.au>
Message-ID: <ea2a0d581a3e742c2fb2bc520c8c8887fe1dafa6.1403681315.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Open Firmware in the CHRP LongTrail does not support plugging in ARM CPUs
in its PPC 603e/604e-compatible CPU socket ;-)

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Magnus Damm <damm+renesas@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/setup-rcar-gen2.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/arch/arm/mach-shmobile/setup-rcar-gen2.c b/arch/arm/mach-shmobile/setup-rcar-gen2.c
index 51d5723..73fb2a6 100644
--- a/arch/arm/mach-shmobile/setup-rcar-gen2.c
+++ b/arch/arm/mach-shmobile/setup-rcar-gen2.c
@@ -129,14 +129,7 @@ static int __init rcar_gen2_scan_mem(unsigned long node, const char *uname,
 	u64 lpae_start = 1ULL << 32;
 
 	/* We are scanning "memory" nodes only */
-	if (type == NULL) {
-		/*
-		 * The longtrail doesn't have a device_type on the
-		 * /memory node, so look for the node called /memory at 0.
-		 */
-		if (depth != 1 || strcmp(uname, "memory@0") != 0)
-			return 0;
-	} else if (strcmp(type, "memory") != 0)
+	if (type == NULL || strcmp(type, "memory"))
 		return 0;
 
 	reg = of_get_flat_dt_prop(node, "linux,usable-memory", &l);
-- 
2.0.0.rc2
