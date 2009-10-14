From: tony@atomide.com (Tony Lindgren)
Date: Tue, 13 Oct 2009 17:14:41 -0700
Subject: [PATCH 5/6] omap: Initialization of SDRC params on Zoom2
In-Reply-To: <20091014001233.6116.84749.stgit@localhost>
References: <20091014001233.6116.84749.stgit@localhost>
Message-ID: <20091014001441.6116.80963.stgit@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Teerth Reddy <teerth@ti.com>

This patch initializes the correct SDRC settings required
for DVFS on Zoom2.

Signed-off-by: Teerth Reddy <teerth@ti.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-zoom2.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-zoom2.c b/arch/arm/mach-omap2/board-zoom2.c
index b7b3220..fd3369d 100644
--- a/arch/arm/mach-omap2/board-zoom2.c
+++ b/arch/arm/mach-omap2/board-zoom2.c
@@ -25,6 +25,7 @@
 #include <mach/keypad.h>
 
 #include "mmc-twl4030.h"
+#include "sdram-micron-mt46h32m32lf-6.h"
 
 /* Zoom2 has Qwerty keyboard*/
 static int board_keymap[] = {
@@ -213,7 +214,8 @@ static void __init omap_zoom2_init_irq(void)
 {
 	omap_board_config = zoom2_config;
 	omap_board_config_size = ARRAY_SIZE(zoom2_config);
-	omap2_init_common_hw(NULL, NULL);
+	omap2_init_common_hw(mt46h32m32lf6_sdrc_params,
+				 mt46h32m32lf6_sdrc_params);
 	omap_init_irq();
 	omap_gpio_init();
 }
