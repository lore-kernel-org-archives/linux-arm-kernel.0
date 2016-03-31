From: nm@ti.com (Nishanth Menon)
Date: Thu, 31 Mar 2016 16:58:33 -0500
Subject: [PATCH 1/3] ARM: OMAP: DRA7: powerdomain data: Erratum i892
 workaround: Disable core INA
In-Reply-To: <1459461515-5192-1-git-send-email-nm@ti.com>
References: <1459461515-5192-1-git-send-email-nm@ti.com>
Message-ID: <1459461515-5192-2-git-send-email-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Erratum i892 as will be documented in the upcoming G or later revision
of DRA7xx/ AM57xx errata documentation (SPRZ398F) states that L3 clock
needs to be kept active all the time to ensure that asymmetric aging
degradation is minimal and within the design allowed margin.

By allowing core domain to transition to INA and allowing L3 clock to be
turned off for extended periods of time, there is a risk of functional
issues and device failure as a result.

Ref: http://www.ti.com/lit/er/sprz429h/sprz429h.pdf

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/powerdomains7xx_data.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/powerdomains7xx_data.c b/arch/arm/mach-omap2/powerdomains7xx_data.c
index 287a2037aa16..f2b4557124f3 100644
--- a/arch/arm/mach-omap2/powerdomains7xx_data.c
+++ b/arch/arm/mach-omap2/powerdomains7xx_data.c
@@ -160,7 +160,7 @@ static struct powerdomain core_7xx_pwrdm = {
 	.name		  = "core_pwrdm",
 	.prcm_offs	  = DRA7XX_PRM_CORE_INST,
 	.prcm_partition	  = DRA7XX_PRM_PARTITION,
-	.pwrsts		  = PWRSTS_INA_ON,
+	.pwrsts		  = PWRSTS_ON,
 	.pwrsts_logic_ret = PWRSTS_RET,
 	.banks		  = 5,
 	.pwrsts_mem_ret	= {
-- 
2.8.0
