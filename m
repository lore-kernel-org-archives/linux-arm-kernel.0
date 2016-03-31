From: nm@ti.com (Nishanth Menon)
Date: Thu, 31 Mar 2016 16:58:35 -0500
Subject: [PATCH 3/3] ARM: OMAP: DRA7: powerdomain data: Remove wrong OSWR
 capability
In-Reply-To: <1459461515-5192-1-git-send-email-nm@ti.com>
References: <1459461515-5192-1-git-send-email-nm@ti.com>
Message-ID: <1459461515-5192-4-git-send-email-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Open Switch Retention(OSWR) is a retention state which is unsupported
in DRA7 SoC. This state is achieved when power state is set to
retention and logic power state is set to OFF.

Even though DRA7 architecture is a OMAP derivative, none of the
powerdomains are actually implemented to achieve OSWR in the SoC.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/powerdomains7xx_data.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-omap2/powerdomains7xx_data.c b/arch/arm/mach-omap2/powerdomains7xx_data.c
index 81e883d972b9..0ec2d00f4237 100644
--- a/arch/arm/mach-omap2/powerdomains7xx_data.c
+++ b/arch/arm/mach-omap2/powerdomains7xx_data.c
@@ -35,7 +35,7 @@ static struct powerdomain iva_7xx_pwrdm = {
 	.name		  = "iva_pwrdm",
 	.prcm_offs	  = DRA7XX_PRM_IVA_INST,
 	.prcm_partition	  = DRA7XX_PRM_PARTITION,
-	.pwrsts		  = PWRSTS_OFF_RET_ON,
+	.pwrsts		  = PWRSTS_OFF_ON,
 	.pwrsts_logic_ret = PWRSTS_OFF,
 	.banks		  = 4,
 	.pwrsts_mem_ret	= {
@@ -75,7 +75,7 @@ static struct powerdomain ipu_7xx_pwrdm = {
 	.name		  = "ipu_pwrdm",
 	.prcm_offs	  = DRA7XX_PRM_IPU_INST,
 	.prcm_partition	  = DRA7XX_PRM_PARTITION,
-	.pwrsts		  = PWRSTS_OFF_RET_ON,
+	.pwrsts		  = PWRSTS_OFF_ON,
 	.pwrsts_logic_ret = PWRSTS_OFF,
 	.banks		  = 2,
 	.pwrsts_mem_ret	= {
@@ -94,7 +94,7 @@ static struct powerdomain dss_7xx_pwrdm = {
 	.name		  = "dss_pwrdm",
 	.prcm_offs	  = DRA7XX_PRM_DSS_INST,
 	.prcm_partition	  = DRA7XX_PRM_PARTITION,
-	.pwrsts		  = PWRSTS_OFF_RET_ON,
+	.pwrsts		  = PWRSTS_OFF_ON,
 	.pwrsts_logic_ret = PWRSTS_OFF,
 	.banks		  = 1,
 	.pwrsts_mem_ret	= {
@@ -112,7 +112,7 @@ static struct powerdomain l4per_7xx_pwrdm = {
 	.prcm_offs	  = DRA7XX_PRM_L4PER_INST,
 	.prcm_partition	  = DRA7XX_PRM_PARTITION,
 	.pwrsts		  = PWRSTS_RET_ON,
-	.pwrsts_logic_ret = PWRSTS_OFF_RET,
+	.pwrsts_logic_ret = PWRSTS_RET,
 	.banks		  = 2,
 	.pwrsts_mem_ret	= {
 		[0] = PWRSTS_OFF_RET,	/* nonretained_bank */
@@ -225,8 +225,8 @@ static struct powerdomain vpe_7xx_pwrdm = {
 	.name		  = "vpe_pwrdm",
 	.prcm_offs	  = DRA7XX_PRM_VPE_INST,
 	.prcm_partition	  = DRA7XX_PRM_PARTITION,
-	.pwrsts		  = PWRSTS_OFF_RET_ON,
-	.pwrsts_logic_ret = PWRSTS_OFF_RET,
+	.pwrsts		  = PWRSTS_OFF_ON,
+	.pwrsts_logic_ret = PWRSTS_OFF,
 	.banks		  = 1,
 	.pwrsts_mem_ret	= {
 		[0] = PWRSTS_OFF_RET,	/* vpe_bank */
@@ -261,7 +261,7 @@ static struct powerdomain l3init_7xx_pwrdm = {
 	.prcm_offs	  = DRA7XX_PRM_L3INIT_INST,
 	.prcm_partition	  = DRA7XX_PRM_PARTITION,
 	.pwrsts		  = PWRSTS_RET_ON,
-	.pwrsts_logic_ret = PWRSTS_OFF_RET,
+	.pwrsts_logic_ret = PWRSTS_RET,
 	.banks		  = 3,
 	.pwrsts_mem_ret	= {
 		[0] = PWRSTS_OFF_RET,	/* gmac_bank */
-- 
2.8.0
