From: lokeshvutla@ti.com (Lokesh Vutla)
Date: Fri, 19 Dec 2014 18:04:50 +0530
Subject: [PATCH] ARM: OMAP2+: hwmod: print error if wait_target_ready() failed
Message-ID: <1418992490-2901-1-git-send-email-lokeshvutla@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fixed pr_debug to pr_err when hwmod returns an error when enabling
a module.

Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index cbb908d..06157af 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -2155,8 +2155,8 @@ static int _enable(struct omap_hwmod *oh)
 		if (soc_ops.disable_module)
 			soc_ops.disable_module(oh);
 		_disable_clocks(oh);
-		pr_debug("omap_hwmod: %s: _wait_target_ready: %d\n",
-			 oh->name, r);
+		pr_err("omap_hwmod: %s: _wait_target_ready failed: %d\n",
+		       oh->name, r);
 
 		if (oh->clkdm)
 			clkdm_hwmod_disable(oh->clkdm, oh);
-- 
1.9.1
