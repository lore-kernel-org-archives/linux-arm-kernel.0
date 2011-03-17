From: balajitk@ti.com (Balaji T K)
Date: Thu, 17 Mar 2011 21:30:04 +0530
Subject: [PATCH 1/3] ARM: OMAP2+: correct GPMC IRQ
In-Reply-To: <1300377606-16616-1-git-send-email-balajitk@ti.com>
References: <1300377606-16616-1-git-send-email-balajitk@ti.com>
Message-ID: <1300377606-16616-2-git-send-email-balajitk@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

GPMC: number of chip select is 8, CS0 to CS7
One less IRQ allocated throws below warning at boot

[    0.429290] Trying to install type control for IRQ409
[    0.429290] Trying to set irq flags for IRQ409

Signed-off-by: Balaji T K <balajitk@ti.com>
---
 arch/arm/plat-omap/include/plat/irqs.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/irqs.h b/arch/arm/plat-omap/include/plat/irqs.h
index d779283..5a25098 100644
--- a/arch/arm/plat-omap/include/plat/irqs.h
+++ b/arch/arm/plat-omap/include/plat/irqs.h
@@ -416,7 +416,7 @@
 
 /* GPMC related */
 #define OMAP_GPMC_IRQ_BASE	(TWL_IRQ_END)
-#define OMAP_GPMC_NR_IRQS	7
+#define OMAP_GPMC_NR_IRQS	8
 #define OMAP_GPMC_IRQ_END	(OMAP_GPMC_IRQ_BASE + OMAP_GPMC_NR_IRQS)
 
 
-- 
1.7.0.4
