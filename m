From: linux@prisktech.co.nz (Tony Prisk)
Date: Wed,  8 Aug 2012 13:39:21 +1200
Subject: [PATCH 3/8] serial: vt8500: Add devicetree support for vt8500-serial
In-Reply-To: <1344389967-8465-1-git-send-email-linux@prisktech.co.nz>
References: <1344389967-8465-1-git-send-email-linux@prisktech.co.nz>
Message-ID: <1344389967-8465-4-git-send-email-linux@prisktech.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Tony Prisk <linux@prisktech.co.nz>
---
 drivers/tty/serial/vt8500_serial.c |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/tty/serial/vt8500_serial.c b/drivers/tty/serial/vt8500_serial.c
index 2be006f..a7f58c9 100644
--- a/drivers/tty/serial/vt8500_serial.c
+++ b/drivers/tty/serial/vt8500_serial.c
@@ -34,6 +34,7 @@
 #include <linux/slab.h>
 #include <linux/clk.h>
 #include <linux/platform_device.h>
+#include <linux/of.h>
 
 /*
  * UART Register offsets
@@ -603,12 +604,18 @@ static int __devexit vt8500_serial_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct of_device_id wmt_dt_ids[] = {
+	{ .compatible = "via,vt8500-uart", },
+	{}
+};
+
 static struct platform_driver vt8500_platform_driver = {
 	.probe  = vt8500_serial_probe,
 	.remove = __devexit_p(vt8500_serial_remove),
 	.driver = {
 		.name = "vt8500_serial",
 		.owner = THIS_MODULE,
+		.of_match_table = of_match_ptr(wmt_dt_ids),
 	},
 };
 
-- 
1.7.9.5
