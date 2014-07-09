From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed,  9 Jul 2014 17:06:51 +0200
Subject: [PATCHv3 23/34] ARM: at91: prepare common clk transition for sam9g45
In-Reply-To: <1404918422-7562-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1404918422-7562-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1404918422-7562-24-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enclose the sam9g45 old clk registration in "#if defined(CONFIG_OLD_CLK_AT91)
 #endif"

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/mach-at91/at91sam9g45.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-at91/at91sam9g45.c b/arch/arm/mach-at91/at91sam9g45.c
index 9d3d544ac19c..0d5d85797cd6 100644
--- a/arch/arm/mach-at91/at91sam9g45.c
+++ b/arch/arm/mach-at91/at91sam9g45.c
@@ -25,10 +25,11 @@
 #include "at91_aic.h"
 #include "soc.h"
 #include "generic.h"
-#include "clock.h"
 #include "sam9_smc.h"
 #include "pm.h"
 
+#if defined(CONFIG_OLD_CLK_AT91)
+#include "clock.h"
 /* --------------------------------------------------------------------
  *  Clocks
  * -------------------------------------------------------------------- */
@@ -331,6 +332,9 @@ static void __init at91sam9g45_register_clocks(void)
 	clk_register(&pck0);
 	clk_register(&pck1);
 }
+#else
+#define at91sam9g45_register_clocks NULL
+#endif
 
 /* --------------------------------------------------------------------
  *  GPIO
-- 
1.9.1
