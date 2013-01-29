From: vaibhav.bedia@ti.com (Vaibhav Bedia)
Date: Tue, 29 Jan 2013 16:45:03 +0530
Subject: [PATCH v3 4/9] ARM: OMAP2+: AM33XX: hwmod: Update TPTC0 hwmod with
 the right flags
In-Reply-To: <1359458108-8489-1-git-send-email-vaibhav.bedia@ti.com>
References: <1359458108-8489-1-git-send-email-vaibhav.bedia@ti.com>
Message-ID: <1359458108-8489-5-git-send-email-vaibhav.bedia@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Third Party Transfer Controller (TPTC0) needs to be idled and
put to standby under SW control. Add the appropriate flags in
the TPTC0 hwmod entry.

Signed-off-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Acked-by: Peter Korsgaard <jacmet@sunsite.dk>
---
v3: Add Peter's Acked-by
v2: Drop unnecessary parens

 arch/arm/mach-omap2/omap_hwmod_33xx_data.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
index 8280f11..94254e8 100644
--- a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
@@ -1823,6 +1823,7 @@ static struct omap_hwmod am33xx_tptc0_hwmod = {
 	.class		= &am33xx_tptc_hwmod_class,
 	.clkdm_name	= "l3_clkdm",
 	.mpu_irqs	= am33xx_tptc0_irqs,
+	.flags		= HWMOD_SWSUP_SIDLE | HWMOD_SWSUP_MSTANDBY,
 	.main_clk	= "l3_gclk",
 	.prcm		= {
 		.omap4	= {
-- 
1.8.1
