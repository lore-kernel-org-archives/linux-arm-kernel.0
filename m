From: michal.simek@xilinx.com (Michal Simek)
Date: Mon,  7 Aug 2017 13:02:01 +0200
Subject: [PATCH 8/8] gpio: zynq: Fix driver function parameters alignment
In-Reply-To: <cover.1502103715.git.michal.simek@xilinx.com>
References: <cover.1502103715.git.michal.simek@xilinx.com>
Message-ID: <67e187a3dbc2ef8b6bacd1b173ae9e91c18aa429.1502103715.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix function parameters alignment reported by checkpatch.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 drivers/gpio/gpio-zynq.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/gpio/gpio-zynq.c b/drivers/gpio/gpio-zynq.c
index 26653bf89e58..97b53e557c15 100644
--- a/drivers/gpio/gpio-zynq.c
+++ b/drivers/gpio/gpio-zynq.c
@@ -197,7 +197,7 @@ static inline void zynq_gpio_get_bank_pin(unsigned int pin_num,
 
 	for (bank = 0; bank < gpio->p_data->max_bank; bank++) {
 		if ((pin_num >= gpio->p_data->bank_min[bank]) &&
-			(pin_num <= gpio->p_data->bank_max[bank])) {
+		    (pin_num <= gpio->p_data->bank_max[bank])) {
 			*bank_num = bank;
 			*bank_pin_num = pin_num -
 					gpio->p_data->bank_min[bank];
@@ -313,7 +313,7 @@ static int zynq_gpio_dir_in(struct gpio_chip *chip, unsigned int pin)
 	 * as inputs.
 	 */
 	if (zynq_gpio_is_zynq(gpio) && bank_num == 0 &&
-		(bank_pin_num == 7 || bank_pin_num == 8))
+	    (bank_pin_num == 7 || bank_pin_num == 8))
 		return -EINVAL;
 
 	/* clear the bit in direction mode reg to set the pin as input */
@@ -514,13 +514,14 @@ static int zynq_gpio_set_irq_type(struct irq_data *irq_data, unsigned int type)
 	writel_relaxed(int_any,
 		       gpio->base_addr + ZYNQ_GPIO_INTANY_OFFSET(bank_num));
 
-	if (type & IRQ_TYPE_LEVEL_MASK) {
+	if (type & IRQ_TYPE_LEVEL_MASK)
 		irq_set_chip_handler_name_locked(irq_data,
-			&zynq_gpio_level_irqchip, handle_fasteoi_irq, NULL);
-	} else {
+						 &zynq_gpio_level_irqchip,
+						 handle_fasteoi_irq, NULL);
+	else
 		irq_set_chip_handler_name_locked(irq_data,
-			&zynq_gpio_edge_irqchip, handle_level_irq, NULL);
-	}
+						 &zynq_gpio_edge_irqchip,
+						 handle_level_irq, NULL);
 
 	return 0;
 }
@@ -772,7 +773,7 @@ static void zynq_gpio_free(struct gpio_chip *chip, unsigned int offset)
 static const struct dev_pm_ops zynq_gpio_dev_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(zynq_gpio_suspend, zynq_gpio_resume)
 	SET_RUNTIME_PM_OPS(zynq_gpio_runtime_suspend,
-			zynq_gpio_runtime_resume, NULL)
+			   zynq_gpio_runtime_resume, NULL)
 };
 
 static const struct zynq_platform_data zynqmp_gpio_def = {
-- 
1.9.1
