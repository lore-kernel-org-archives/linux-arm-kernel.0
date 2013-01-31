From: paul@pwsan.com (Paul Walmsley)
Date: Thu, 31 Jan 2013 15:28:24 +0000 (UTC)
Subject: [Patch v2 1/2] ARM: OMAP2+: AM33xx: hwmod: add missing
 HWMOD_NO_IDLEST flags
In-Reply-To: <1359642327-5542-2-git-send-email-gururaja.hebbar@ti.com>
References: <1359642327-5542-1-git-send-email-gururaja.hebbar@ti.com>
 <1359642327-5542-2-git-send-email-gururaja.hebbar@ti.com>
Message-ID: <alpine.DEB.2.00.1301311527190.23099@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

On Thu, 31 Jan 2013, Hebbar Gururaja wrote:

> struct omap_hwmod records belonging to wkup m3 domain is missing
> HWMOD_NO_IDLEST flags; add them.
> 
> Signed-off-by: Hebbar Gururaja <gururaja.hebbar@ti.com>

I've modified this patch to add some more description of why it's needed 
as a fix, and queued it for v3.8-rc fixes.

Updated patch follows.


- Paul

From: Hebbar Gururaja <gururaja.hebbar@ti.com>
Date: Thu, 31 Jan 2013 19:55:26 +0530
Subject: [PATCH] ARM: OMAP2+: AM33xx: hwmod: add missing HWMOD_NO_IDLEST
 flags

struct omap_hwmod records belonging to wkup m3 domain is missing
HWMOD_NO_IDLEST flags; add them.

This patch is a prerequisite for a subsequent patch, 'ARM: OMAP2:
am33xx-hwmod: Fix "register offset NULL check" bug'.  That patch would
otherwise attempt to read from reserved bits.

Signed-off-by: Hebbar Gururaja <gururaja.hebbar@ti.com>
[paul at pwsan.com: add some more explanation in the patch description]
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/omap_hwmod_33xx_data.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
index 646c14d..1ab693e 100644
--- a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
@@ -262,7 +262,8 @@ static struct omap_hwmod am33xx_wkup_m3_hwmod = {
 	.name		= "wkup_m3",
 	.class		= &am33xx_wkup_m3_hwmod_class,
 	.clkdm_name	= "l4_wkup_aon_clkdm",
-	.flags		= HWMOD_INIT_NO_RESET,	/* Keep hardreset asserted */
+	/* Keep hardreset asserted */
+	.flags		= HWMOD_INIT_NO_RESET | HWMOD_NO_IDLEST,
 	.mpu_irqs	= am33xx_wkup_m3_irqs,
 	.main_clk	= "dpll_core_m4_div2_ck",
 	.prcm		= {
-- 
1.7.10.4
