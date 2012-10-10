From: linus.walleij@stericsson.com (Linus Walleij)
Date: Wed, 10 Oct 2012 14:38:09 +0200
Subject: [PATCH 2/5] ARM: plat-nomadik: move NMK_GPIO_PER_CHIP into
 gpio-nomadik.h
Message-ID: <1349872689-31210-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Patrice Chotard <patrice.chotard@stericsson.com>

Move NMK_GPIO_PER_CHIP to gpio-nomadik.h and define it with a
shift operator.

Signed-off-by: Patrice Chotard <patrice.chotard@stericsson.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/plat-nomadik/include/plat/gpio-nomadik.h | 3 +++
 drivers/pinctrl/pinctrl-nomadik.c                 | 2 --
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-nomadik/include/plat/gpio-nomadik.h b/arch/arm/plat-nomadik/include/plat/gpio-nomadik.h
index cf81111..a749994 100644
--- a/arch/arm/plat-nomadik/include/plat/gpio-nomadik.h
+++ b/arch/arm/plat-nomadik/include/plat/gpio-nomadik.h
@@ -18,6 +18,9 @@
  * the "gpio" namespace for generic and cross-machine functions
  */
 
+#define GPIO_BLOCK_SHIFT 5
+#define NMK_GPIO_PER_CHIP (1 << GPIO_BLOCK_SHIFT)
+
 /* Register in the logic block */
 #define NMK_GPIO_DAT	0x00
 #define NMK_GPIO_DATS	0x04
diff --git a/drivers/pinctrl/pinctrl-nomadik.c b/drivers/pinctrl/pinctrl-nomadik.c
index fec9c30..334cd2f 100644
--- a/drivers/pinctrl/pinctrl-nomadik.c
+++ b/drivers/pinctrl/pinctrl-nomadik.c
@@ -47,8 +47,6 @@
  * Symbols in this file are called "nmk_gpio" for "nomadik gpio"
  */
 
-#define NMK_GPIO_PER_CHIP	32
-
 struct nmk_gpio_chip {
 	struct gpio_chip chip;
 	struct irq_domain *domain;
-- 
1.7.11.3
