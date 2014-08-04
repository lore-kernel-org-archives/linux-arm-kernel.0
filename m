From: mpa@pengutronix.de (Markus Pargmann)
Date: Mon,  4 Aug 2014 14:59:38 +0200
Subject: [PATCH] tty: serial: omap: Remove probe error message
Message-ID: <1407157178-17035-1-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This error message is not necessary. The driver core code will print all
probe error messages. It also resolves some error codes to proper error
messages. For example -EPROBE_DEFER will only be printed as an info message.

This patch removes the error message as the core prints the same
information.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 drivers/tty/serial/omap-serial.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index d017cec8a34a..a153bad142c8 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -1733,8 +1733,6 @@ err_add_port:
 	pm_runtime_disable(&pdev->dev);
 err_rs485:
 err_port_line:
-	dev_err(&pdev->dev, "[UART%d]: failure [%s]: %d\n",
-				pdev->id, __func__, ret);
 	return ret;
 }
 
-- 
2.0.1
