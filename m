From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Wed, 21 Jun 2017 12:21:29 +0200
Subject: [PATCH 8/9] serial: imx: Use common rs485 device tree parsing function
In-Reply-To: <20170621102130.21024-1-u.kleine-koenig@pengutronix.de>
References: <20170621102130.21024-1-u.kleine-koenig@pengutronix.de>
Message-ID: <20170621102130.21024-9-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sascha Hauer <s.hauer@pengutronix.de>

Make use of the new of_get_rs485_mode function to initialize rs485 specific
settings.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Fabio Estevam <fabio.estevam@nxp.com>

 drivers/tty/serial/imx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index d5deeef0cd5b..951bb754ad9b 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -2076,6 +2076,8 @@ static int serial_imx_probe_dt(struct imx_port *sport,
 	if (of_get_property(np, "rts-gpios", NULL))
 		sport->have_rtsgpio = 1;
 
+	of_get_rs485_mode(np, &sport->port.rs485);
+
 	return 0;
 }
 #else
-- 
2.11.0
