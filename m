From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri,  5 Oct 2012 18:13:01 +0200
Subject: [PATCH 3/3] serial: i.MX: evaluate linux,stdout-path property
In-Reply-To: <1349453581-1685-1-git-send-email-s.hauer@pengutronix.de>
References: <1349453581-1685-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1349453581-1685-4-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

devicetrees may have the linux,stdout-path property to specify the
console. This patch adds support to the i.MX serial driver for this.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/tty/serial/imx.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 3a9337e..bc8a7bfa 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -1421,6 +1421,9 @@ static int serial_imx_probe_dt(struct imx_port *sport,
 
 	sport->devdata = of_id->data;
 
+	if (of_uart_is_stdoutpath(&pdev->dev))
+		add_preferred_console(imx_reg.cons->name, sport->port.line, 0);
+
 	return 0;
 }
 #else
-- 
1.7.10.4
