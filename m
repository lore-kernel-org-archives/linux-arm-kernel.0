From: mattias.wallin@stericsson.com (Mattias Wallin)
Date: Thu, 2 Jun 2011 11:35:49 +0200
Subject: [PATCHv2 3/3] mach-ux500: Initialize the DB8500 PRCMU timer
Message-ID: <1307007349-1159-1-git-send-email-mattias.wallin@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The clocksource and sched_clk registration needs to be started
early so it is called from the platform sys_timer init.

Signed-off-by: Mattias Wallin <mattias.wallin@stericsson.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-ux500/cpu.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-ux500/cpu.c b/arch/arm/mach-ux500/cpu.c
index 1da23bb..7109921 100644
--- a/arch/arm/mach-ux500/cpu.c
+++ b/arch/arm/mach-ux500/cpu.c
@@ -10,6 +10,7 @@
 #include <linux/clk.h>
 #include <linux/mfd/db8500-prcmu.h>
 #include <linux/mfd/db5500-prcmu.h>
+#include <linux/clksrc-db8500-prcmu.h>
 
 #include <asm/cacheflush.h>
 #include <asm/hardware/cache-l2x0.h>
@@ -141,6 +142,7 @@ static void __init ux500_timer_init(void)
 		ux500_unknown_soc();
 
 	nmdk_timer_init();
+	clksrc_db8500_prcmu_init();
 }
 
 struct sys_timer ux500_timer = {
-- 
1.7.4.3
