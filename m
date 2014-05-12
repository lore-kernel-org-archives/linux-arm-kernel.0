From: boris.brezillon@free-electrons.com (Boris BREZILLON)
Date: Mon, 12 May 2014 18:23:34 +0200
Subject: [PATCH v2 1/4] ARM: at91: prepare common clk transition for sam9x5
 SoCs
In-Reply-To: <1399911817-4980-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1399911817-4980-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1399911817-4980-2-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch encloses sam9x5 old clk registration in
"#if defined(CONFIG_OLD_CLK_AT91) #endif" sections.

Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>
Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/mach-at91/at91sam9x5.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-at91/at91sam9x5.c b/arch/arm/mach-at91/at91sam9x5.c
index 9ad781d..028268f 100644
--- a/arch/arm/mach-at91/at91sam9x5.c
+++ b/arch/arm/mach-at91/at91sam9x5.c
@@ -19,9 +19,10 @@
 #include "board.h"
 #include "soc.h"
 #include "generic.h"
-#include "clock.h"
 #include "sam9_smc.h"
 
+#if defined(CONFIG_OLD_CLK_AT91)
+#include "clock.h"
 /* --------------------------------------------------------------------
  *  Clocks
  * -------------------------------------------------------------------- */
@@ -313,6 +314,9 @@ static void __init at91sam9x5_register_clocks(void)
 	clk_register(&pck0);
 	clk_register(&pck1);
 }
+#else
+#define at91sam9x5_register_clocks	NULL
+#endif
 
 /* --------------------------------------------------------------------
  *  AT91SAM9x5 processor initialization
-- 
1.8.3.2
