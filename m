From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 21 Feb 2014 15:12:28 +0900
Subject: [PATCH 16/16] ARM: shmobile: Remove Lager DT reference legacy clock
 bits
In-Reply-To: <cover.1392960310.git.horms+renesas@verge.net.au>
References: <cover.1392960310.git.horms+renesas@verge.net.au>
Message-ID: <6197c08ab81cf1430cbe7346fd6ca0b5a18580bf.1392960310.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Lager DT reference is these days built for multiplatform
only which means that CCF comes with the package. Remove
unused legacy code ifdefs to clean up the code.

Signed-off-by: Magnus Damm <damm@opensource.se>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-lager-reference.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-lager-reference.c b/arch/arm/mach-shmobile/board-lager-reference.c
index 6ba8b3b..440aac3 100644
--- a/arch/arm/mach-shmobile/board-lager-reference.c
+++ b/arch/arm/mach-shmobile/board-lager-reference.c
@@ -88,7 +88,6 @@ static void __init lager_add_du_device(void)
 
 static void __init lager_add_standard_devices(void)
 {
-#ifdef CONFIG_COMMON_CLK
 	/*
 	 * This is a really crude hack to provide clkdev support to platform
 	 * devices until they get moved to DT.
@@ -126,9 +125,6 @@ static void __init lager_add_standard_devices(void)
 			clk_put(clk);
 		}
 	}
-#else
-	r8a7790_clock_init();
-#endif
 
 	r8a7790_add_dt_devices();
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
-- 
1.8.5.2
