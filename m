From: afzal@ti.com (Afzal Mohammed)
Date: Mon, 8 Oct 2012 11:06:43 +0530
Subject: [PATCH v2 01/14] ARM: OMAP2+: gpmc: annotate exit sections properly
In-Reply-To: <cover.1349672877.git.afzal@ti.com>
References: <cover.1349672877.git.afzal@ti.com>
Message-ID: <a517afd9ed3be069b475caae791156b9c4663849.1349672877.git.afzal@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

compiler complained,
`gpmc_remove' referenced in section `.data' of arch/arm/mach-omap2/built-in.o: defined in discarded section `.exit.text' of arch/arm/mach-omap2/built-in.o

Annotate gpmc_remove function and dependents with __devexit.

Reported-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Afzal Mohammed <afzal@ti.com>
---
 arch/arm/mach-omap2/gpmc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index 2cbdcb9..163458d 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -886,7 +886,7 @@ static int gpmc_setup_irq(void)
 	return request_irq(gpmc_irq, gpmc_handle_irq, 0, "gpmc", NULL);
 }
 
-static __exit int gpmc_free_irq(void)
+static __devexit int gpmc_free_irq(void)
 {
 	int i;
 
@@ -992,7 +992,7 @@ static __devinit int gpmc_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static __exit int gpmc_remove(struct platform_device *pdev)
+static __devexit int gpmc_remove(struct platform_device *pdev)
 {
 	gpmc_free_irq();
 	gpmc_mem_exit();
-- 
1.7.12
