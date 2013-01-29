From: vaibhav.bedia@ti.com (Vaibhav Bedia)
Date: Tue, 29 Jan 2013 12:29:19 +0530
Subject: [PATCH v2 6/9] ARM: OMAP2+: AM33XX: hwmod: Update the WKUP-M3 hwmod
 with reset status bit
In-Reply-To: <1359442762-13697-1-git-send-email-vaibhav.bedia@ti.com>
References: <1359442762-13697-1-git-send-email-vaibhav.bedia@ti.com>
Message-ID: <1359442762-13697-7-git-send-email-vaibhav.bedia@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

WKUP-M3 has a reset status bit (RM_WKUP_STST.WKUP_M3_LRST)
Update the WKUP-M3 hwmod data to reflect the same.

Signed-off-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
---
v2: No change

 arch/arm/mach-omap2/omap_hwmod_33xx_data.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
index 40bfde3..9e34d4c 100644
--- a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
@@ -269,6 +269,7 @@ static struct omap_hwmod am33xx_wkup_m3_hwmod = {
 		.omap4	= {
 			.clkctrl_offs	= AM33XX_CM_WKUP_WKUP_M3_CLKCTRL_OFFSET,
 			.rstctrl_offs	= AM33XX_RM_WKUP_RSTCTRL_OFFSET,
+			.rstst_offs	= AM33XX_RM_WKUP_RSTST_OFFSET,
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
-- 
1.8.1
