From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue,  1 Jul 2014 16:12:13 +0200
Subject: [PATCH 04/33] ARM: at91: prepare common clk transition for rm9200
In-Reply-To: <1404223962-30471-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1404223962-30471-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1404223962-30471-5-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enclose the rm9200 old clk registration in "#if defined(CONFIG_OLD_CLK_AT91)
 #endif"

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/mach-at91/at91rm9200.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-at91/at91rm9200.c b/arch/arm/mach-at91/at91rm9200.c
index 787bb50a4dff..038702ee8bc6 100644
--- a/arch/arm/mach-at91/at91rm9200.c
+++ b/arch/arm/mach-at91/at91rm9200.c
@@ -26,10 +26,11 @@
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
@@ -277,6 +278,9 @@ static void __init at91rm9200_register_clocks(void)
 	clk_register(&pck2);
 	clk_register(&pck3);
 }
+#else
+#define at91rm9200_register_clocks NULL
+#endif
 
 /* --------------------------------------------------------------------
  *  GPIO
-- 
1.9.1
