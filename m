From: gang.chen@asianux.com (Chen Gang)
Date: Wed, 21 Aug 2013 16:26:28 +0800
Subject: [PATCH] ARM: OMAP2: add type cast from 'unsigned' to 'signed'
Message-ID: <521479B4.8030604@asianux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Need add type cast, or can not notice the failure. The related warning
(allmodconfig, "EXTRA_CFLAGS=-W"):

  arch/arm/mach-omap2/gpmc.c:728:2: warning: comparison of unsigned expression < 0 is always false [-Wtype-limits]


Signed-off-by: Chen Gang <gang.chen@asianux.com>
---
 arch/arm/mach-omap2/gpmc.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index f3fdd6a..62377b5 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -725,7 +725,7 @@ static int gpmc_setup_irq(void)
 		return -EINVAL;
 
 	gpmc_irq_start = irq_alloc_descs(-1, 0, GPMC_NR_IRQ, 0);
-	if (gpmc_irq_start < 0) {
+	if ((signed)gpmc_irq_start < 0) {
 		pr_err("irq_alloc_descs failed\n");
 		return gpmc_irq_start;
 	}
-- 
1.7.7.6
