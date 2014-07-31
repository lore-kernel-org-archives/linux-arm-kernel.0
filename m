From: jvial@adeneo-embedded.com (Jeremy Vial)
Date: Thu, 31 Jul 2014 15:10:34 +0200
Subject: [PATCH 2/2] ARM: OMAP3: Fix coding style problems in
 arch/arm/mach-omap2/control.c
In-Reply-To: <1406812234-23163-1-git-send-email-jvial@adeneo-embedded.com>
References: <1406812234-23163-1-git-send-email-jvial@adeneo-embedded.com>
Message-ID: <1406812234-23163-3-git-send-email-jvial@adeneo-embedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Jeremy Vial <jvial@adeneo-embedded.com>
---
 arch/arm/mach-omap2/control.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/control.c b/arch/arm/mach-omap2/control.c
index acadac0..cc5d767 100644
--- a/arch/arm/mach-omap2/control.c
+++ b/arch/arm/mach-omap2/control.c
@@ -281,6 +281,7 @@ void omap3_clear_scratchpad_contents(void)
 	u32 max_offset = OMAP343X_SCRATCHPAD_ROM_OFFSET;
 	void __iomem *v_addr;
 	u32 offset = 0;
+
 	v_addr = OMAP2_L4_IO_ADDRESS(OMAP343X_SCRATCHPAD_ROM);
 	if (omap2_prm_read_mod_reg(OMAP3430_GR_MOD, OMAP3_PRM_RSTST_OFFSET) &
 	    OMAP3430_GLOBAL_COLD_RST_MASK) {
@@ -475,7 +476,6 @@ void omap3_control_save_context(void)
 	control_context.csi = omap_ctrl_readl(OMAP343X_CONTROL_CSI);
 	control_context.padconf_sys_nirq =
 		omap_ctrl_readl(OMAP343X_CONTROL_PADCONF_SYSNIRQ);
-	return;
 }
 
 void omap3_control_restore_context(void)
@@ -533,7 +533,6 @@ void omap3_control_restore_context(void)
 	omap_ctrl_writel(control_context.csi, OMAP343X_CONTROL_CSI);
 	omap_ctrl_writel(control_context.padconf_sys_nirq,
 			 OMAP343X_CONTROL_PADCONF_SYSNIRQ);
-	return;
 }
 
 void omap3630_ctrl_disable_rta(void)
-- 
1.7.9.5
