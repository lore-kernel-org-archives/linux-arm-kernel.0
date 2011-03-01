From: alexander.stein@systec-electronic.com (Alexander Stein)
Date: Tue,  1 Mar 2011 10:23:27 +0100
Subject: [PATCH v2] plat-mxc: Provide irq_chip name for GPIO IRQs
Message-ID: <1298971407-17069-1-git-send-email-alexander.stein@systec-electronic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Acked-by: Wolfram Sang <w.sang@pengutronix.de>
Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>
---
Changes in v2:
* Changed name to a more specific name

 arch/arm/plat-mxc/gpio.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-mxc/gpio.c b/arch/arm/plat-mxc/gpio.c
index d17b3c9..1d7d6bf 100644
--- a/arch/arm/plat-mxc/gpio.c
+++ b/arch/arm/plat-mxc/gpio.c
@@ -233,6 +233,7 @@ static int gpio_set_wake_irq(struct irq_data *d, u32 enable)
 }
 
 static struct irq_chip gpio_irq_chip = {
+	.name = "i.MX GPIO",
 	.irq_ack = gpio_ack_irq,
 	.irq_mask = gpio_mask_irq,
 	.irq_unmask = gpio_unmask_irq,
-- 
1.7.3.4
