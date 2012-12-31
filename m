From: vaibhav.bedia@ti.com (Vaibhav Bedia)
Date: Mon, 31 Dec 2012 18:37:00 +0530
Subject: [RFC v2 07/18] ARM: OMAP2+: AM33XX: hwmod: Update TPTC0 hwmod with
 the right flags
In-Reply-To: <1356959231-17335-1-git-send-email-vaibhav.bedia@ti.com>
References: <1356959231-17335-1-git-send-email-vaibhav.bedia@ti.com>
Message-ID: <1356959231-17335-8-git-send-email-vaibhav.bedia@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

TPTC0 needs to be idled and put to standby under SW control.
Add the appropriate flags in the TPTC0 hwmod entry.

Signed-off-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Vaibhav Hiremath <hvaibhav@ti.com>
---
v1->v2:
	No change

 arch/arm/mach-omap2/omap_hwmod_33xx_data.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
index 5e50e68..5c34d4b 100644
--- a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
@@ -1823,6 +1823,7 @@ static struct omap_hwmod am33xx_tptc0_hwmod = {
 	.class		= &am33xx_tptc_hwmod_class,
 	.clkdm_name	= "l3_clkdm",
 	.mpu_irqs	= am33xx_tptc0_irqs,
+	.flags		= (HWMOD_SWSUP_SIDLE | HWMOD_SWSUP_MSTANDBY),
 	.main_clk	= "l3_gclk",
 	.prcm		= {
 		.omap4	= {
-- 
1.7.0.4
