From: jonas.gorski@gmail.com (Jonas Gorski)
Date: Wed,  2 Aug 2017 11:34:24 +0200
Subject: [PATCH 3/8] tty/bcm63xx_uart: use refclk for the expected clock name
In-Reply-To: <20170802093429.12572-1-jonas.gorski@gmail.com>
References: <20170802093429.12572-1-jonas.gorski@gmail.com>
Message-ID: <20170802093429.12572-4-jonas.gorski@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We now have the clock available under refclk, so use that.

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
