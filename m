From: colin.king@canonical.com (Colin King)
Date: Sat, 28 Feb 2015 20:22:27 +0000
Subject: [PATCH] pinctrl: sirf: fix typo in kernel warning on a bad interruot
Message-ID: <1425154947-7855-1-git-send-email-colin.king@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Colin Ian King <colin.king@canonical.com>

Fix typo, "flaged" -> "flagged"

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/pinctrl/sirf/pinctrl-sirf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/sirf/pinctrl-sirf.c b/drivers/pinctrl/sirf/pinctrl-sirf.c
index 2a1f072..abc5c47 100644
--- a/drivers/pinctrl/sirf/pinctrl-sirf.c
+++ b/drivers/pinctrl/sirf/pinctrl-sirf.c
@@ -568,7 +568,7 @@ static void sirfsoc_gpio_handle_irq(unsigned int irq, struct irq_desc *desc)
 	status = readl(sgpio->chip.regs + SIRFSOC_GPIO_INT_STATUS(bank->id));
 	if (!status) {
 		printk(KERN_WARNING
-			"%s: gpio id %d status %#x no interrupt is flaged\n",
+			"%s: gpio id %d status %#x no interrupt is flagged\n",
 			__func__, bank->id, status);
 		handle_bad_irq(irq, desc);
 		return;
-- 
2.1.4
