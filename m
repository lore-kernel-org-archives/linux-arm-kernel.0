From: linus.walleij@stericsson.com (Linus Walleij)
Date: Wed, 30 Jan 2013 20:39:59 +0100
Subject: [PATCH 1/4] pinctrl/abx500: use the BIT() macro where appropriate
Message-ID: <1359574799-15627-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Lee Jones <lee.jones@linaro.org>

The BIT() macro provides a simple and easy to read way of
obtaining bit offsets into things like masks and hardware
registers. In this patch we're simply replacing all
instances of '1 << x' with 'bit(x)'.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/pinctrl/pinctrl-abx500.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/pinctrl-abx500.c b/drivers/pinctrl/pinctrl-abx500.c
index 7046aef..539c9bb 100644
--- a/drivers/pinctrl/pinctrl-abx500.c
+++ b/drivers/pinctrl/pinctrl-abx500.c
@@ -157,7 +157,7 @@ static int abx500_gpio_set_bits(struct gpio_chip *chip, u8 reg,
 
 	reg += offset / 8;
 	ret = abx500_mask_and_set_register_interruptible(pct->dev,
-				AB8500_MISC, reg, 1 << pos, val << pos);
+				AB8500_MISC, reg, BIT(pos), val << pos);
 	if (ret < 0)
 		dev_err(pct->dev, "%s write failed\n", __func__);
 	return ret;
-- 
1.7.11.3
