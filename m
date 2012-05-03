From: r.sricharan@ti.com (R Sricharan)
Date: Thu, 3 May 2012 12:56:15 +0530
Subject: [PATCH 06/13] ARM: OMAP5: gpmc: Update gpmc_init()
In-Reply-To: <1336029982-31898-1-git-send-email-r.sricharan@ti.com>
References: <1336029982-31898-1-git-send-email-r.sricharan@ti.com>
Message-ID: <1336029982-31898-7-git-send-email-r.sricharan@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

GPMC module is the same as in OMAP4.
Just update the base address and irq number.

Signed-off-by: R Sricharan <r.sricharan@ti.com>
---
 arch/arm/mach-omap2/gpmc.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index 00d5108..2f8f915 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -713,7 +713,8 @@ static int __init gpmc_init(void)
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
1.7.1
