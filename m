From: tony@atomide.com (Tony Lindgren)
Date: Mon, 21 Dec 2015 10:19:47 -0800
Subject: [PATCH] ARM: OMAP2+: Fix randconfig build warning for dm814_pllss_data
Message-ID: <1450721987-24936-1-git-send-email-tony@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix warning for arch/arm/mach-omap2/prm_common.c:666:35: warning:
?dm814_pllss_data? defined but not used [-Wunused-variable]".

This can happen if CONFIG_SOC_TI81XX is not selected.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/prm_common.c | 2 ++
 1 file changed, 2 insertions(+)

--- a/arch/arm/mach-omap2/prm_common.c
+++ b/arch/arm/mach-omap2/prm_common.c
@@ -662,7 +662,9 @@ static struct omap_prcm_init_data am3_prm_data __initdata = {
 	.index = TI_CLKM_PRM,
 	.init = am33xx_prm_init,
 };
+#endif
 
+#ifdef CONFIG_SOC_TI81XX
 static struct omap_prcm_init_data dm814_pllss_data __initdata = {
 	.index = TI_CLKM_PLLSS,
 	.init = am33xx_prm_init,
-- 
2.6.2
