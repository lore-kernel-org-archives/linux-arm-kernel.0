From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Fri, 14 Jun 2013 18:40:44 +0200
Subject: [PATCH 2/7] gpio: mvebu: use irq_get_trigger_type() to get IRQ flags
In-Reply-To: <1371228049-27080-1-git-send-email-javier.martinez@collabora.co.uk>
References: <1371228049-27080-1-git-send-email-javier.martinez@collabora.co.uk>
Message-ID: <1371228049-27080-3-git-send-email-javier.martinez@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use irq_get_trigger_type() to get the IRQ trigger type flags
instead calling irqd_get_trigger_type(irq_get_irq_data(irq))

Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
---
 drivers/gpio/gpio-mvebu.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/gpio/gpio-mvebu.c b/drivers/gpio/gpio-mvebu.c
index 3a4816a..80ad35e 100644
--- a/drivers/gpio/gpio-mvebu.c
+++ b/drivers/gpio/gpio-mvebu.c
@@ -457,7 +457,7 @@ static void mvebu_gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
 		if (!(cause & (1 << i)))
 			continue;
 
-		type = irqd_get_trigger_type(irq_get_irq_data(irq));
+		type = irq_get_trigger_type(irq);
 		if ((type & IRQ_TYPE_SENSE_MASK) == IRQ_TYPE_EDGE_BOTH) {
 			/* Swap polarity (race with GPIO line) */
 			u32 polarity;
-- 
1.7.7.6
