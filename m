From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Mon, 23 Jul 2012 11:13:09 +0200
Subject: [PATCH 04/25] serial/mpc52xx_uart: add a const qualifier
In-Reply-To: <1343034810-3386-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1343034810-3386-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1343034810-3386-5-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This prepares *of_device_id.data becoming const. Without this change
the following warning would occur:

	drivers/tty/serial/mpc52xx_uart.c: In function 'mpc52xx_uart_of_enumerate':
	drivers/tty/serial/mpc52xx_uart.c:1440:11: warning: assignment discards 'const' qualifier from pointer target type [enabled by default]

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 drivers/tty/serial/mpc52xx_uart.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/mpc52xx_uart.c b/drivers/tty/serial/mpc52xx_uart.c
index bedac0d..b131f2d 100644
--- a/drivers/tty/serial/mpc52xx_uart.c
+++ b/drivers/tty/serial/mpc52xx_uart.c
@@ -598,7 +598,7 @@ static struct psc_ops mpc512x_psc_ops = {
 };
 #endif
 
-static struct psc_ops *psc_ops;
+static const struct psc_ops *psc_ops;
 
 /* ======================================================================== */
 /* UART operations                                                          */
-- 
1.7.10.4
