From: b-cousson@ti.com (Benoit Cousson)
Date: Mon, 13 Dec 2010 22:49:28 +0100
Subject: [PATCH 4/5] OMAP4: powerdomain: Remove L3INIT_PD OFF state
In-Reply-To: <1292276969-29733-1-git-send-email-b-cousson@ti.com>
References: <1292276969-29733-1-git-send-email-b-cousson@ti.com>
Message-ID: <1292276969-29733-5-git-send-email-b-cousson@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Santosh Shilimkar <santosh.shilimkar@ti.com>

On OMAP4, there is an issue when L3INIT transitions to OFF mode without
device OFF. The SAR restore mechanism will not get triggered without
wakeup from device OFF and hence the USB host and USB TLL context
will not be restored.

Hardware team recommended to remove the OFF state support for L3INIT_PD
since there is no power impact. It will be removed on next OMAP revision
(OMAP4440 and beyond).

Hence this patch removed the OFF state from L3INIT_PD. The deepest
state supported on L3INIT_PD is OSWR just like CORE_PD and PER_PD

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
[b-cousson at ti.com: update the changelog with next OMAP info]
Signed-off-by: Benoit Cousson <b-cousson@ti.com>
---
 arch/arm/mach-omap2/powerdomains44xx_data.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/powerdomains44xx_data.c b/arch/arm/mach-omap2/powerdomains44xx_data.c
index cec9c09..26d7641 100644
--- a/arch/arm/mach-omap2/powerdomains44xx_data.c
+++ b/arch/arm/mach-omap2/powerdomains44xx_data.c
@@ -267,7 +267,7 @@ static struct powerdomain l3init_44xx_pwrdm = {
 	.prcm_offs	  = OMAP4430_PRM_L3INIT_INST,
 	.prcm_partition	  = OMAP4430_PRM_PARTITION,
 	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
-	.pwrsts		  = PWRSTS_OFF_RET_ON,
+	.pwrsts		  = PWRSTS_RET_ON,
 	.pwrsts_logic_ret = PWRSTS_OFF_RET,
 	.banks		  = 1,
 	.pwrsts_mem_ret	= {
-- 
1.7.0.4
