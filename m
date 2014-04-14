From: ghorbel@pivasoftware.com (Oussama Ghorbel)
Date: Mon, 14 Apr 2014 17:49:30 +0100
Subject: [PATCH] ARM: OMAP2+: free use_gptimer_clksrc variable after boot
Message-ID: <1397494170-3111-1-git-send-email-ghorbel@pivasoftware.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The variable use_gptimer_clksrc is only used by two __init functions,
So we can freely free it after boot.

Signed-off-by: Oussama Ghorbel <ghorbel@pivasoftware.com>
---
 arch/arm/mach-omap2/timer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index 74044aa..d4a6abd 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -361,7 +361,7 @@ static void __init omap2_gp_clockevent_init(int gptimer_id,
 
 /* Clocksource code */
 static struct omap_dm_timer clksrc;
-static bool use_gptimer_clksrc;
+static bool use_gptimer_clksrc __initdata;
 
 /*
  * clocksource
-- 
1.8.3.2
