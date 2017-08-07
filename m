From: michal.simek@xilinx.com (Michal Simek)
Date: Mon,  7 Aug 2017 13:02:00 +0200
Subject: [PATCH 7/8] gpio: zynq: Fix warnings in the driver
In-Reply-To: <cover.1502103715.git.michal.simek@xilinx.com>
References: <cover.1502103715.git.michal.simek@xilinx.com>
Message-ID: <58146421d2af970cedef5fd4b9e1b2d07bd13d6e.1502103715.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nava kishore Manne <nava.manne@xilinx.com>

This patch fixes the below warning
	-->Block comments should align the * on each line.
	-->suspect code indent for conditional statements.
	-->Prefer 'unsigned int' to bare use of 'unsigned'

Signed-off-by: Nava kishore Manne <navam@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 drivers/gpio/gpio-zynq.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpio/gpio-zynq.c b/drivers/gpio/gpio-zynq.c
index 2d9f27e34d31..26653bf89e58 100644
--- a/drivers/gpio/gpio-zynq.c
+++ b/drivers/gpio/gpio-zynq.c
@@ -198,10 +198,10 @@ static inline void zynq_gpio_get_bank_pin(unsigned int pin_num,
 	for (bank = 0; bank < gpio->p_data->max_bank; bank++) {
 		if ((pin_num >= gpio->p_data->bank_min[bank]) &&
 			(pin_num <= gpio->p_data->bank_max[bank])) {
-				*bank_num = bank;
-				*bank_pin_num = pin_num -
-						gpio->p_data->bank_min[bank];
-				return;
+			*bank_num = bank;
+			*bank_pin_num = pin_num -
+					gpio->p_data->bank_min[bank];
+			return;
 		}
 	}
 
@@ -751,7 +751,7 @@ static int __maybe_unused zynq_gpio_runtime_resume(struct device *dev)
 	return clk_prepare_enable(gpio->clk);
 }
 
-static int zynq_gpio_request(struct gpio_chip *chip, unsigned offset)
+static int zynq_gpio_request(struct gpio_chip *chip, unsigned int offset)
 {
 	int ret;
 
@@ -764,7 +764,7 @@ static int zynq_gpio_request(struct gpio_chip *chip, unsigned offset)
 	return ret < 0 ? ret : 0;
 }
 
-static void zynq_gpio_free(struct gpio_chip *chip, unsigned offset)
+static void zynq_gpio_free(struct gpio_chip *chip, unsigned int offset)
 {
 	pm_runtime_put(chip->parent);
 }
-- 
1.9.1
