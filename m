From: elder@linaro.org (Alex Elder)
Date: Fri, 28 Mar 2014 08:47:29 -0500
Subject: [PATCH] ARM: spear: add __init to spear_clocksource_init()
Message-ID: <1396014449-31695-1-git-send-email-elder@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I get a build warning because spear_clocksource_init() calls
clocksource_mmio_init(), but it doesn't have an __init annotation.
Fix that.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 arch/arm/mach-spear/time.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-spear/time.c b/arch/arm/mach-spear/time.c
index d449673..2560d92 100644
--- a/arch/arm/mach-spear/time.c
+++ b/arch/arm/mach-spear/time.c
@@ -71,7 +71,7 @@ static void clockevent_set_mode(enum clock_event_mode mode,
 static int clockevent_next_event(unsigned long evt,
 				 struct clock_event_device *clk_event_dev);
 
-static void spear_clocksource_init(void)
+static void __init spear_clocksource_init(void)
 {
 	u32 tick_rate;
 	u16 val;
-- 
1.7.9.5
