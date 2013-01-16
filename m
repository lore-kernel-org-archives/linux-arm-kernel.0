From: dinggnu@gmail.com (Cong Ding)
Date: Wed, 16 Jan 2013 23:25:03 +0100
Subject: [PATCH] tty: serial/vt8500_serial.c: fix bug caused by missing "{}"
Message-ID: <1358375103-11703-1-git-send-email-dinggnu@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It is obviously here should be braced by "{}" in the "if" branch (more than 1
line in the "if" branch), and by the
coding style document of the kernel I also add "{}" to the else branch.

Signed-off-by: Cong Ding <dinggnu@gmail.com>
---
 drivers/tty/serial/vt8500_serial.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/vt8500_serial.c b/drivers/tty/serial/vt8500_serial.c
index 8fd1814..ac46a6e 100644
--- a/drivers/tty/serial/vt8500_serial.c
+++ b/drivers/tty/serial/vt8500_serial.c
@@ -567,12 +567,13 @@ static int vt8500_serial_probe(struct platform_device *pdev)
 	if (!mmres || !irqres)
 		return -ENODEV;
 
-	if (np)
+	if (np) {
 		port = of_alias_get_id(np, "serial");
 		if (port > VT8500_MAX_PORTS)
 			port = -1;
-	else
+	} else {
 		port = -1;
+	}
 
 	if (port < 0) {
 		/* calculate the port id */
-- 
1.7.10.4
