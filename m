From: ludovic.Barre@st.com (Ludovic Barre)
Date: Thu, 26 Apr 2018 18:18:25 +0200
Subject: [PATCH 02/11] irqchip: stm32: checkpatch fix
In-Reply-To: <1524759514-12392-1-git-send-email-ludovic.Barre@st.com>
References: <1524759514-12392-1-git-send-email-ludovic.Barre@st.com>
Message-ID: <1524759514-12392-3-git-send-email-ludovic.Barre@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ludovic Barre <ludovic.barre@st.com>

-WARNING: struct irq_domain_ops should normally be const
-CHECK: Alignment should match open parenthesis

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 drivers/irqchip/irq-stm32-exti.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-stm32-exti.c b/drivers/irqchip/irq-stm32-exti.c
index 8013a87..b91a8c2 100644
--- a/drivers/irqchip/irq-stm32-exti.c
+++ b/drivers/irqchip/irq-stm32-exti.c
@@ -186,7 +186,7 @@ static void stm32_exti_free(struct irq_domain *d, unsigned int virq,
 	irq_domain_reset_irq_data(data);
 }
 
-struct irq_domain_ops irq_exti_domain_ops = {
+static const struct irq_domain_ops irq_exti_domain_ops = {
 	.map	= irq_map_generic_chip,
 	.alloc  = stm32_exti_alloc,
 	.free	= stm32_exti_free,
@@ -221,7 +221,7 @@ __init stm32_exti_init(const struct stm32_exti_bank **stm32_exti_banks,
 					     handle_edge_irq, clr, 0, 0);
 	if (ret) {
 		pr_err("%pOF: Could not allocate generic interrupt chip.\n",
-			node);
+		       node);
 		goto out_free_domain;
 	}
 
-- 
2.7.4
