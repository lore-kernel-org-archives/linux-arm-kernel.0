From: eduardo.valentin@ti.com (Eduardo Valentin)
Date: Wed, 13 Apr 2011 18:21:06 +0300
Subject: [PATCH 1/2] OMAP2+: PM: Fix the saving of CM_AUTOIDLE_PLL register on
	scratchpad area
In-Reply-To: <1302708067-8226-1-git-send-email-eduardo.valentin@ti.com>
References: <1302708067-8226-1-git-send-email-eduardo.valentin@ti.com>
Message-ID: <1302708067-8226-2-git-send-email-eduardo.valentin@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The saving of CCR.CM_AUTOIDLE_PLL is done in scratchpad area.

However, in current code, the saving is done for CM_AUTOIDLE2_PLL
(offset 0x34) instead of CM_AUTOIDLE_PLL (offset 0x30).

This patch changes the code to save the correct register.

Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
---
 arch/arm/mach-omap2/control.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/control.c b/arch/arm/mach-omap2/control.c
index 6952794..df0c75c 100644
--- a/arch/arm/mach-omap2/control.c
+++ b/arch/arm/mach-omap2/control.c
@@ -317,7 +317,7 @@ void omap3_save_scratchpad_contents(void)
 	prcm_block_contents.cm_clken_pll =
 			omap2_cm_read_mod_reg(PLL_MOD, CM_CLKEN);
 	prcm_block_contents.cm_autoidle_pll =
-			omap2_cm_read_mod_reg(PLL_MOD, OMAP3430_CM_AUTOIDLE_PLL);
+			omap2_cm_read_mod_reg(PLL_MOD, CM_AUTOIDLE);
 	prcm_block_contents.cm_clksel1_pll =
 			omap2_cm_read_mod_reg(PLL_MOD, OMAP3430_CM_CLKSEL1_PLL);
 	prcm_block_contents.cm_clksel2_pll =
-- 
1.7.5-rc1
