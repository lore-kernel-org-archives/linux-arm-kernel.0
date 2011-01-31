From: alexander.stein@systec-electronic.com (Alexander Stein)
Date: Mon, 31 Jan 2011 17:00:24 +0100
Subject: [PATCH] plat-mxc: Provide irq_chip name for GPIO IRQs
Message-ID: <1296489624-21355-1-git-send-email-alexander.stein@systec-electronic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>
---
 arch/arm/plat-mxc/gpio.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-mxc/gpio.c b/arch/arm/plat-mxc/gpio.c
index d17b3c9..e396df8 100644
--- a/arch/arm/plat-mxc/gpio.c
+++ b/arch/arm/plat-mxc/gpio.c
@@ -233,6 +233,7 @@ static int gpio_set_wake_irq(struct irq_data *d, u32 enable)
 }
 
 static struct irq_chip gpio_irq_chip = {
+	.name = "GPIO",
 	.irq_ack = gpio_ack_irq,
 	.irq_mask = gpio_mask_irq,
 	.irq_unmask = gpio_unmask_irq,
-- 
1.7.3.4
