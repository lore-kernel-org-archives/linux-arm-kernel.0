From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Fri, 19 Dec 2014 12:45:14 +0200
Subject: [PATCH 2/2] ARM: DRA7xx: hwmod: set DSS submodule parent hwmods
In-Reply-To: <1418985914-9027-1-git-send-email-tomi.valkeinen@ti.com>
References: <1418985914-9027-1-git-send-email-tomi.valkeinen@ti.com>
Message-ID: <1418985914-9027-3-git-send-email-tomi.valkeinen@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Set DSS core hwmod as the parent for all the DSS submodules. This fixes
the boot time DSS reset, removing the following warnings:

omap_hwmod: dss_dispc: cannot be enabled for reset (3)
omap_hwmod: dss_hdmi: cannot be enabled for reset (3)

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
index ffd6604cd546..41238d509cb5 100644
--- a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
@@ -500,6 +500,7 @@ static struct omap_hwmod dra7xx_dss_dispc_hwmod = {
 		},
 	},
 	.dev_attr	= &dss_dispc_dev_attr,
+	.parent_hwmod	= &dra7xx_dss_hwmod,
 };
 
 /*
@@ -541,6 +542,7 @@ static struct omap_hwmod dra7xx_dss_hdmi_hwmod = {
 	},
 	.opt_clks	= dss_hdmi_opt_clks,
 	.opt_clks_cnt	= ARRAY_SIZE(dss_hdmi_opt_clks),
+	.parent_hwmod	= &dra7xx_dss_hwmod,
 };
 
 /*
-- 
2.2.0
