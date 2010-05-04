From: rabin.vincent@stericsson.com (Rabin Vincent)
Date: Tue, 4 May 2010 09:23:12 +0530
Subject: [PATCH 4/4] nomadik-gpio: set a default trigger for interrupts
In-Reply-To: <1272945192-23742-1-git-send-email-rabin.vincent@stericsson.com>
References: <1272945192-23742-1-git-send-email-rabin.vincent@stericsson.com>
Message-ID: <1272945192-23742-4-git-send-email-rabin.vincent@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Set a default trigger type for interrupts, otherwise if request_irq is
called without specifiying a trigger type, the interrupt will not
actually be enabled.

Acked-by: Alessandro Rubini <rubini@unipv.it>
Acked-by: Linus Walleij <linus.walleij@stericsson.com>
Signed-off-by: Rabin Vincent <rabin.vincent@stericsson.com>
---
 arch/arm/plat-nomadik/gpio.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-nomadik/gpio.c b/arch/arm/plat-nomadik/gpio.c
index f4c680c..15d247a 100644
--- a/arch/arm/plat-nomadik/gpio.c
+++ b/arch/arm/plat-nomadik/gpio.c
@@ -246,6 +246,7 @@ static int nmk_gpio_init_irq(struct nmk_gpio_chip *nmk_chip)
 		set_irq_handler(i, handle_edge_irq);
 		set_irq_flags(i, IRQF_VALID);
 		set_irq_chip_data(i, nmk_chip);
+		set_irq_type(i, IRQ_TYPE_EDGE_FALLING);
 	}
 	set_irq_chained_handler(nmk_chip->parent_irq, nmk_gpio_irq_handler);
 	set_irq_data(nmk_chip->parent_irq, nmk_chip);
-- 
1.7.0
