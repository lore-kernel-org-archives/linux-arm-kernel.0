From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Fri, 23 Jun 2017 11:49:43 +0200
Subject: [PATCH v2 7/9] serial: imx: default to half duplex rs485
In-Reply-To: <20170623094945.31908-1-u.kleine-koenig@pengutronix.de>
References: <20170623094945.31908-1-u.kleine-koenig@pengutronix.de>
Message-ID: <20170623094945.31908-8-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sascha Hauer <s.hauer@pengutronix.de>

The i.MX driver defaulted to full duplex rs485 which is rather
unusual and doesn't match the default implemented in other drivers.

So change the default to half duplex.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 drivers/tty/serial/imx.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index bbefddd92bfe..d5deeef0cd5b 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -2137,8 +2137,7 @@ static int serial_imx_probe(struct platform_device *pdev)
 	sport->port.fifosize = 32;
 	sport->port.ops = &imx_pops;
 	sport->port.rs485_config = imx_rs485_config;
-	sport->port.rs485.flags =
-		SER_RS485_RTS_ON_SEND | SER_RS485_RX_DURING_TX;
+	sport->port.rs485.flags = SER_RS485_RTS_ON_SEND;
 	sport->port.flags = UPF_BOOT_AUTOCONF;
 	init_timer(&sport->timer);
 	sport->timer.function = imx_timeout;
-- 
2.11.0
