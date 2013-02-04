From: hdoyu@nvidia.com (Hiroshi Doyu)
Date: Mon, 4 Feb 2013 13:08:18 +0200
Subject: [PATCH 1/2] ARM: tegra: Fix build error for gic update
Message-ID: <1359976100-28871-1-git-send-email-hdoyu@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix build error in board-dt-tegra114.c(next-20130204)

Signed-off-by: Hiroshi Doyu <hdoyu@nvidia.com>
Reported-by: Sami Liedes<sliedes@nvidia.com>
---
 arch/arm/mach-tegra/board-dt-tegra114.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/mach-tegra/board-dt-tegra114.c b/arch/arm/mach-tegra/board-dt-tegra114.c
index 3ed17ce..72598e2 100644
--- a/arch/arm/mach-tegra/board-dt-tegra114.c
+++ b/arch/arm/mach-tegra/board-dt-tegra114.c
@@ -19,7 +19,6 @@
 #include <linux/clocksource.h>
 
 #include <asm/mach/arch.h>
-#include <asm/hardware/gic.h>
 
 #include "board.h"
 #include "common.h"
@@ -39,7 +38,6 @@ DT_MACHINE_START(TEGRA114_DT, "NVIDIA Tegra114 (Flattened Device Tree)")
 	.map_io		= tegra_map_common_io,
 	.init_early	= tegra30_init_early,
 	.init_irq	= tegra_dt_init_irq,
-	.handle_irq	= gic_handle_irq,
 	.init_time	= clocksource_of_init,
 	.init_machine	= tegra114_dt_init,
 	.init_late	= tegra_init_late,
-- 
1.7.9.5
