From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  7 Aug 2013 13:38:35 +0900
Subject: [GIT PULL 18/26] ARM: shmobile: Remove unused shmobile_init_time()
In-Reply-To: <cover.1375840527.git.horms+renesas@verge.net.au>
References: <cover.1375840527.git.horms+renesas@verge.net.au>
Message-ID: <13eb604665c94d4cd9d7e2aeceef974cf1f30701.1375840527.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Remove shmobile_timer_init() since it now is unused.

Signed-off-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/include/mach/common.h | 1 -
 arch/arm/mach-shmobile/timer.c               | 4 ----
 2 files changed, 5 deletions(-)

diff --git a/arch/arm/mach-shmobile/include/mach/common.h b/arch/arm/mach-shmobile/include/mach/common.h
index e818f02..18a76f9 100644
--- a/arch/arm/mach-shmobile/include/mach/common.h
+++ b/arch/arm/mach-shmobile/include/mach/common.h
@@ -2,7 +2,6 @@
 #define __ARCH_MACH_COMMON_H
 
 extern void shmobile_earlytimer_init(void);
-extern void shmobile_timer_init(void);
 extern void shmobile_setup_delay(unsigned int max_cpu_core_mhz,
 			 unsigned int mult, unsigned int div);
 struct twd_local_timer;
diff --git a/arch/arm/mach-shmobile/timer.c b/arch/arm/mach-shmobile/timer.c
index f321dbe..62d7052 100644
--- a/arch/arm/mach-shmobile/timer.c
+++ b/arch/arm/mach-shmobile/timer.c
@@ -59,7 +59,3 @@ void __init shmobile_earlytimer_init(void)
 	late_time_init = shmobile_late_time_init;
 }
 
-void __init shmobile_timer_init(void)
-{
-	clocksource_of_init();
-}
-- 
1.8.3.2
