From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun,  5 Aug 2012 22:37:55 +0200
Subject: [PATCH] ARM: integrator: use clk_prepare_enable() for timer
Message-ID: <1344199075-4111-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Integrator timer is using the clock framework to get the
timer frequency, but missed to prepare the clock before enabling.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-integrator/integrator_ap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-integrator/integrator_ap.c b/arch/arm/mach-integrator/integrator_ap.c
index 7b1055c..3b22675 100644
--- a/arch/arm/mach-integrator/integrator_ap.c
+++ b/arch/arm/mach-integrator/integrator_ap.c
@@ -456,7 +456,7 @@ static void __init ap_init_timer(void)
 
 	clk = clk_get_sys("ap_timer", NULL);
 	BUG_ON(IS_ERR(clk));
-	clk_enable(clk);
+	clk_prepare_enable(clk);
 	rate = clk_get_rate(clk);
 
 	writel(0, TIMER0_VA_BASE + TIMER_CTRL);
-- 
1.7.11.2
