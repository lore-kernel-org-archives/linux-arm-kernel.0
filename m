From: michal.simek@xilinx.com (Michal Simek)
Date: Mon,  7 Aug 2017 13:01:58 +0200
Subject: [PATCH 5/8] gpio: zynq: Fix kernel doc warnings
In-Reply-To: <cover.1502103715.git.michal.simek@xilinx.com>
References: <cover.1502103715.git.michal.simek@xilinx.com>
Message-ID: <8659e6580b6738a973a161392ba7e03735837c15.1502103715.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nava kishore Manne <nava.manne@xilinx.com>

This patch fixes the kernel doc warnings in the driver.

Signed-off-by: Nava kishore Manne <navam@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 drivers/gpio/gpio-zynq.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-zynq.c b/drivers/gpio/gpio-zynq.c
index 1ab0f8c991b6..573bd8303d5d 100644
--- a/drivers/gpio/gpio-zynq.c
+++ b/drivers/gpio/gpio-zynq.c
@@ -136,11 +136,12 @@ struct zynq_gpio {
 /**
  * struct zynq_platform_data -  zynq gpio platform data structure
  * @label:	string to store in gpio->label
+ * @quirks:	Flags is used to identify the platform
  * @ngpio:	max number of gpio pins
  * @max_bank:	maximum number of gpio banks
  * @bank_min:	this array represents bank's min pin
  * @bank_max:	this array represents bank's max pin
-*/
+ */
 struct zynq_platform_data {
 	const char *label;
 	u32 quirks;
@@ -183,6 +184,7 @@ static int gpio_data_ro_bug(struct zynq_gpio *gpio)
  *		pin
  * @bank_pin_num: an output parameter used to return pin number within a bank
  *		  for the given gpio pin
+ * @gpio:	gpio device data structure
  *
  * Returns the bank number and pin offset within the bank.
  */
@@ -614,7 +616,6 @@ static void zynq_gpio_handle_bank_irq(struct zynq_gpio *gpio,
 
 /**
  * zynq_gpio_irqhandler - IRQ handler for the gpio banks of a gpio device
- * @irq:	irq number of the gpio bank where interrupt has occurred
  * @desc:	irq descriptor instance of the 'irq'
  *
  * This function reads the Interrupt Status Register of each bank to get the
-- 
1.9.1
