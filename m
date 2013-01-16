From: linux@prisktech.co.nz (Tony Prisk)
Date: Thu, 17 Jan 2013 08:05:40 +1300
Subject: [PATCH 1/4 v3] serial: vt8500: Fix range-checking on vt8500_uart_ports
In-Reply-To: <1358363143-7154-1-git-send-email-linux@prisktech.co.nz>
References: <1358363143-7154-1-git-send-email-linux@prisktech.co.nz>
Message-ID: <1358363143-7154-2-git-send-email-linux@prisktech.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix two instances where the index to vt8500_uart_ports is tested
against > VT8500_MAX_PORTS. Correct usage should be >= VT8500_MAX_PORTS.

Signed-off-by: Tony Prisk <linux@prisktech.co.nz>
---
 drivers/tty/serial/vt8500_serial.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/vt8500_serial.c b/drivers/tty/serial/vt8500_serial.c
index 8fd1814..4c4a58d 100644
--- a/drivers/tty/serial/vt8500_serial.c
+++ b/drivers/tty/serial/vt8500_serial.c
@@ -569,7 +569,7 @@ static int vt8500_serial_probe(struct platform_device *pdev)
 
 	if (np)
 		port = of_alias_get_id(np, "serial");
-		if (port > VT8500_MAX_PORTS)
+		if (port >= VT8500_MAX_PORTS)
 			port = -1;
 	else
 		port = -1;
@@ -580,7 +580,7 @@ static int vt8500_serial_probe(struct platform_device *pdev)
 					sizeof(vt8500_ports_in_use));
 	}
 
-	if (port > VT8500_MAX_PORTS)
+	if (port >= VT8500_MAX_PORTS)
 		return -ENODEV;
 
 	/* reserve the port id */
-- 
1.7.9.5
