From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Mon, 23 Jul 2012 11:13:08 +0200
Subject: [PATCH 03/25] serial/imx: make imx_port.devdata member point to const
 data
In-Reply-To: <1343034810-3386-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1343034810-3386-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1343034810-3386-4-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This prepares *of_device_id.data becoming const. Without this change the
following warning would occur:

	drivers/tty/serial/imx.c: In function 'serial_imx_probe_dt':
	drivers/tty/serial/imx.c:1430:17: warning: assignment discards 'const' qualifier from pointer target type [enabled by default]

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 drivers/tty/serial/imx.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 4ef7473..0af4eec 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -207,7 +207,7 @@ struct imx_port {
 	unsigned short		trcv_delay; /* transceiver delay */
 	struct clk		*clk_ipg;
 	struct clk		*clk_per;
-	struct imx_uart_data	*devdata;
+	const struct imx_uart_data *devdata;
 };
 
 struct imx_port_ucrs {
-- 
1.7.10.4
