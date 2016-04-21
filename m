From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Thu, 21 Apr 2016 15:13:19 +0900
Subject: [PATCH] serial: 8250_uniphier: add "\n" at the end of error log
Message-ID: <1461219199-9059-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Just in case.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/tty/serial/8250/8250_uniphier.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_uniphier.c b/drivers/tty/serial/8250/8250_uniphier.c
index 1b7bd26..efd1f9c 100644
--- a/drivers/tty/serial/8250/8250_uniphier.c
+++ b/drivers/tty/serial/8250/8250_uniphier.c
@@ -209,7 +209,7 @@ static int uniphier_uart_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(dev, "failed to get IRQ number");
+		dev_err(dev, "failed to get IRQ number\n");
 		return irq;
 	}
 
-- 
1.9.1
