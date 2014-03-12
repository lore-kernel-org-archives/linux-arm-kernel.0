From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed, 12 Mar 2014 10:43:42 +0100
Subject: [PATCHv5 6/9] ARM: at91: prepare common clk transition for sam9rl SoCs
In-Reply-To: <1394617425-641-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1394617425-641-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1394617425-641-7-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch encloses sam9rl old clk registration in
 #if defined(CONFIG_OLD_CLK_AT91)/#endif sections.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/mach-at91/at91sam9rl.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-at91/at91sam9rl.c b/arch/arm/mach-at91/at91sam9rl.c
index 4b6eb2df601a..a11983fbaabf 100644
--- a/arch/arm/mach-at91/at91sam9rl.c
+++ b/arch/arm/mach-at91/at91sam9rl.c
@@ -25,13 +25,14 @@
 #include "at91_rstc.h"
 #include "soc.h"
 #include "generic.h"
-#include "clock.h"
 #include "sam9_smc.h"
 #include "pm.h"
 
 /* --------------------------------------------------------------------
  *  Clocks
  * -------------------------------------------------------------------- */
+#if defined(CONFIG_OLD_CLK_AT91)
+#include "clock.h"
 
 /*
  * The peripheral clocks.
@@ -255,6 +256,7 @@ static void __init at91sam9rl_register_clocks(void)
 	clk_register(&pck0);
 	clk_register(&pck1);
 }
+#endif
 
 /* --------------------------------------------------------------------
  *  GPIO
@@ -367,6 +369,8 @@ AT91_SOC_START(at91sam9rl)
 	.default_irq_priority = at91sam9rl_default_irq_priority,
 	.extern_irq = (1 << AT91SAM9RL_ID_IRQ0),
 	.ioremap_registers = at91sam9rl_ioremap_registers,
+#if defined(CONFIG_OLD_CLK_AT91)
 	.register_clocks = at91sam9rl_register_clocks,
+#endif
 	.init = at91sam9rl_initialize,
 AT91_SOC_END
-- 
1.8.3.2
