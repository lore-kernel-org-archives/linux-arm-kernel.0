From: mpa@pengutronix.de (Markus Pargmann)
Date: Mon, 29 Sep 2014 09:29:42 +0200
Subject: [PATCH RESEND] tty: serial: omap: Remove probe error message
Message-ID: <1411975782-23709-1-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This error message is not necessary. The driver core code will print all
probe error messages. It also resolves some error codes to proper error
messages. For example -EPROBE_DEFER will only be printed as an info message.

This patch removes the error message as the core prints the same
information.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---

Hi,

I am not sure if this patch got lost, so I resend it. I rebased the patch onto
v3.17-rc1 without conflicts.

Best regards,

Markus

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
2.1.0
