From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 15 Nov 2012 10:31:06 +0100
Subject: [PATCH 3/3] serial: i.MX: evaluate linux,stdout-path property
In-Reply-To: <1352971866-540-1-git-send-email-s.hauer@pengutronix.de>
References: <1352971866-540-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1352971866-540-4-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

devicetrees may have the linux,stdout-path property to specify the
console. This patch adds support to the i.MX serial driver for this.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/tty/serial/imx.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 07a8ca1..ac5a679 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -1419,6 +1419,9 @@ static int serial_imx_probe_dt(struct imx_port *sport,
 
 	sport->devdata = of_id->data;
 
+	if (of_device_is_stdout_path(np))
+		add_preferred_console(imx_reg.cons->name, sport->port.line, 0);
+
 	return 0;
 }
 #else
-- 
1.7.10.4
