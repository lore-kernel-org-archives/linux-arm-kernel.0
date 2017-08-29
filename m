From: tony@atomide.com (Tony Lindgren)
Date: Tue, 29 Aug 2017 10:03:34 -0700
Subject: [PATCH 4/5] ARM: OMAP2+: Drop unused omap_init_hdq
In-Reply-To: <20170829170335.11536-1-tony@atomide.com>
References: <20170829170335.11536-1-tony@atomide.com>
Message-ID: <20170829170335.11536-5-tony@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We now boot all of mach-omap2 in device tree only mode and
this is now dead code.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/hdq1w.c | 22 ----------------------
 1 file changed, 22 deletions(-)

diff --git a/arch/arm/mach-omap2/hdq1w.c b/arch/arm/mach-omap2/hdq1w.c
--- a/arch/arm/mach-omap2/hdq1w.c
+++ b/arch/arm/mach-omap2/hdq1w.c
@@ -75,25 +75,3 @@ int omap_hdq1w_reset(struct omap_hwmod *oh)
 
 	return 0;
 }
-
-#ifndef CONFIG_OF
-static int __init omap_init_hdq(void)
-{
-	int id = -1;
-	struct platform_device *pdev;
-	struct omap_hwmod *oh;
-	char *oh_name = "hdq1w";
-	char *devname = "omap_hdq";
-
-	oh = omap_hwmod_lookup(oh_name);
-	if (!oh)
-		return 0;
-
-	pdev = omap_device_build(devname, id, oh, NULL, 0);
-	WARN(IS_ERR(pdev), "Can't build omap_device for %s:%s.\n",
-	     devname, oh->name);
-
-	return 0;
-}
-omap_arch_initcall(omap_init_hdq);
-#endif
-- 
2.14.1
