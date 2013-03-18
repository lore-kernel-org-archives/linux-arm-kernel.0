From: gerlando.falauto@keymile.com (Gerlando Falauto)
Date: Mon, 18 Mar 2013 15:00:54 +0100
Subject: [PATCH v3 8/9] orion-gpio: enable IRQ_GC_SEPARATE_MASK_REGISTERS
In-Reply-To: <1363615255-18200-1-git-send-email-gerlando.falauto@keymile.com>
References: <1363277430-21325-1-git-send-email-holger.brunck@keymile.com><1363615255-18200-1-git-send-email-gerlando.falauto@keymile.com>
Message-ID: <1363615255-18200-9-git-send-email-gerlando.falauto@keymile.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

enable handling of separate mask registers for Orion SoC GPIOs,
fixing indeed the regression introduced by e59347a
"arm: orion: Use generic irq chip".

Reported-by: Joey Oravec <joravec@drewtech.com>
Signed-off-by: Simon Guinot <sguinot@lacie.com>
Signed-off-by: Holger Brunck <holger.brunck@keymile.com>
Signed-off-by: Gerlando Falauto <gerlando.falauto@keymile.com>
---
 arch/arm/plat-orion/gpio.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/plat-orion/gpio.c b/arch/arm/plat-orion/gpio.c
index c29ee7e..a4dc04a 100644
--- a/arch/arm/plat-orion/gpio.c
+++ b/arch/arm/plat-orion/gpio.c
@@ -522,7 +522,8 @@ void __init orion_gpio_init(struct device_node *np,
 	ct->handler = handle_edge_irq;
 	ct->chip.name = ochip->chip.label;
 
-	irq_setup_generic_chip(gc, IRQ_MSK(ngpio), IRQ_GC_INIT_MASK_CACHE,
+	irq_setup_generic_chip(gc, IRQ_MSK(ngpio), IRQ_GC_INIT_MASK_CACHE |
+			       IRQ_GC_SEPARATE_MASK_REGISTERS,
 			       IRQ_NOREQUEST, IRQ_LEVEL | IRQ_NOPROBE);
 
 	/* Setup irq domain on top of the generic chip. */
-- 
1.7.10.1
