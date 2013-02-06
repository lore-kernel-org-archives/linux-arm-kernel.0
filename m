From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  6 Feb 2013 11:03:21 +0900
Subject: [PATCH] ARM: shmobile: Register ARM architected timer
In-Reply-To: <1360116201-9362-1-git-send-email-horms+renesas@verge.net.au>
References: <1360116201-9362-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1360116201-9362-2-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Register ARM architected timer by default for all mach-shmobile
systems using late timer.

Signed-off-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/timer.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mach-shmobile/timer.c b/arch/arm/mach-shmobile/timer.c
index fdbe54a..3d16d4d 100644
--- a/arch/arm/mach-shmobile/timer.c
+++ b/arch/arm/mach-shmobile/timer.c
@@ -20,6 +20,7 @@
  */
 #include <linux/platform_device.h>
 #include <linux/delay.h>
+#include <asm/arch_timer.h>
 #include <asm/mach/time.h>
 #include <asm/smp_twd.h>
 
@@ -62,4 +63,6 @@ void __init shmobile_earlytimer_init(void)
 
 void __init shmobile_timer_init(void)
 {
+	arch_timer_of_register();
+	arch_timer_sched_clock_init();
 }
-- 
1.7.10.4
