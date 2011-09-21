From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Wed, 21 Sep 2011 13:30:45 +0200
Subject: [PATCH 11/11 v2] ARM: at91/gpio: fix display of number of irq setuped
In-Reply-To: <20110921112830.GP24966@game.jcrosoft.org>
References: <20110921112830.GP24966@game.jcrosoft.org>
Message-ID: <1316604645-22599-11-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Reviewed-by: Ryan Mallon <rmallon@gmail.com>
---
V2 update commit log

Best Regards,
J. arch/arm/mach-at91/gpio.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-at91/gpio.c b/arch/arm/mach-at91/gpio.c
index e709406..743f668 100644
--- a/arch/arm/mach-at91/gpio.c
+++ b/arch/arm/mach-at91/gpio.c
@@ -528,7 +528,7 @@ void __init at91_gpio_irq_setup(void)
 		irq_set_chip_data(id, this);
 		irq_set_chained_handler(id, gpio_irq_handler);
 	}
-	pr_info("AT91: %d gpio irqs in %d banks\n", irq, gpio_banks);
+	pr_info("AT91: %d gpio irqs in %d banks\n", irq - gpio_to_irq(0), gpio_banks);
 }
 
 /* gpiolib support */
-- 
1.7.6.3
