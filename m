From: paul@pwsan.com (Paul Walmsley)
Date: Fri, 24 Sep 2010 01:08:17 -0600
Subject: [PATCH 06/12] OMAP4: powerdomain: Update DSS logic state for ES2
In-Reply-To: <20100924070643.14014.11359.stgit@twilight.localdomain>
References: <20100924070643.14014.11359.stgit@twilight.localdomain>
Message-ID: <20100924070815.14014.90011.stgit@twilight.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rajendra Nayak <rnayak@ti.com>

DSS on ES2 supports only OSWR, hence remove the support
for CSWR from the powerdomain framework.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Beno?t Cousson <b-cousson@ti.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/powerdomains44xx.h        |    2 +-
 arch/arm/plat-omap/include/plat/powerdomain.h |    1 +
 2 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/powerdomains44xx.h b/arch/arm/mach-omap2/powerdomains44xx.h
index c721951..9c01b55 100644
--- a/arch/arm/mach-omap2/powerdomains44xx.h
+++ b/arch/arm/mach-omap2/powerdomains44xx.h
@@ -98,7 +98,7 @@ static struct powerdomain dss_44xx_pwrdm = {
 	.prcm_offs	  = OMAP4430_PRM_DSS_MOD,
 	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 	.pwrsts		  = PWRSTS_OFF_RET_ON,
-	.pwrsts_logic_ret = PWRSTS_OFF_RET,
+	.pwrsts_logic_ret = PWRSTS_OFF,
 	.banks		  = 1,
 	.pwrsts_mem_ret	= {
 		[0] = PWRDM_POWER_OFF,	/* dss_mem */
diff --git a/arch/arm/plat-omap/include/plat/powerdomain.h b/arch/arm/plat-omap/include/plat/powerdomain.h
index fb6ec74..3ea7220 100644
--- a/arch/arm/plat-omap/include/plat/powerdomain.h
+++ b/arch/arm/plat-omap/include/plat/powerdomain.h
@@ -32,6 +32,7 @@
 
 /* Powerdomain allowable state bitfields */
 #define PWRSTS_ON		(1 << PWRDM_POWER_ON)
+#define PWRSTS_OFF		(1 << PWRDM_POWER_OFF)
 #define PWRSTS_OFF_ON		((1 << PWRDM_POWER_OFF) | \
 				 (1 << PWRDM_POWER_ON))
 
