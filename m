From: b.brezillon@overkiz.com (Boris BREZILLON)
Date: Thu,  8 Aug 2013 11:21:30 +0200
Subject: [PATCH 2/6] ARM: at91: prepare common clk transition for sama5d3 SoC
In-Reply-To: <1375951572-10829-1-git-send-email-b.brezillon@overkiz.com>
References: <1375951572-10829-1-git-send-email-b.brezillon@overkiz.com>
Message-ID: <1375953690-11207-1-git-send-email-b.brezillon@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch enclose sama5d3 old clk registration in
"#if defined(CONFIG_OLD_CLK_AT91) #endif" sections.

Signed-off-by: Boris BREZILLON <b.brezillon@overkiz.com>
---
 arch/arm/mach-at91/sama5d3.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-at91/sama5d3.c b/arch/arm/mach-at91/sama5d3.c
index 0003949..3426098 100644
--- a/arch/arm/mach-at91/sama5d3.c
+++ b/arch/arm/mach-at91/sama5d3.c
@@ -19,9 +19,10 @@
 
 #include "soc.h"
 #include "generic.h"
-#include "clock.h"
 #include "sam9_smc.h"
 
+#if defined(CONFIG_OLD_CLK_AT91)
+#include "clock.h"
 /* --------------------------------------------------------------------
  *  Clocks
  * -------------------------------------------------------------------- */
@@ -361,6 +362,7 @@ static void __init sama5d3_register_clocks(void)
 	clk_register(&pck1);
 	clk_register(&pck2);
 }
+#endif
 
 /* --------------------------------------------------------------------
  *  AT91SAM9x5 processor initialization
@@ -373,5 +375,7 @@ static void __init sama5d3_map_io(void)
 
 AT91_SOC_START(sama5d3)
 	.map_io = sama5d3_map_io,
+#if defined(CONFIG_OLD_CLK_AT91)
 	.register_clocks = sama5d3_register_clocks,
+#endif
 AT91_SOC_END
-- 
1.7.9.5
