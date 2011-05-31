From: mattias.wallin@stericsson.com (Mattias Wallin)
Date: Tue, 31 May 2011 10:31:19 +0200
Subject: [PATCH 3/3] mach-ux500: add support for clocksource DB8500 PRCMU
Message-ID: <1306830679-9591-1-git-send-email-mattias.wallin@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for the DB8500 PRCMU clocksource
to the mach-ux500 platform.

Signed-off-by: Mattias Wallin <mattias.wallin@stericsson.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-ux500/cpu.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-ux500/cpu.c b/arch/arm/mach-ux500/cpu.c
index 1da23bb8..7109921 100644
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
