From: jjhiblot@traphandler.com (Jean-Jacques Hiblot)
Date: Thu, 23 Jan 2014 16:57:08 +0100
Subject: [PATCH v3 04/15] ARM: at91: prepare common clk transition for sam9261
 SoC
In-Reply-To: <1390492639-7299-1-git-send-email-jjhiblot@traphandler.com>
References: <1390492639-7299-1-git-send-email-jjhiblot@traphandler.com>
Message-ID: <1390492639-7299-5-git-send-email-jjhiblot@traphandler.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 This patch encloses sam9261 old clk registration in
"#if defined(CONFIG_OLD_CLK_AT91) #endif" sections.

Signed-off-by: Jean-Jacques Hiblot <jjhiblot@traphandler.com>
---
 arch/arm/mach-at91/at91sam9261.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-at91/at91sam9261.c b/arch/arm/mach-at91/at91sam9261.c
index 6a2c869..2c0e940 100644
--- a/arch/arm/mach-at91/at91sam9261.c
+++ b/arch/arm/mach-at91/at91sam9261.c
@@ -25,10 +25,12 @@
 #include "at91_rstc.h"
 #include "soc.h"
 #include "generic.h"
-#include "clock.h"
 #include "sam9_smc.h"
 #include "pm.h"
 
+#if defined(CONFIG_OLD_CLK_AT91)
+#include "clock.h"
+
 /* --------------------------------------------------------------------
  *  Clocks
  * -------------------------------------------------------------------- */
@@ -262,7 +264,7 @@ static void __init at91sam9261_register_clocks(void)
 	clk_register(&hck0);
 	clk_register(&hck1);
 }
-
+#endif
 /* --------------------------------------------------------------------
  *  GPIO
  * -------------------------------------------------------------------- */
@@ -362,6 +364,8 @@ AT91_SOC_START(at91sam9261)
 	.extern_irq = (1 << AT91SAM9261_ID_IRQ0) | (1 << AT91SAM9261_ID_IRQ1)
 		    | (1 << AT91SAM9261_ID_IRQ2),
 	.ioremap_registers = at91sam9261_ioremap_registers,
+#if defined(CONFIG_OLD_CLK_AT91)
 	.register_clocks = at91sam9261_register_clocks,
+#endif
 	.init = at91sam9261_initialize,
 AT91_SOC_END
-- 
1.8.5.2
