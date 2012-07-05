From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Thu, 5 Jul 2012 17:38:48 +0530
Subject: [PATCH v1 06/14] ARM: OMAP5: gpmc: Update gpmc_init()
In-Reply-To: <1341490136-25901-1-git-send-email-santosh.shilimkar@ti.com>
References: <1341490136-25901-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <1341490136-25901-11-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: R Sricharan <r.sricharan@ti.com>

GPMC module is the same as in OMAP4.
Just update the base address and irq number.

Signed-off-by: R Sricharan <r.sricharan@ti.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/gpmc.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index 2286410..fa21b4b 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -727,7 +727,8 @@ static int __init gpmc_init(void)
 		ck = "gpmc_fck";
 		l = OMAP34XX_GPMC_BASE;
 		gpmc_irq = INT_34XX_GPMC_IRQ;
-	} else if (cpu_is_omap44xx()) {
+	} else if (cpu_is_omap44xx() || cpu_is_omap54xx()) {
+		/* Base address and irq number are same for OMAP4/5 */
 		ck = "gpmc_ck";
 		l = OMAP44XX_GPMC_BASE;
 		gpmc_irq = OMAP44XX_IRQ_GPMC;
-- 
1.7.9.5
