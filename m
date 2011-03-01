From: w.sang@pengutronix.de (Wolfram Sang)
Date: Tue,  1 Mar 2011 10:21:51 +0100
Subject: [PATCH] arm: mxs: add irq_chip-name for GPIO IRQs
Message-ID: <1298971311-21937-1-git-send-email-w.sang@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Reported-by: Alexander Stein <alexander.stein@systec-electronic.com>
Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
---
 arch/arm/mach-mxs/gpio.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mxs/gpio.c b/arch/arm/mach-mxs/gpio.c
index 64848fa..5120ab5 100644
--- a/arch/arm/mach-mxs/gpio.c
+++ b/arch/arm/mach-mxs/gpio.c
@@ -182,6 +182,7 @@ static int mxs_gpio_set_wake_irq(u32 irq, u32 enable)
 }
 
 static struct irq_chip gpio_irq_chip = {
+	.name = "mxs gpio",
 	.ack = mxs_gpio_ack_irq,
 	.mask = mxs_gpio_mask_irq,
 	.unmask = mxs_gpio_unmask_irq,
-- 
1.7.2.3
