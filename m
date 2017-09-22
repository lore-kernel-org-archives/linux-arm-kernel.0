From: allen.lkml@gmail.com (Allen Pais)
Date: Fri, 22 Sep 2017 17:09:02 +0530
Subject: [PATCH] arm: mach-iop32x: use setup_timer() helper.
Message-ID: <1506080342-5914-1-git-send-email-allen.lkml@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

   Use setup_timer function instead of initializing timer with the
   function and data fields.

Signed-off-by: Allen Pais <allen.lkml@gmail.com>
---
 arch/arm/mach-iop32x/n2100.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/mach-iop32x/n2100.c b/arch/arm/mach-iop32x/n2100.c
index c1cd80e..4a64a11 100644
--- a/arch/arm/mach-iop32x/n2100.c
+++ b/arch/arm/mach-iop32x/n2100.c
@@ -336,8 +336,7 @@ static int __init n2100_request_gpios(void)
 			pr_err("could not set power GPIO as input\n");
 	}
 	/* Set up power button poll timer */
-	init_timer(&power_button_poll_timer);
-	power_button_poll_timer.function = power_button_poll;
+	setup_timer(&power_button_poll_timer, power_button_poll, 0UL);
 	power_button_poll_timer.expires = jiffies + (HZ / 10);
 	add_timer(&power_button_poll_timer);
 	return 0;
-- 
2.7.4
