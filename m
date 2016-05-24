From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 24 May 2016 14:41:10 +0200
Subject: [PATCH] pinctrl: nomadik: fix inversion of gpio direction
Message-ID: <1464093670-29370-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The input/output directions were inversed on the GPIO direction
read function. Loose a ! and it is correct.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/pinctrl/nomadik/pinctrl-nomadik.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/nomadik/pinctrl-nomadik.c b/drivers/pinctrl/nomadik/pinctrl-nomadik.c
index ccbfc325c778..38faceff2f08 100644
--- a/drivers/pinctrl/nomadik/pinctrl-nomadik.c
+++ b/drivers/pinctrl/nomadik/pinctrl-nomadik.c
@@ -854,7 +854,7 @@ static int nmk_gpio_get_dir(struct gpio_chip *chip, unsigned offset)
 
 	clk_enable(nmk_chip->clk);
 
-	dir = !!(readl(nmk_chip->addr + NMK_GPIO_DIR) & BIT(offset));
+	dir = !(readl(nmk_chip->addr + NMK_GPIO_DIR) & BIT(offset));
 
 	clk_disable(nmk_chip->clk);
 
-- 
2.4.11
