From: paul@pwsan.com (Paul Walmsley)
Date: Wed, 20 Apr 2011 13:28:43 -0600
Subject: [PATCH 3/5] OMAP2+: PM: Fix the saving of CM_AUTOIDLE_PLL register on
	scratchpad area
In-Reply-To: <20110420192601.16986.56558.stgit@twilight.localdomain>
References: <20110420192601.16986.56558.stgit@twilight.localdomain>
Message-ID: <20110420192841.16986.24126.stgit@twilight.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Eduardo Valentin <eduardo.valentin@ti.com>

The saving of CCR.CM_AUTOIDLE_PLL is done in scratchpad area.

However, in current code, the saving is done for CM_AUTOIDLE2_PLL
(offset 0x34) instead of CM_AUTOIDLE_PLL (offset 0x30).

This patch changes the code to save the correct register.

Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
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
