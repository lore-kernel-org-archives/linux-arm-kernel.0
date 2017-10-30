From: t-kristo@ti.com (Tero Kristo)
Date: Mon, 30 Oct 2017 11:11:03 +0200
Subject: [PATCH 1/2] ARM: OMAP3: hwmod_data: add missing module_offs for MMC3
In-Reply-To: <1509354664-27694-1-git-send-email-t-kristo@ti.com>
References: <1509354664-27694-1-git-send-email-t-kristo@ti.com>
Message-ID: <1509354664-27694-2-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

MMC3 hwmod data is missing the module_offs definition. MMC3 belongs under
core, so add CORE_MOD for it.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index c327643..c12e7b5 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -1656,6 +1656,7 @@
 	.main_clk	= "mmchs3_fck",
 	.prcm		= {
 		.omap2 = {
+			.module_offs = CORE_MOD,
 			.prcm_reg_id = 1,
 			.module_bit = OMAP3430_EN_MMC3_SHIFT,
 			.idlest_reg_id = 1,
-- 
1.9.1

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
