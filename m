From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Sun, 16 Oct 2011 21:09:20 +0200
Subject: [PATCH 11/11] ARM: at91/gpio: fix display of number of irq setuped
In-Reply-To: <20111016190528.GI1459@game.jcrosoft.org>
References: <20111016190528.GI1459@game.jcrosoft.org>
Message-ID: <1318792160-23279-11-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Reviewed-by: Ryan Mallon <rmallon@gmail.com>
---
 arch/arm/mach-at91/gpio.c |    2 +-
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
1.7.7
