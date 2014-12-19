From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Fri, 19 Dec 2014 12:45:13 +0200
Subject: [PATCH 1/2] ARM: AM43xx: hwmod: set DSS submodule parent hwmods
In-Reply-To: <1418985914-9027-1-git-send-email-tomi.valkeinen@ti.com>
References: <1418985914-9027-1-git-send-email-tomi.valkeinen@ti.com>
Message-ID: <1418985914-9027-2-git-send-email-tomi.valkeinen@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Set DSS core hwmod as the parent for all the DSS submodules. This fixes
the boot time DSS reset, removing the following warnings:

omap_hwmod: dss_dispc: cannot be enabled for reset (3)
omap_hwmod: dss_rfbi: cannot be enabled for reset (3)

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_43xx_data.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-omap2/omap_hwmod_43xx_data.c b/arch/arm/mach-omap2/omap_hwmod_43xx_data.c
index 5c6c8410160e..8eb85925e444 100644
--- a/arch/arm/mach-omap2/omap_hwmod_43xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_43xx_data.c
@@ -498,6 +498,7 @@ static struct omap_hwmod am43xx_dss_dispc_hwmod = {
 		},
 	},
 	.dev_attr	= &am43xx_dss_dispc_dev_attr,
+	.parent_hwmod	= &am43xx_dss_core_hwmod,
 };
 
 /* rfbi */
@@ -512,6 +513,7 @@ static struct omap_hwmod am43xx_dss_rfbi_hwmod = {
 			.clkctrl_offs = AM43XX_CM_PER_DSS_CLKCTRL_OFFSET,
 		},
 	},
+	.parent_hwmod	= &am43xx_dss_core_hwmod,
 };
 
 /* Interfaces */
-- 
2.2.0
