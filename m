From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 28 Nov 2013 17:54:33 +0900
Subject: [PATCH 09/16] ARM: shmobile: Cosmetic update of Lager DT Reference
In-Reply-To: <cover.1385628709.git.horms+renesas@verge.net.au>
References: <cover.1385628709.git.horms+renesas@verge.net.au>
Message-ID: <20c6125fc9d98492e5ed1668d1ea72289c8ff94c.1385628709.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Clean up the Lager DT reference board code to make it match
Koelsch DT reference including using the rcar-gen2 header.

Signed-off-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-lager-reference.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-lager-reference.c b/arch/arm/mach-shmobile/board-lager-reference.c
index 1a1a4a8..7df9ea0 100644
--- a/arch/arm/mach-shmobile/board-lager-reference.c
+++ b/arch/arm/mach-shmobile/board-lager-reference.c
@@ -20,16 +20,15 @@
 
 #include <linux/init.h>
 #include <linux/of_platform.h>
+#include <mach/rcar-gen2.h>
 #include <mach/r8a7790.h>
 #include <asm/mach/arch.h>
 
 static void __init lager_add_standard_devices(void)
 {
-	/* clocks are setup late during boot in the case of DT */
 	r8a7790_clock_init();
-
 	r8a7790_add_dt_devices();
-        of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
+	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 }
 
 static const char *lager_boards_compat_dt[] __initdata = {
-- 
1.8.4
