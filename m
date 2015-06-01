From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Mon, 1 Jun 2015 09:23:13 +0300
Subject: [PATCHv4 05/10] ARM: DRA7: hwmod: set DSS submodule parent hwmods
In-Reply-To: <1433139798-23450-1-git-send-email-tomi.valkeinen@ti.com>
References: <1433139798-23450-1-git-send-email-tomi.valkeinen@ti.com>
Message-ID: <1433139798-23450-6-git-send-email-tomi.valkeinen@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Set DSS core hwmod as the parent for all the DSS submodules.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
index f6b94854fafc..9961f95f52ae 100644
--- a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
@@ -522,6 +522,7 @@ static struct omap_hwmod dra7xx_dss_dispc_hwmod = {
 		},
 	},
 	.dev_attr	= &dss_dispc_dev_attr,
+	.parent_hwmod	= &dra7xx_dss_hwmod,
 };
 
 /*
@@ -563,6 +564,7 @@ static struct omap_hwmod dra7xx_dss_hdmi_hwmod = {
 	},
 	.opt_clks	= dss_hdmi_opt_clks,
 	.opt_clks_cnt	= ARRAY_SIZE(dss_hdmi_opt_clks),
+	.parent_hwmod	= &dra7xx_dss_hwmod,
 };
 
 /*
-- 
2.1.4
