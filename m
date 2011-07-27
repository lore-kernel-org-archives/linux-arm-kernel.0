From: kmpark@infradead.org (Kyungmin Park)
Date: Wed, 27 Jul 2011 13:24:06 +0900
Subject: [PATCH] ARM: exynos4: Add TWD base address
Message-ID: <20110727042406.GA14024@july>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kyungmin Park <kyungmin.park@samsung.com>

When use the s5p_timer for EXYNOS4210 EVT0, it's required.
Other s5p platform is guided from CONFIG_LOCAL_TIMER

Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
diff --git a/arch/arm/plat-s5p/s5p-time.c b/arch/arm/plat-s5p/s5p-time.c
index c833e7b..bdf5430 100644
--- a/arch/arm/plat-s5p/s5p-time.c
+++ b/arch/arm/plat-s5p/s5p-time.c
@@ -409,6 +409,9 @@ static void __init s5p_timer_resources(void)
 
 static void __init s5p_timer_init(void)
 {
+#ifdef CONFIG_LOCAL_TIMERS
+	twd_base = S5P_VA_TWD;
+#endif
 	s5p_timer_resources();
 	s5p_clockevent_init();
 	s5p_clocksource_init();
