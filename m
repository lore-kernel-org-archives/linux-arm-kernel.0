From: nm@ti.com (Nishanth Menon)
Date: Tue, 24 May 2016 08:35:38 -0500
Subject: [PATCH 1/3] ARM: OMAP: DRA7: powerdomain data: Set L3init and L4per
 to ON
In-Reply-To: <1464096940-27145-1-git-send-email-nm@ti.com>
References: <1464096940-27145-1-git-send-email-nm@ti.com>
Message-ID: <1464096940-27145-2-git-send-email-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As per the latest revision F of public TRM for DRA7/AM57xx SoCs
SPRUHZ6F[1] (April 2016), L4Per and L3init power domains now operate in
always "ON" mode due to asymmetric aging limitations. Update the same

[1] http://www.ti.com/lit/pdf/spruhz6

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/powerdomains7xx_data.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/powerdomains7xx_data.c b/arch/arm/mach-omap2/powerdomains7xx_data.c
index 0ec2d00f4237..8ea447ed4dc4 100644
--- a/arch/arm/mach-omap2/powerdomains7xx_data.c
+++ b/arch/arm/mach-omap2/powerdomains7xx_data.c
@@ -111,7 +111,7 @@ static struct powerdomain l4per_7xx_pwrdm = {
 	.name		  = "l4per_pwrdm",
 	.prcm_offs	  = DRA7XX_PRM_L4PER_INST,
 	.prcm_partition	  = DRA7XX_PRM_PARTITION,
-	.pwrsts		  = PWRSTS_RET_ON,
+	.pwrsts		  = PWRSTS_ON,
 	.pwrsts_logic_ret = PWRSTS_RET,
 	.banks		  = 2,
 	.pwrsts_mem_ret	= {
@@ -260,7 +260,7 @@ static struct powerdomain l3init_7xx_pwrdm = {
 	.name		  = "l3init_pwrdm",
 	.prcm_offs	  = DRA7XX_PRM_L3INIT_INST,
 	.prcm_partition	  = DRA7XX_PRM_PARTITION,
-	.pwrsts		  = PWRSTS_RET_ON,
+	.pwrsts		  = PWRSTS_ON,
 	.pwrsts_logic_ret = PWRSTS_RET,
 	.banks		  = 3,
 	.pwrsts_mem_ret	= {
-- 
2.8.0
