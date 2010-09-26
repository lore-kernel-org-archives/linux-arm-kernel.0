From: mike@compulab.co.il (Mike Rapoport)
Date: Sun, 26 Sep 2010 14:37:49 +0200
Subject: [PATCH] [ARM] pxa/cm-x2xx: remove duplicate call to pxa27x_init_irq
Message-ID: <1285504669-24341-1-git-send-email-mike@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Mike Rapoport <mike@compulab.co.il>
---
 arch/arm/mach-pxa/cm-x2xx.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-pxa/cm-x2xx.c b/arch/arm/mach-pxa/cm-x2xx.c
index bff6e78..ec12a48 100644
--- a/arch/arm/mach-pxa/cm-x2xx.c
+++ b/arch/arm/mach-pxa/cm-x2xx.c
@@ -473,8 +473,6 @@ static void __init cmx2xx_init(void)
 
 static void __init cmx2xx_init_irq(void)
 {
-	pxa27x_init_irq();
-
 	if (cpu_is_pxa25x()) {
 		pxa25x_init_irq();
 		cmx2xx_pci_init_irq(CMX255_GPIO_IT8152_IRQ);
-- 
1.6.4.4
