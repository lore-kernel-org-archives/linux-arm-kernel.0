From: eballetbo@gmail.com (Enric Balletbo i Serra)
Date: Sat, 23 Oct 2010 18:48:59 +0200
Subject: [PATCHv2 2/3] omap3: IGEP v2: Remove igep2_config array.
In-Reply-To: <1287852540-4951-1-git-send-email-eballetbo@gmail.com>
References: <1287852540-4951-1-git-send-email-eballetbo@gmail.com>
Message-ID: <1287852540-4951-3-git-send-email-eballetbo@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

omap_board_config_size is implicitly initialized to 0 in
plat-omap/common.c, get_config() won't dereference omap_board_config,
so we can remove the empty igep2_config array.

Signed-off-by: Enric Balletbo i Serra <eballetbo@gmail.com>
---
 arch/arm/mach-omap2/board-igep0020.c |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/board-igep0020.c b/arch/arm/mach-omap2/board-igep0020.c
index 20b199f..42dcbf4 100644
--- a/arch/arm/mach-omap2/board-igep0020.c
+++ b/arch/arm/mach-omap2/board-igep0020.c
@@ -247,9 +247,6 @@ static inline void __init igep2_init_smsc911x(void)
 static inline void __init igep2_init_smsc911x(void) { }
 #endif
 
-static struct omap_board_config_kernel igep2_config[] __initdata = {
-};
-
 static struct regulator_consumer_supply igep2_vmmc1_supply = {
 	.supply		= "vmmc",
 };
@@ -486,8 +483,6 @@ static struct platform_device *igep2_devices[] __initdata = {
 
 static void __init igep2_init_irq(void)
 {
-	omap_board_config = igep2_config;
-	omap_board_config_size = ARRAY_SIZE(igep2_config);
 	omap2_init_common_hw(m65kxxxxam_sdrc_params, m65kxxxxam_sdrc_params);
 	omap_init_irq();
 	omap_gpio_init();
-- 
1.7.1
