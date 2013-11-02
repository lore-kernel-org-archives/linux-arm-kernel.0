From: prabhakar.csengg@gmail.com (Lad, Prabhakar)
Date: Sat,  2 Nov 2013 21:09:30 +0530
Subject: [PATCH v4 1/6] gpio: davinci: Fixed a check for unbanked gpio
In-Reply-To: <1383406775-14902-1-git-send-email-prabhakar.csenng@gmail.com>
References: <1383406775-14902-1-git-send-email-prabhakar.csenng@gmail.com>
Message-ID: <1383406775-14902-2-git-send-email-prabhakar.csenng@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>

This patch fixes the check for the offset in
gpio_to_irq_unbanked() function.

Signed-off-by: Lad, Prabhakar <prabhakar.csengg@gmail.com>
---
 drivers/gpio/gpio-davinci.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-davinci.c b/drivers/gpio/gpio-davinci.c
index 8847adf..6c90cfb 100644
--- a/drivers/gpio/gpio-davinci.c
+++ b/drivers/gpio/gpio-davinci.c
@@ -327,7 +327,7 @@ static int gpio_to_irq_unbanked(struct gpio_chip *chip, unsigned offset)
 	 * NOTE:  we assume for now that only irqs in the first gpio_chip
 	 * can provide direct-mapped IRQs to AINTC (up to 32 GPIOs).
 	 */
-	if (offset < d->irq_base)
+	if (offset < d->gpio_unbanked)
 		return d->gpio_irq + offset;
 	else
 		return -ENODEV;
-- 
1.7.9.5
