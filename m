From: florian.vaussard@epfl.ch (Florian Vaussard)
Date: Tue, 17 Dec 2013 13:53:37 +0100
Subject: [PATCH 6/7] ARM: OMAP2+: Remove legacy data from hwmod for omap3 isp
 iommu
In-Reply-To: <1387284818-28739-1-git-send-email-florian.vaussard@epfl.ch>
References: <1387284818-28739-1-git-send-email-florian.vaussard@epfl.ch>
Message-ID: <1387284818-28739-7-git-send-email-florian.vaussard@epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The data are now passed using the devicetree.

Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>
---
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index 0477131..6dccd46 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -2469,15 +2469,8 @@ static struct omap_hwmod_class omap3xxx_mmu_hwmod_class = {
 
 /* mmu isp */
 
-static struct omap_mmu_dev_attr mmu_isp_dev_attr = {
-	.da_start	= 0x0,
-	.da_end		= 0xfffff000,
-	.nr_tlb_entries = 8,
-};
-
 static struct omap_hwmod omap3xxx_mmu_isp_hwmod;
 
-
 /* l4_core -> mmu isp */
 static struct omap_hwmod_ocp_if omap3xxx_l4_core__mmu_isp = {
 	.master		= &omap3xxx_l4_core_hwmod,
@@ -2489,7 +2482,6 @@ static struct omap_hwmod omap3xxx_mmu_isp_hwmod = {
 	.name		= "mmu_isp",
 	.class		= &omap3xxx_mmu_hwmod_class,
 	.main_clk	= "cam_ick",
-	.dev_attr	= &mmu_isp_dev_attr,
 	.flags		= HWMOD_NO_IDLEST,
 };
 
-- 
1.8.1.2
