From: t-kristo@ti.com (Tero Kristo)
Date: Thu, 19 Jul 2012 16:26:23 +0300
Subject: [PATCHv7 03/12] ARM: OMAP4: hwmod: flag hwmods/modules not supporting
 module level context status
In-Reply-To: <1342704392-23657-1-git-send-email-t-kristo@ti.com>
References: <1342704392-23657-1-git-send-email-t-kristo@ti.com>
Message-ID: <1342704392-23657-4-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On OMAP4 most modules/hwmods support module level context status. On
OMAP3 and earlier, we relied on the power domain level context status.
Identify all modules that don't support 'context_offs' by marking the
offset as USHRT_MAX. Rest have a valid 'context_offs' populated in
.prcm structure already.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   46 ++++++++++++++++++++++++++++
 1 files changed, 46 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index b7bcba5..ad7df4e 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -204,6 +204,7 @@ static struct omap_hwmod omap44xx_l4_abe_hwmod = {
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM1_ABE_L4ABE_CLKCTRL_OFFSET,
+			.context_offs = USHRT_MAX,
 		},
 	},
 };
@@ -260,6 +261,11 @@ static struct omap_hwmod omap44xx_mpu_private_hwmod = {
 	.name		= "mpu_private",
 	.class		= &omap44xx_mpu_bus_hwmod_class,
 	.clkdm_name	= "mpuss_clkdm",
+	.prcm = {
+		.omap4 = {
+			.context_offs = USHRT_MAX,
+		},
+	},
 };
 
 /*
@@ -448,6 +454,11 @@ static struct omap_hwmod omap44xx_ctrl_module_core_hwmod = {
 	.class		= &omap44xx_ctrl_module_hwmod_class,
 	.clkdm_name	= "l4_cfg_clkdm",
 	.mpu_irqs	= omap44xx_ctrl_module_core_irqs,
+	.prcm = {
+		.omap4 = {
+			.context_offs = USHRT_MAX,
+		},
+	},
 };
 
 /* ctrl_module_pad_core */
@@ -455,6 +466,11 @@ static struct omap_hwmod omap44xx_ctrl_module_pad_core_hwmod = {
 	.name		= "ctrl_module_pad_core",
 	.class		= &omap44xx_ctrl_module_hwmod_class,
 	.clkdm_name	= "l4_cfg_clkdm",
+	.prcm = {
+		.omap4 = {
+			.context_offs = USHRT_MAX,
+		},
+	},
 };
 
 /* ctrl_module_wkup */
@@ -462,6 +478,11 @@ static struct omap_hwmod omap44xx_ctrl_module_wkup_hwmod = {
 	.name		= "ctrl_module_wkup",
 	.class		= &omap44xx_ctrl_module_hwmod_class,
 	.clkdm_name	= "l4_wkup_clkdm",
+	.prcm = {
+		.omap4 = {
+			.context_offs = USHRT_MAX,
+		},
+	},
 };
 
 /* ctrl_module_pad_wkup */
@@ -469,6 +490,11 @@ static struct omap_hwmod omap44xx_ctrl_module_pad_wkup_hwmod = {
 	.name		= "ctrl_module_pad_wkup",
 	.class		= &omap44xx_ctrl_module_hwmod_class,
 	.clkdm_name	= "l4_wkup_clkdm",
+	.prcm = {
+		.omap4 = {
+			.context_offs = USHRT_MAX,
+		},
+	},
 };
 
 /*
@@ -2538,6 +2564,11 @@ static struct omap_hwmod omap44xx_prcm_mpu_hwmod = {
 	.name		= "prcm_mpu",
 	.class		= &omap44xx_prcm_hwmod_class,
 	.clkdm_name	= "l4_wkup_clkdm",
+	.prcm = {
+		.omap4 = {
+			.context_offs = USHRT_MAX,
+		},
+	},
 };
 
 /* cm_core_aon */
@@ -2545,6 +2576,11 @@ static struct omap_hwmod omap44xx_cm_core_aon_hwmod = {
 	.name		= "cm_core_aon",
 	.class		= &omap44xx_prcm_hwmod_class,
 	.clkdm_name	= "cm_clkdm",
+	.prcm = {
+		.omap4 = {
+			.context_offs = USHRT_MAX,
+		},
+	},
 };
 
 /* cm_core */
@@ -2552,6 +2588,11 @@ static struct omap_hwmod omap44xx_cm_core_hwmod = {
 	.name		= "cm_core",
 	.class		= &omap44xx_prcm_hwmod_class,
 	.clkdm_name	= "cm_clkdm",
+	.prcm = {
+		.omap4 = {
+			.context_offs = USHRT_MAX,
+		},
+	},
 };
 
 /* prm */
@@ -2588,6 +2629,11 @@ static struct omap_hwmod omap44xx_scrm_hwmod = {
 	.name		= "scrm",
 	.class		= &omap44xx_scrm_hwmod_class,
 	.clkdm_name	= "l4_wkup_clkdm",
+	.prcm = {
+		.omap4 = {
+			.context_offs = USHRT_MAX,
+		},
+	},
 };
 
 /*
-- 
1.7.4.1
