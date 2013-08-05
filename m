From: ujhelyi.m@gmail.com (ujhelyi.m at gmail.com)
Date: Mon,  5 Aug 2013 12:02:24 +0200
Subject: [PATCH] am33xx-restart: trigger warm reset on omap2+ boards
Message-ID: <1375696944-13380-1-git-send-email-ujhelyi.m@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Matus Ujhelyi <ujhelyi.m@gmail.com>

Currently the cold reset was triggered. It happened due to oposite offsets
of cold/warm flags in PRM_RSTST and PRM_RSTCTRL registers.

Signed-off-by: Matus Ujhelyi <ujhelyi.m@gmail.com>
---
 arch/arm/mach-omap2/am33xx-restart.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/am33xx-restart.c b/arch/arm/mach-omap2/am33xx-restart.c
index 1eae962..c88d8df7 100644
--- a/arch/arm/mach-omap2/am33xx-restart.c
+++ b/arch/arm/mach-omap2/am33xx-restart.c
@@ -24,8 +24,8 @@ void am33xx_restart(enum reboot_mode mode, const char *cmd)
 {
 	/* TODO: Handle mode and cmd if necessary */
 
-	am33xx_prm_rmw_reg_bits(AM33XX_GLOBAL_WARM_SW_RST_MASK,
-				AM33XX_GLOBAL_WARM_SW_RST_MASK,
+	am33xx_prm_rmw_reg_bits(AM33XX_RST_GLOBAL_WARM_SW_MASK,
+				AM33XX_RST_GLOBAL_WARM_SW_MASK,
 				AM33XX_PRM_DEVICE_MOD,
 				AM33XX_PRM_RSTCTRL_OFFSET);
 
-- 
1.7.9.5
