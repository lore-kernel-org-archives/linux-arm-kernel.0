From: afzal@ti.com (Afzal Mohammed)
Date: Thu, 4 Oct 2012 14:01:57 +0530
Subject: [PATCH] ARM: OMAP2+: gpmc: annotate exit sections properly
Message-ID: <1349339517-17882-1-git-send-email-afzal@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

compiler complained,
`gpmc_remove' referenced in section `.data' of arch/arm/mach-omap2/built-in.o: defined in discarded section `.exit.text' of arch/arm/mach-omap2/built-in.o

Annotate gpmc_remove function and dependents with __devexit.

Reported-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Afzal Mohammed <afzal@ti.com>
---

Hi,

Section mismatch occured due to my change,
"ARM: OMAP2+: gpmc: minimal driver support".
As this change is not yet in vanilla, SHA1 has not been
mentioned in commit log. Original change that introduced the
above mentioned warning has as of now swimmed only till
linux-omap and linux-next.

This has been generated against linux-next (next-20121003)

Regards
Afzal

 arch/arm/mach-omap2/gpmc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index 8ab1e1b..5ac5cf3 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -838,7 +838,7 @@ static int gpmc_setup_irq(void)
 	return request_irq(gpmc_irq, gpmc_handle_irq, 0, "gpmc", NULL);
 }
 
-static __exit int gpmc_free_irq(void)
+static __devexit int gpmc_free_irq(void)
 {
 	int i;
 
@@ -944,7 +944,7 @@ static __devinit int gpmc_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static __exit int gpmc_remove(struct platform_device *pdev)
+static __devexit int gpmc_remove(struct platform_device *pdev)
 {
 	gpmc_free_irq();
 	gpmc_mem_exit();
-- 
1.7.12
