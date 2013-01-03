From: panto@antoniou-consulting.com (Pantelis Antoniou)
Date: Fri,  4 Jan 2013 00:32:22 +0200
Subject: [PATCH] omap: am33xx-hwmod: Fix wrongly terminated
 am33xx_usbss_mpu_irqs array
Message-ID: <1357252342-6166-1-git-send-email-panto@antoniou-consulting.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The IRQ array must be terminated by -1 and not by -1+OMAP_INTC_START
This led to having a resource list of 100s of IRQs.

Signed-off-by: Pantelis Antoniou <panto@antoniou-consulting.com>
---
 arch/arm/mach-omap2/omap_hwmod_33xx_data.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
index 081c71e..e402303 100644
--- a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
@@ -2070,7 +2070,7 @@ static struct omap_hwmod_irq_info am33xx_usbss_mpu_irqs[] = {
 	{ .name = "usbss-irq", .irq = 17 + OMAP_INTC_START, },
 	{ .name = "musb0-irq", .irq = 18 + OMAP_INTC_START, },
 	{ .name = "musb1-irq", .irq = 19 + OMAP_INTC_START, },
-	{ .irq = -1 + OMAP_INTC_START, },
+	{ .irq = -1, },
 };
 
 static struct omap_hwmod am33xx_usbss_hwmod = {
-- 
1.7.12
