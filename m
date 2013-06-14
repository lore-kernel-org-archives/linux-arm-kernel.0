From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Fri, 14 Jun 2013 18:40:47 +0200
Subject: [PATCH 5/7] arm: orion: use irq_get_trigger_type() to get IRQ flags
In-Reply-To: <1371228049-27080-1-git-send-email-javier.martinez@collabora.co.uk>
References: <1371228049-27080-1-git-send-email-javier.martinez@collabora.co.uk>
Message-ID: <1371228049-27080-6-git-send-email-javier.martinez@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use irq_get_trigger_type() to get the IRQ trigger type flags
instead calling irqd_get_trigger_type(irq_get_irq_data(irq))

Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
---
 arch/arm/plat-orion/gpio.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-orion/gpio.c b/arch/arm/plat-orion/gpio.c
index 249fe63..6816192 100644
--- a/arch/arm/plat-orion/gpio.c
+++ b/arch/arm/plat-orion/gpio.c
@@ -426,7 +426,7 @@ static void gpio_irq_handler(unsigned irq, struct irq_desc *desc)
 		if (!(cause & (1 << i)))
 			continue;
 
-		type = irqd_get_trigger_type(irq_get_irq_data(irq));
+		type = irq_get_trigger_type(irq);
 		if ((type & IRQ_TYPE_SENSE_MASK) == IRQ_TYPE_EDGE_BOTH) {
 			/* Swap polarity (race with GPIO line) */
 			u32 polarity;
-- 
1.7.7.6
