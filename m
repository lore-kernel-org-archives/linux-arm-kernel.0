From: robherring2@gmail.com (Rob Herring)
Date: Mon, 12 May 2014 19:29:51 -0500
Subject: [PATCH 5/7] irqchip: s3c24xx: fix function type for IRQCHIP_OF_DECLARE
In-Reply-To: <1399940993-1773-1-git-send-email-robherring2@gmail.com>
References: <1399940993-1773-1-git-send-email-robherring2@gmail.com>
Message-ID: <1399940993-1773-6-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <robh@kernel.org>

Adding function type checking to IRQCHIP_OF_DECLARE found a type mismatch
with s3c2410_init_intc_of and s3c2416_init_intc_of. The function only takes
the 1st 2 parameters.

Signed-off-by: Rob Herring <robh@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/irqchip/irq-s3c24xx.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-s3c24xx.c b/drivers/irqchip/irq-s3c24xx.c
index bbcc944..78a6acc 100644
--- a/drivers/irqchip/irq-s3c24xx.c
+++ b/drivers/irqchip/irq-s3c24xx.c
@@ -1323,8 +1323,7 @@ static struct s3c24xx_irq_of_ctrl s3c2410_ctrl[] = {
 };
 
 int __init s3c2410_init_intc_of(struct device_node *np,
-			struct device_node *interrupt_parent,
-			struct s3c24xx_irq_of_ctrl *ctrl, int num_ctrl)
+			struct device_node *interrupt_parent)
 {
 	return s3c_init_intc_of(np, interrupt_parent,
 				s3c2410_ctrl, ARRAY_SIZE(s3c2410_ctrl));
@@ -1346,8 +1345,7 @@ static struct s3c24xx_irq_of_ctrl s3c2416_ctrl[] = {
 };
 
 int __init s3c2416_init_intc_of(struct device_node *np,
-			struct device_node *interrupt_parent,
-			struct s3c24xx_irq_of_ctrl *ctrl, int num_ctrl)
+			struct device_node *interrupt_parent)
 {
 	return s3c_init_intc_of(np, interrupt_parent,
 				s3c2416_ctrl, ARRAY_SIZE(s3c2416_ctrl));
-- 
1.9.1
