From: mpa@pengutronix.de (Markus Pargmann)
Date: Wed,  5 Nov 2014 13:20:50 +0100
Subject: [PATCH RESEND] tty: serial: omap: Remove probe error message
Message-ID: <1415190050-31300-1-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This error message is not necessary. The driver core code will print all
probe error messages. It also resolves some error codes to proper error
messages. For example -EPROBE_DEFER will only be printed as an info message.

This patch removes the error message as the core prints the same
information.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
Acked-by: Felipe Balbi <balbi@ti.com>
---

Hi,

this is another resend of this patch. I rebased it onto v3.18-rc3.

Regards,

Markus

 drivers/tty/serial/omap-serial.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index 18c30cabe27f..6cda5cd8b513 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -1747,8 +1747,6 @@ err_add_port:
 	pm_runtime_disable(&pdev->dev);
 err_rs485:
 err_port_line:
-	dev_err(&pdev->dev, "[UART%d]: failure [%s]: %d\n",
-				pdev->id, __func__, ret);
 	return ret;
 }
 
-- 
2.1.1
