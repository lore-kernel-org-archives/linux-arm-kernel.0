From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 21 Feb 2014 15:12:27 +0900
Subject: [PATCH 15/16] ARM: shmobile: Remove Koelsch DT reference legacy clock
 bits
In-Reply-To: <cover.1392960310.git.horms+renesas@verge.net.au>
References: <cover.1392960310.git.horms+renesas@verge.net.au>
Message-ID: <34b6a241de1d965b1c047a97fad602687218a866.1392960310.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Koelsch DT reference is these days built for multiplatform
only which means that CCF comes with the package. Remove
unused legacy code ifdefs to clean up the code.

Signed-off-by: Magnus Damm <damm@opensource.se>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-koelsch-reference.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-koelsch-reference.c b/arch/arm/mach-shmobile/board-koelsch-reference.c
index 267fe83..a3fd302 100644
--- a/arch/arm/mach-shmobile/board-koelsch-reference.c
+++ b/arch/arm/mach-shmobile/board-koelsch-reference.c
@@ -84,7 +84,6 @@ static void __init koelsch_add_du_device(void)
 
 static void __init koelsch_add_standard_devices(void)
 {
-#ifdef CONFIG_COMMON_CLK
 	/*
 	 * This is a really crude hack to provide clkdev support to the CMT and
 	 * DU devices until they get moved to DT.
@@ -125,9 +124,7 @@ static void __init koelsch_add_standard_devices(void)
 			clk_put(clk);
 		}
 	}
-#else
-	r8a7791_clock_init();
-#endif
+
 	r8a7791_add_dt_devices();
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 
-- 
1.8.5.2
