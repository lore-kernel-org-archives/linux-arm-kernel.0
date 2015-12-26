From: eric@anholt.net (Eric Anholt)
Date: Sat, 26 Dec 2015 13:47:24 -0800
Subject: [PATCH 4/4] irqchip: bcm2836: make code more readable
In-Reply-To: <1451166444-11044-1-git-send-email-eric@anholt.net>
References: <1451166444-11044-1-git-send-email-eric@anholt.net>
Message-ID: <1451166444-11044-5-git-send-email-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andrea Merello <andrea.merello@gmail.com>

Avoid using hardcoded magics. We have a #define for this number.
No functional changes.

Signed-off-by: Andrea Merello <andrea.merello@gmail.com>
Reviewed-by: Eric Anholt <eric@anholt.net>
Signed-off-by: Eric Anholt <eric@anholt.net>
---
 drivers/irqchip/irq-bcm2836.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-bcm2836.c b/drivers/irqchip/irq-bcm2836.c
index bb8f234..963065a 100644
--- a/drivers/irqchip/irq-bcm2836.c
+++ b/drivers/irqchip/irq-bcm2836.c
@@ -167,7 +167,7 @@ __exception_irq_entry bcm2836_arm_irqchip_handle_irq(struct pt_regs *regs)
 	u32 stat;
 
 	stat = readl_relaxed(intc.base + LOCAL_IRQ_PENDING0 + 4 * cpu);
-	if (stat & 0x10) {
+	if (stat & BIT(LOCAL_IRQ_MAILBOX0)) {
 #ifdef CONFIG_SMP
 		void __iomem *mailbox0 = (intc.base +
 					  LOCAL_MAILBOX0_CLR0 + 16 * cpu);
-- 
2.6.2
