From: b-cousson@ti.com (Benoit Cousson)
Date: Mon, 13 Dec 2010 22:49:27 +0100
Subject: [PATCH 3/5] OMAP4: powerdomain: l4per pwrdm does not support OFF
In-Reply-To: <1292276969-29733-1-git-send-email-b-cousson@ti.com>
References: <1292276969-29733-1-git-send-email-b-cousson@ti.com>
Message-ID: <1292276969-29733-4-git-send-email-b-cousson@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rajendra Nayak <rnayak@ti.com>

The l4per power domain in ES2.0 does support only RET and ON states.
The previous ES1.0 HW database was wrong and thus fixed on ES2.
Change the pwrsts field to reflect that.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Acked-by: Benoit Cousson <b-cousson@ti.com>
---
 arch/arm/mach-omap2/powerdomains44xx_data.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/powerdomains44xx_data.c b/arch/arm/mach-omap2/powerdomains44xx_data.c
index 5fdf485..cec9c09 100644
--- a/arch/arm/mach-omap2/powerdomains44xx_data.c
+++ b/arch/arm/mach-omap2/powerdomains44xx_data.c
@@ -285,7 +285,7 @@ static struct powerdomain l4per_44xx_pwrdm = {
 	.prcm_offs	  = OMAP4430_PRM_L4PER_INST,
 	.prcm_partition	  = OMAP4430_PRM_PARTITION,
 	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
-	.pwrsts		  = PWRSTS_OFF_RET_ON,
+	.pwrsts		  = PWRSTS_RET_ON,
 	.pwrsts_logic_ret = PWRSTS_OFF_RET,
 	.banks		  = 2,
 	.pwrsts_mem_ret	= {
-- 
1.7.0.4
