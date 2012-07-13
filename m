From: y@pengutronix.de (y at pengutronix.de)
Date: Fri, 13 Jul 2012 14:32:05 +0200
Subject: [PATCH 02/11] serial/imx: make imx_port.devdata member point to const
 data
In-Reply-To: <1342182734-321-1-git-send-email-y>
References: <1342182734-321-1-git-send-email-y>
Message-ID: <1342182734-321-4-git-send-email-y>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

This prepares of_device_id.data becoming const. Without this change the
following warning would occur:

	drivers/tty/serial/imx.c: In function 'serial_imx_probe_dt':
	drivers/tty/serial/imx.c:1430:17: warning: assignment discards 'const' qualifier from pointer target type [enabled by default]

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
Cc: Alan Cox <alan@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial at vger.kernel.org
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
