From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 26 Feb 2014 16:33:36 +0900
Subject: [PATCH v3 20/20] ARM: shmobile: marzen-reference: Remove legacy clock
 support
In-Reply-To: <1393400016-23433-1-git-send-email-horms+renesas@verge.net.au>
References: <1393400016-23433-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1393400016-23433-21-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marzen DT reference is these now only built for multiplatform
which means that CCF comes with the package. Remove unused legacy
code ifdefs to clean up the code.

Based on similar work for the Koelsch board by Magnus Damm.

Cc: Magnus Damm <damm@opensource.se>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-marzen-reference.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-marzen-reference.c b/arch/arm/mach-shmobile/board-marzen-reference.c
index 20cf1dc..0b2e7c4 100644
--- a/arch/arm/mach-shmobile/board-marzen-reference.c
+++ b/arch/arm/mach-shmobile/board-marzen-reference.c
@@ -32,15 +32,12 @@
 
 static void __init marzen_init_timer(void)
 {
-#ifdef CONFIG_COMMON_CLK
 	r8a7779_clocks_init(r8a7779_read_mode_pins());
-#endif
 	clocksource_of_init();
 }
 
 static void __init marzen_init(void)
 {
-#ifdef CONFIG_COMMON_CLK
 	static const struct clk_name {
 		const char *clk;
 		const char *con_id;
@@ -67,9 +64,6 @@ static void __init marzen_init(void)
 			clk_put(clk);
 		}
 	}
-#else
-	r8a7779_clock_init();
-#endif
 	r8a7779_add_standard_devices_dt();
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 	r8a7779_init_irq_extpin_dt(1); /* IRQ1 as individual interrupt */
-- 
1.8.5.2
