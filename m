From: arnd@arndb.de (Arnd Bergmann)
Date: Thu,  2 Nov 2017 15:29:13 +0100
Subject: [PATCH] pinctrl: armada-37xx: remove unused variable
Message-ID: <20171102142932.774199-1-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A cleanup left behind a temporary variable that is now unused:

drivers/pinctrl/mvebu/pinctrl-armada-37xx.c: In function 'armada_37xx_irq_startup':
drivers/pinctrl/mvebu/pinctrl-armada-37xx.c:693:20: error: unused variable 'chip' [-Werror=unused-variable]

This removes the declarations as well.

Fixes: 3ee9e605caea ("pinctrl: armada-37xx: Stop using struct gpio_chip.irq_base")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/pinctrl/mvebu/pinctrl-armada-37xx.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c b/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c
index 68a4af12fb0a..2149f8d955cf 100644
--- a/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c
+++ b/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c
@@ -690,8 +690,6 @@ static void armada_37xx_irq_handler(struct irq_desc *desc)
 
 static unsigned int armada_37xx_irq_startup(struct irq_data *d)
 {
-	struct gpio_chip *chip = irq_data_get_irq_chip_data(d);
-
 	/*
 	 * The mask field is a "precomputed bitmask for accessing the
 	 * chip registers" which was introduced for the generic
-- 
2.9.0
