From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu,  1 Nov 2012 22:02:50 -0600
Subject: [PATCH] irqchip: irq-bcm2835: Add terminating entry for of_device_id
 table
Message-ID: <1351828970-15081-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Axel Lin <axel.lin@ingics.com>

The of_device_id table is supposed to be zero-terminated.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Stephen Warren <swarren@wwwdotorg.org>
---
This is a fix for v3.7.

 drivers/irqchip/irq-bcm2835.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-bcm2835.c b/drivers/irqchip/irq-bcm2835.c
index dc670cc..16c78f1 100644
--- a/drivers/irqchip/irq-bcm2835.c
+++ b/drivers/irqchip/irq-bcm2835.c
@@ -168,7 +168,8 @@ static int __init armctrl_of_init(struct device_node *node,
 }
 
 static struct of_device_id irq_of_match[] __initconst = {
-	{ .compatible = "brcm,bcm2835-armctrl-ic", .data = armctrl_of_init }
+	{ .compatible = "brcm,bcm2835-armctrl-ic", .data = armctrl_of_init },
+	{ }
 };
 
 void __init bcm2835_init_irq(void)
-- 
1.7.9.5
