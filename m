From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue,  5 Jan 2010 16:05:15 +0000
Subject: [PATCH 1/2] mx31ads: Provide a name for EXPIO interrupt chip
Message-ID: <1262707516-20938-1-git-send-email-broonie@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This makes it a bit more obvious in genirq diagnostics that they
aren't handled by the i.MX interrupt controller.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 arch/arm/mach-mx3/mx31ads.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx3/mx31ads.c b/arch/arm/mach-mx3/mx31ads.c
index a579f4c..c486c2f 100644
--- a/arch/arm/mach-mx3/mx31ads.c
+++ b/arch/arm/mach-mx3/mx31ads.c
@@ -173,6 +173,7 @@ static void expio_unmask_irq(u32 irq)
 }
 
 static struct irq_chip expio_irq_chip = {
+	.name = "EXPIO(CPLD)",
 	.ack = expio_ack_irq,
 	.mask = expio_mask_irq,
 	.unmask = expio_unmask_irq,
-- 
1.6.5.7
