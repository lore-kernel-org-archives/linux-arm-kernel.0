From: maxin.john@gmail.com (Maxin B. John)
Date: Tue, 23 Aug 2011 14:18:24 +0300
Subject: [PATCH 1/2] arm: mach-bcmring: fix build error in core.c
Message-ID: <20110823111824.GA2806@maxin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CC      arch/arm/mach-bcmring/core.o
arch/arm/mach-bcmring/core.c: In function 'bcmring_init_timer':
arch/arm/mach-bcmring/core.c:238: error: implicit declaration of
function 'sp804_clockevents_register'
make[1]: *** [arch/arm/mach-bcmring/core.o] Error 1
make: *** [arch/arm/mach-bcmring] Error 2

Please let me know your comments on this fix:

Signed-off-by: Maxin B. John <maxin.john@gmail.com>
---
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
