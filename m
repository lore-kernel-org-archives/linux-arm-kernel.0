From: nava.manne@xilinx.com (Nava kishore Manne)
Date: Wed, 12 Oct 2016 13:17:27 +0530
Subject: [PATCH v6 1/2] serial: xuartps: Add new compatible string for ZynqMP
Message-ID: <1476258448-20483-1-git-send-email-navam@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch Adds the new compatible string for ZynqMP SoC.

Signed-off-by: Nava kishore Manne <navam@xilinx.com>
---
Changes for v6:
		-Added New patch.

 drivers/tty/serial/xilinx_uartps.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index f37edaa..dd4c02f 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -1200,6 +1200,7 @@ static int __init cdns_early_console_setup(struct earlycon_device *device,
 OF_EARLYCON_DECLARE(cdns, "xlnx,xuartps", cdns_early_console_setup);
 OF_EARLYCON_DECLARE(cdns, "cdns,uart-r1p8", cdns_early_console_setup);
 OF_EARLYCON_DECLARE(cdns, "cdns,uart-r1p12", cdns_early_console_setup);
+OF_EARLYCON_DECLARE(cdns, "xlnx,zynqmp-uart", cdns_early_console_setup);
 
 /**
  * cdns_uart_console_write - perform write operation
@@ -1438,6 +1439,7 @@ static const struct of_device_id cdns_uart_of_match[] = {
 	{ .compatible = "xlnx,xuartps", },
 	{ .compatible = "cdns,uart-r1p8", },
 	{ .compatible = "cdns,uart-r1p12", .data = &zynqmp_uart_def },
+	{ .compatible = "xlnx,zynqmp-uart", .data = &zynqmp_uart_def },
 	{}
 };
 MODULE_DEVICE_TABLE(of, cdns_uart_of_match);
-- 
2.1.1
