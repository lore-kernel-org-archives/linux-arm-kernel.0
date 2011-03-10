From: paul@pwsan.com (Paul Walmsley)
Date: Wed, 9 Mar 2011 19:32:31 -0700 (MST)
Subject: [PATCH] OMAP3: hwmod: remove incorrect SmartReflex -> L4 CORE
	interconnect links
Message-ID: <alpine.DEB.2.00.1103091931420.15132@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Commit d34427267186827dfd62bd8cf726601fffb22534 ("OMAP3: PM: Adding
smartreflex hwmod data") added data that claims that the L4 CORE has
two slave interfaces that originate from the SmartReflex modules,
omap3_l4_core__sr1 and omap3_l4_core__sr2.  But as those two data
structure records show, it's L4 CORE that has a master port towards
SR1 and SR2.  Remove the incorrect data.

Based on a patch by Beno?t Cousson <b-cousson@ti.com>:

    https://patchwork.kernel.org/patch/590561/

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Beno?t Cousson <b-cousson@ti.com>
Cc: Sanjeev Premi <premi@ti.com>
Cc: Thara Gopinath <thara@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index 8d81813..18b0dd4 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -304,8 +304,6 @@ static struct omap_hwmod_ocp_if omap3_l4_core__sr2 = {
 /* Slave interfaces on the L4_CORE interconnect */
 static struct omap_hwmod_ocp_if *omap3xxx_l4_core_slaves[] = {
 	&omap3xxx_l3_main__l4_core,
-	&omap3_l4_core__sr1,
-	&omap3_l4_core__sr2,
 };
 
 /* Master interfaces on the L4_CORE interconnect */
-- 
1.7.2.3
