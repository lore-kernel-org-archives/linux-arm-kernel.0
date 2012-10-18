From: linus.walleij@stericsson.com (Linus Walleij)
Date: Thu, 18 Oct 2012 19:18:52 +0200
Subject: [PATCH 3/8] ARM: plat-nomadik: use DIV_ROUND_CLOSEST()
Message-ID: <1350580732-8409-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

Use DIV_ROUND_CLOSEST() to calculate the cycle counter for the
periodic mode instead of relying on homebrew reimplementation.

Cc: Alessandro Rubini <rubini@unipv.it>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/plat-nomadik/timer.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/plat-nomadik/timer.c b/arch/arm/plat-nomadik/timer.c
index 0ae2b06..f911430 100644
--- a/arch/arm/plat-nomadik/timer.c
+++ b/arch/arm/plat-nomadik/timer.c
@@ -201,7 +201,8 @@ void __init nmdk_timer_init(void __iomem *base, int irq)
 		clk_prescale = MTU_CRn_PRESCALE_1;
 	}
 
-	nmdk_cycle = (rate + HZ/2) / HZ;
+	/* Cycles for periodic mode */
+	nmdk_cycle = DIV_ROUND_CLOSEST(rate, HZ);
 
 
 	/* Timer 0 is the free running clocksource */
-- 
1.7.11.3
