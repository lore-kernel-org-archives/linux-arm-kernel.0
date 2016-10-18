From: patrice.chotard@st.com (patrice.chotard at st.com)
Date: Tue, 18 Oct 2016 09:16:28 +0200
Subject: [PATCH] pinctrl: st: don't specify default interrupt trigger
Message-ID: <1476774988-13484-1-git-send-email-patrice.chotard@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Patrice Chotard <patrice.chotard@st.com>

Thanks to 332e99d5ae4 which now alerts of default
trigger usage when configuring interrupts.

Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
---
 drivers/pinctrl/pinctrl-st.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/pinctrl-st.c b/drivers/pinctrl/pinctrl-st.c
index 99da4cf..b7bb371 100644
--- a/drivers/pinctrl/pinctrl-st.c
+++ b/drivers/pinctrl/pinctrl-st.c
@@ -1512,7 +1512,7 @@ static int st_gpiolib_register_bank(struct st_pinctrl *info,
 	if (info->irqmux_base || gpio_irq > 0) {
 		err = gpiochip_irqchip_add(&bank->gpio_chip, &st_gpio_irqchip,
 					   0, handle_simple_irq,
-					   IRQ_TYPE_LEVEL_LOW);
+					   IRQ_TYPE_NONE);
 		if (err) {
 			gpiochip_remove(&bank->gpio_chip);
 			dev_info(dev, "could not add irqchip\n");
-- 
1.9.1
