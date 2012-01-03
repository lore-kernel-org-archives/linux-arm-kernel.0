From: jdzheng@broadcom.com (Jiandong Zheng)
Date: Tue, 3 Jan 2012 10:38:32 -0800
Subject: [PATCH] ARM/bcmring: fix build error with sp804 clockevents
 init
Message-ID: <4F034B28.10706@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Wrong API sp804_clockevents_register() was used and caused build error.
So change to use sp804_clockevents_init().

This patch was submitted a couple of times last year but unfortunately 
got lost.

Signed-off-by: Jiandong Zheng <jdzheng@broadcom.com>
---
  arch/arm/mach-bcmring/core.c |    2 +-
  1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-bcmring/core.c b/arch/arm/mach-bcmring/core.c
index 43eadbc..430da12 100644
--- a/arch/arm/mach-bcmring/core.c
+++ b/arch/arm/mach-bcmring/core.c
@@ -235,7 +235,7 @@ void __init bcmring_init_timer(void)
  	 */
  	bcmring_clocksource_init();

-	sp804_clockevents_register(TIMER0_VA_BASE, IRQ_TIMER0, "timer0");
+	sp804_clockevents_init(TIMER0_VA_BASE, IRQ_TIMER0, "timer0");
  }

  struct sys_timer bcmring_timer = {
-- 
1.7.5.4
