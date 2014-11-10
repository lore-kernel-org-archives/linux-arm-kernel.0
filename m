From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Mon, 10 Nov 2014 10:32:12 +0100
Subject: [PATCH v2] ARM: at91: remove useless init_time for DT-only SoCs
Message-ID: <1415611932-7765-1-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

init_time is only needed when booting non-DT boards, we can thus safely
remove init_time functions.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
Changes since v1:
- rebased on arm-soc branch

 arch/arm/mach-at91/at91sam9g45.c | 7 -------
 arch/arm/mach-at91/at91sam9rl.c  | 7 -------
 2 files changed, 14 deletions(-)

diff --git a/arch/arm/mach-at91/at91sam9g45.c b/arch/arm/mach-at91/at91sam9g45.c
index 042f7c6..2ad0db4 100644
--- a/arch/arm/mach-at91/at91sam9g45.c
+++ b/arch/arm/mach-at91/at91sam9g45.c
@@ -11,7 +11,6 @@
  */
 
 #include <asm/system_misc.h>
-#include <asm/irq.h>
 #include <mach/cpu.h>
 #include <mach/hardware.h>
 
@@ -35,13 +34,7 @@ static void __init at91sam9g45_initialize(void)
 	at91_sysirq_mask_rtt(AT91SAM9G45_BASE_RTT);
 }
 
-static void __init at91sam9g45_init_time(void)
-{
-	at91sam926x_pit_init(NR_IRQS_LEGACY + AT91_ID_SYS);
-}
-
 AT91_SOC_START(at91sam9g45)
 	.map_io = at91sam9g45_map_io,
 	.init = at91sam9g45_initialize,
-	.init_time = at91sam9g45_init_time,
 AT91_SOC_END
diff --git a/arch/arm/mach-at91/at91sam9rl.c b/arch/arm/mach-at91/at91sam9rl.c
index 97efb2e..bd7e568 100644
--- a/arch/arm/mach-at91/at91sam9rl.c
+++ b/arch/arm/mach-at91/at91sam9rl.c
@@ -10,7 +10,6 @@
  */
 
 #include <asm/system_misc.h>
-#include <asm/irq.h>
 #include <mach/cpu.h>
 #include <mach/at91_dbgu.h>
 #include <mach/hardware.h>
@@ -47,13 +46,7 @@ static void __init at91sam9rl_initialize(void)
 	at91_sysirq_mask_rtt(AT91SAM9RL_BASE_RTT);
 }
 
-static void __init at91sam9rl_init_time(void)
-{
-	at91sam926x_pit_init(NR_IRQS_LEGACY + AT91_ID_SYS);
-}
-
 AT91_SOC_START(at91sam9rl)
 	.map_io = at91sam9rl_map_io,
 	.init = at91sam9rl_initialize,
-	.init_time = at91sam9rl_init_time,
 AT91_SOC_END
-- 
1.9.1
