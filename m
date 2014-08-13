From: michal.simek@xilinx.com (Michal Simek)
Date: Wed, 13 Aug 2014 13:53:42 +0200
Subject: [PATCH 1/2] tty: serial: xuartps: Remove .owner field for driver
Message-ID: <54c1e2bd13d6a6e679e1481818d6e068d352ba18.1407930818.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is no need to init .owner field.

Based on the patch from Peter Griffin <peter.griffin@linaro.org>
"mmc: remove .owner field for drivers using module_platform_driver"

This patch removes the superflous .owner field for drivers which
use the module_platform_driver API, as this is overriden in
platform_driver_register anyway."

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 drivers/tty/serial/xilinx_uartps.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index 01951d27cc03..c3c252db8b61 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -1428,7 +1428,6 @@ static struct platform_driver cdns_uart_platform_driver = {
 	.probe   = cdns_uart_probe,
 	.remove  = cdns_uart_remove,
 	.driver  = {
-		.owner = THIS_MODULE,
 		.name = CDNS_UART_NAME,
 		.of_match_table = cdns_uart_of_match,
 		.pm = &cdns_uart_dev_pm_ops,
--
1.8.2.3

-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140813/e9e0b5d7/attachment.sig>
