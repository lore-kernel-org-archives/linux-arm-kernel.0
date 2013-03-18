From: gerlando.falauto@keymile.com (Gerlando Falauto)
Date: Mon, 18 Mar 2013 15:00:55 +0100
Subject: [PATCH v3 9/9] gpio: mvebu: enable IRQ_GC_SEPARATE_MASK_REGISTERS
In-Reply-To: <1363615255-18200-1-git-send-email-gerlando.falauto@keymile.com>
References: <1363277430-21325-1-git-send-email-holger.brunck@keymile.com><1363615255-18200-1-git-send-email-gerlando.falauto@keymile.com>
Message-ID: <1363615255-18200-10-git-send-email-gerlando.falauto@keymile.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

enable handling of separate mask registers for all three SoC variants
handled by this driver.

Signed-off-by: Gerlando Falauto <gerlando.falauto@keymile.com>
---
 drivers/gpio/gpio-mvebu.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-mvebu.c b/drivers/gpio/gpio-mvebu.c
index 81384f4..c01376d 100644
--- a/drivers/gpio/gpio-mvebu.c
+++ b/drivers/gpio/gpio-mvebu.c
@@ -660,7 +660,8 @@ static int mvebu_gpio_probe(struct platform_device *pdev)
 	ct->handler = handle_edge_irq;
 	ct->chip.name = mvchip->chip.label;
 
-	irq_setup_generic_chip(gc, IRQ_MSK(ngpios), 0,
+	irq_setup_generic_chip(gc, IRQ_MSK(ngpios),
+			       IRQ_GC_SEPARATE_MASK_REGISTERS,
 			       IRQ_NOREQUEST, IRQ_LEVEL | IRQ_NOPROBE);
 
 	/* Setup irq domain on top of the generic chip. */
-- 
1.7.10.1
