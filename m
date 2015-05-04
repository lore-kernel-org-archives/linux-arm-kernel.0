From: michal.simek@xilinx.com (Michal Simek)
Date: Mon,  4 May 2015 16:37:16 +0200
Subject: [PATCH] gpio: xilinx: Fix kernel-doc warnings
Message-ID: <6680ac72661b4be9c4de4a3e2589a0b466fdda74.1430750234.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix kernel-doc format:
- Add gpio-width description
- Remove additional "inited" variable description
- Add return value description - xgpio_remove

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 drivers/gpio/gpio-xilinx.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-xilinx.c b/drivers/gpio/gpio-xilinx.c
index 61243d177740..77fe5d3cb105 100644
--- a/drivers/gpio/gpio-xilinx.c
+++ b/drivers/gpio/gpio-xilinx.c
@@ -41,10 +41,10 @@
 /**
  * struct xgpio_instance - Stores information about GPIO device
  * @mmchip: OF GPIO chip for memory mapped banks
+ * @gpio_width: GPIO width for every channel
  * @gpio_state: GPIO state shadow register
  * @gpio_dir: GPIO direction shadow register
  * @gpio_lock: Lock used for synchronization
- * @inited: True if the port has been inited
  */
 struct xgpio_instance {
 	struct of_mm_gpio_chip mmchip;
@@ -231,6 +231,8 @@ static void xgpio_save_regs(struct of_mm_gpio_chip *mm_gc)
  * @pdev: pointer to the platform device
  *
  * This function remove gpiochips and frees all the allocated resources.
+ *
+ * Return: 0 always
  */
 static int xgpio_remove(struct platform_device *pdev)
 {
-- 
2.3.5
