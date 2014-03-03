From: jjhiblot@traphandler.com (Jean-Jacques Hiblot)
Date: Mon,  3 Mar 2014 11:06:01 +0100
Subject: [PATCH v5 8/9] ARM: at91: prepare common clk transition for sam9261
 SoC
In-Reply-To: <1393841162-25339-1-git-send-email-jjhiblot@traphandler.com>
References: <1393841162-25339-1-git-send-email-jjhiblot@traphandler.com>
Message-ID: <1393841162-25339-9-git-send-email-jjhiblot@traphandler.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 This patch encloses sam9261 old clk registration in
"#if defined(CONFIG_OLD_CLK_AT91) #endif" sections.

Signed-off-by: Jean-Jacques Hiblot <jjhiblot@traphandler.com>
---
 arch/arm/mach-at91/at91sam9261.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-at91/at91sam9261.c b/arch/arm/mach-at91/at91sam9261.c
index 5c90581..3345a2b 100644
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
@@ -264,7 +266,9 @@ static void __init at91sam9261_register_clocks(void)
 	clk_register(&hck0);
 	clk_register(&hck1);
 }
-
+#else
+#define at91sam9261_register_clocks NULL
+#endif
 /* --------------------------------------------------------------------
  *  GPIO
  * -------------------------------------------------------------------- */
-- 
1.9.0
