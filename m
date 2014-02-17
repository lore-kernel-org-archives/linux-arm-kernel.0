From: magnus.damm@gmail.com (Magnus Damm)
Date: Mon, 17 Feb 2014 16:21:28 +0900
Subject: [PATCH] ARM: shmobile: Remove Koelsch DT reference legacy clock bits
Message-ID: <20140217072128.27086.81905.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Koelsch DT reference is these days built for multiplatform
only which means that CCF comes with the package. Remove
unused legacy code ifdefs to clean up the code.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Written against renesas-devel-v3.14-rc3-20140217

 arch/arm/mach-shmobile/board-koelsch-reference.c |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

--- 0001/arch/arm/mach-shmobile/board-koelsch-reference.c
+++ work/arch/arm/mach-shmobile/board-koelsch-reference.c	2014-02-17 16:10:07.000000000 +0900
@@ -84,7 +84,6 @@ static void __init koelsch_add_du_device
 
 static void __init koelsch_add_standard_devices(void)
 {
-#ifdef CONFIG_COMMON_CLK
 	/*
 	 * This is a really crude hack to provide clkdev support to the CMT and
 	 * DU devices until they get moved to DT.
@@ -125,9 +124,7 @@ static void __init koelsch_add_standard_
 			clk_put(clk);
 		}
 	}
-#else
-	r8a7791_clock_init();
-#endif
+
 	r8a7791_add_dt_devices();
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 
