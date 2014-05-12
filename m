From: boris.brezillon@free-electrons.com (Boris BREZILLON)
Date: Mon, 12 May 2014 18:26:27 +0200
Subject: [PATCH v2 1/4] ARM: at91: prepare common clk transition for sam9n12
 SoC
In-Reply-To: <1399911990-5086-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1399911990-5086-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1399911990-5086-2-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch encloses sam9n12 old clk registration in
"#if defined(CONFIG_OLD_CLK_AT91) #endif" sections.

Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>
Tested-by: Bo Shen <voice.shen@atmel.com>
---
 arch/arm/mach-at91/at91sam9n12.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-at91/at91sam9n12.c b/arch/arm/mach-at91/at91sam9n12.c
index f2ea7b0..c8988fe 100644
--- a/arch/arm/mach-at91/at91sam9n12.c
+++ b/arch/arm/mach-at91/at91sam9n12.c
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
@@ -215,6 +216,9 @@ static void __init at91sam9n12_register_clocks(void)
 			 ARRAY_SIZE(periph_clocks_lookups));
 
 }
+#else
+#define at91sam9n12_register_clocks NULL
+#endif
 
 /* --------------------------------------------------------------------
  *  AT91SAM9N12 processor initialization
-- 
1.8.3.2
