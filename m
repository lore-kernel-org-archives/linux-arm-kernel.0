From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue,  8 Sep 2015 16:55:20 +0200
Subject: [PATCH] pinctrl: samsung: s3c24xx: fix syntax error
Message-ID: <1441724120-24870-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

?SYNTAX ERROR

irq_desc_get_irq_chip() does not exist. It should
be irq_desc_get_chip(). Tested by compiling
s3c2410_defconfig.

Cc: Thomas Gleixner <tglx@linutronix.de>
Reported-by: Paul Gortmaker <paul.gortmaker@windriver.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/pinctrl/samsung/pinctrl-s3c24xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/samsung/pinctrl-s3c24xx.c b/drivers/pinctrl/samsung/pinctrl-s3c24xx.c
index 019844d479bb..d168b39dd7fd 100644
--- a/drivers/pinctrl/samsung/pinctrl-s3c24xx.c
+++ b/drivers/pinctrl/samsung/pinctrl-s3c24xx.c
@@ -361,7 +361,7 @@ static inline void s3c24xx_demux_eint(struct irq_desc *desc,
 				      u32 offset, u32 range)
 {
 	struct s3c24xx_eint_data *data = irq_desc_get_handler_data(desc);
-	struct irq_chip *chip = irq_desc_get_irq_chip(desc);
+	struct irq_chip *chip = irq_desc_get_chip(desc);
 	struct samsung_pinctrl_drv_data *d = data->drvdata;
 	unsigned int pend, mask;
 
-- 
2.4.3
