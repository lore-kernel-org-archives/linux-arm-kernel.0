From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Thu, 11 Sep 2014 16:41:51 +0200
Subject: [PATCH] irqchip: atmel-aic5: sama5d3 has 48 IRQs
Message-ID: <1410446511-29477-1-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The FUSE and RAM controllers don't have any connected IRQs, reducing the number
of IRQs to 48.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/irqchip/irq-atmel-aic5.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-atmel-aic5.c b/drivers/irqchip/irq-atmel-aic5.c
index 04fe2c1b5178..dc7d98607a89 100644
--- a/drivers/irqchip/irq-atmel-aic5.c
+++ b/drivers/irqchip/irq-atmel-aic5.c
@@ -341,7 +341,7 @@ static int __init aic5_of_init(struct device_node *node,
 	return 0;
 }
 
-#define NR_SAMA5D3_IRQS		50
+#define NR_SAMA5D3_IRQS		48
 
 static int __init sama5d3_aic5_of_init(struct device_node *node,
 				       struct device_node *parent)
-- 
1.9.1
