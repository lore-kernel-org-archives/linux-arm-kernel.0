From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Tue, 24 Feb 2015 11:17:06 +0100
Subject: [PATCH v2 2/7] serial: imx: remove long dead code
In-Reply-To: <1424773031-19692-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1424773031-19692-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1424773031-19692-3-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This if (0) exists since the driver was introduced in commit
c49bde83eb6a ([ARM PATCH] 1956/2: Re: Motorola i.MX serial driver)
back in 2004.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 drivers/tty/serial/imx.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 23061918b0e4..fa1fb3b46ed8 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -1373,15 +1373,6 @@ imx_set_termios(struct uart_port *port, struct ktermios *termios,
 	uint64_t tdiv64;
 
 	/*
-	 * If we don't support modem control lines, don't allow
-	 * these to be set.
-	 */
-	if (0) {
-		termios->c_cflag &= ~(HUPCL | CRTSCTS | CMSPAR);
-		termios->c_cflag |= CLOCAL;
-	}
-
-	/*
 	 * We only support CS7 and CS8.
 	 */
 	while ((termios->c_cflag & CSIZE) != CS7 &&
-- 
2.1.4
