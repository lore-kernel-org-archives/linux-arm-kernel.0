From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Fri,  4 Feb 2011 15:28:58 +0530
Subject: [PATCH v2 3/9] omap4: powerdomain: Use intended PWRSTS_* flags
	instead of values
In-Reply-To: <1296813544-25170-1-git-send-email-santosh.shilimkar@ti.com>
References: <1296813544-25170-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <1296813544-25170-4-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

IVAHD and ABE power domain logic state is populated using directly
value instead of the capability flags.

Fix the same.

This was getting generated due to a bug 'gen_logicst' macro
in powerdomain autogen script bug which is fixed as well.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Rajendra Nayak <rnayak@ti.com>
Cc: Benoit Cousson <b-cousson@ti.com>
---
 arch/arm/mach-omap2/powerdomains44xx_data.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/powerdomains44xx_data.c b/arch/arm/mach-omap2/powerdomains44xx_data.c
index 96cde98..daee255 100644
--- a/arch/arm/mach-omap2/powerdomains44xx_data.c
+++ b/arch/arm/mach-omap2/powerdomains44xx_data.c
@@ -80,7 +80,7 @@ static struct powerdomain abe_44xx_pwrdm = {
 	.prcm_partition	  = OMAP4430_PRM_PARTITION,
 	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 	.pwrsts		  = PWRSTS_OFF_RET_INA_ON,
-	.pwrsts_logic_ret = PWRDM_POWER_OFF,
+	.pwrsts_logic_ret = PWRSTS_OFF,
 	.banks		  = 2,
 	.pwrsts_mem_ret	= {
 		[0] = PWRDM_POWER_RET,	/* aessmem */
@@ -227,7 +227,7 @@ static struct powerdomain ivahd_44xx_pwrdm = {
 	.prcm_partition	  = OMAP4430_PRM_PARTITION,
 	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 	.pwrsts		  = PWRSTS_OFF_RET_INA_ON,
-	.pwrsts_logic_ret = PWRDM_POWER_OFF,
+	.pwrsts_logic_ret = PWRSTS_OFF,
 	.banks		  = 4,
 	.pwrsts_mem_ret	= {
 		[0] = PWRDM_POWER_OFF,	/* hwa_mem */
-- 
1.6.0.4
