From: jonas.gorski@gmail.com (Jonas Gorski)
Date: Wed, 20 Sep 2017 13:14:03 +0200
Subject: [PATCH V2 3/8] tty/bcm63xx_uart: use refclk for the expected clock
 name
In-Reply-To: <20170920111408.29711-1-jonas.gorski@gmail.com>
References: <20170920111408.29711-1-jonas.gorski@gmail.com>
Message-ID: <20170920111408.29711-4-jonas.gorski@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We now have the clock available under refclk, so use that.

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
 drivers/tty/serial/bcm63xx_uart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/bcm63xx_uart.c b/drivers/tty/serial/bcm63xx_uart.c
index 583c9a0c7ecc..a2b9376ec861 100644
--- a/drivers/tty/serial/bcm63xx_uart.c
+++ b/drivers/tty/serial/bcm63xx_uart.c
@@ -842,7 +842,7 @@ static int bcm_uart_probe(struct platform_device *pdev)
 		return -ENODEV;
 
 	clk = pdev->dev.of_node ? of_clk_get(pdev->dev.of_node, 0) :
-				  clk_get(&pdev->dev, "periph");
+				  clk_get(&pdev->dev, "refclk");
 	if (IS_ERR(clk))
 		return -ENODEV;
 
-- 
2.13.2
