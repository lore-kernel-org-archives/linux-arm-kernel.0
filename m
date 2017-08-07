From: michal.simek@xilinx.com (Michal Simek)
Date: Mon,  7 Aug 2017 13:01:59 +0200
Subject: [PATCH 6/8] gpio: zynq: Fix empty lines in driver
In-Reply-To: <cover.1502103715.git.michal.simek@xilinx.com>
References: <cover.1502103715.git.michal.simek@xilinx.com>
Message-ID: <35852b459f0001981e0376c8fade8a498fd6e66e.1502103715.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove one additional line and add two new. All are reported by checkpatch.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>

empty

---

 drivers/gpio/gpio-zynq.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-zynq.c b/drivers/gpio/gpio-zynq.c
index 573bd8303d5d..2d9f27e34d31 100644
--- a/drivers/gpio/gpio-zynq.c
+++ b/drivers/gpio/gpio-zynq.c
@@ -63,7 +63,6 @@
 #define ZYNQ_GPIO_BANK5_PIN_MAX(str)	(ZYNQ_GPIO_BANK5_PIN_MIN(str) + \
 					ZYNQ##str##_GPIO_BANK5_NGPIO - 1)
 
-
 /* Register offsets for the GPIO device */
 /* LSW Mask & Data -WO */
 #define ZYNQ_GPIO_DATA_LSW_OFFSET(BANK)	(0x000 + (8 * BANK))
@@ -115,6 +114,7 @@ struct gpio_regs {
 	u32 int_polarity[ZYNQMP_GPIO_MAX_BANK];
 	u32 int_any[ZYNQMP_GPIO_MAX_BANK];
 };
+
 /**
  * struct zynq_gpio - gpio device private data structure
  * @chip:	instance of the gpio_chip
@@ -700,6 +700,7 @@ static void zynq_gpio_restore_context(struct zynq_gpio *gpio)
 			       ZYNQ_GPIO_INTANY_OFFSET(bank_num));
 	}
 }
+
 static int __maybe_unused zynq_gpio_suspend(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
-- 
1.9.1
