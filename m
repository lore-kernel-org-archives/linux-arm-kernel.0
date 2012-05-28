From: stigge@antcom.de (Roland Stigge)
Date: Mon, 28 May 2012 11:58:54 +0200
Subject: [PATCH] serial/of-serial: Add 16654 chip to compatible string list
Message-ID: <1338199134-23885-1-git-send-email-stigge@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The (ST)16654 chip was missing in the list of supported chips in of-serial.
This patch adds the string "st16654" to it, and to the documentation.

Signed-off-by: Roland Stigge <stigge@antcom.de>

---
Applies to v3.4

 Documentation/devicetree/bindings/tty/serial/of-serial.txt |    1 +
 drivers/tty/serial/of_serial.c                             |    1 +
 2 files changed, 2 insertions(+)

--- linux-2.6.orig/Documentation/devicetree/bindings/tty/serial/of-serial.txt
+++ linux-2.6/Documentation/devicetree/bindings/tty/serial/of-serial.txt
@@ -6,6 +6,7 @@ Required properties:
 	- "ns16450"
 	- "ns16550a"
 	- "ns16550"
+	- "st16654"
 	- "ns16750"
 	- "ns16850"
 	- "nvidia,tegra20-uart"
--- linux-2.6.orig/drivers/tty/serial/of_serial.c
+++ linux-2.6/drivers/tty/serial/of_serial.c
@@ -179,6 +179,7 @@ static struct of_device_id __devinitdata
 	{ .compatible = "ns16450",  .data = (void *)PORT_16450, },
 	{ .compatible = "ns16550a", .data = (void *)PORT_16550A, },
 	{ .compatible = "ns16550",  .data = (void *)PORT_16550, },
+	{ .compatible = "st16654",  .data = (void *)PORT_16654, },
 	{ .compatible = "ns16750",  .data = (void *)PORT_16750, },
 	{ .compatible = "ns16850",  .data = (void *)PORT_16850, },
 	{ .compatible = "nvidia,tegra20-uart", .data = (void *)PORT_TEGRA, },
