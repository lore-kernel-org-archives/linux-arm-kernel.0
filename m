From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Fri, 13 Feb 2015 17:11:20 +0200
Subject: [PATCH 3/9] ARM: DRA7: hwmod: set DSS submodule parent hwmods
In-Reply-To: <1423840286-18377-1-git-send-email-tomi.valkeinen@ti.com>
References: <1423840286-18377-1-git-send-email-tomi.valkeinen@ti.com>
Message-ID: <1423840286-18377-4-git-send-email-tomi.valkeinen@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Set DSS core hwmod as the parent for all the DSS submodules.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
index 47664bab5b57..d7d2404f5f28 100644
--- a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
@@ -521,6 +521,7 @@ static struct omap_hwmod dra7xx_dss_dispc_hwmod = {
 		},
 	},
 	.dev_attr	= &dss_dispc_dev_attr,
+	.parent_hwmod	= &dra7xx_dss_hwmod,
 };
 
 /*
@@ -562,6 +563,7 @@ static struct omap_hwmod dra7xx_dss_hdmi_hwmod = {
 	},
 	.opt_clks	= dss_hdmi_opt_clks,
 	.opt_clks_cnt	= ARRAY_SIZE(dss_hdmi_opt_clks),
+	.parent_hwmod	= &dra7xx_dss_hwmod,
 };
 
 /*
-- 
2.3.0
