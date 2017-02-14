From: chunyan.zhang@spreadtrum.com (Chunyan Zhang)
Date: Tue, 14 Feb 2017 17:19:11 +0800
Subject: [PATCH 4/5] sprd_serial: switch comptible string to sc-uart
In-Reply-To: <1487063952-7113-1-git-send-email-chunyan.zhang@spreadtrum.com>
References: <1487063952-7113-1-git-send-email-chunyan.zhang@spreadtrum.com>
Message-ID: <1487063952-7113-5-git-send-email-chunyan.zhang@spreadtrum.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This driver sprd_serial is not only for SC9836, but for all Spreadtrum
SoCs so far.

Signed-off-by: Chunyan Zhang <chunyan.chunyan@spreadtrum.com>
---
 drivers/tty/serial/sprd_serial.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/sprd_serial.c b/drivers/tty/serial/sprd_serial.c
index 699447a..c0d63c01 100644
--- a/drivers/tty/serial/sprd_serial.c
+++ b/drivers/tty/serial/sprd_serial.c
@@ -624,7 +624,7 @@ static int __init sprd_early_console_setup(
 	device->con->write = sprd_early_write;
 	return 0;
 }
-OF_EARLYCON_DECLARE(sprd_serial, "sprd,sc9836-uart",
+OF_EARLYCON_DECLARE(sprd_serial, "sprd,sc-uart",
 		    sprd_early_console_setup);
 
 #else /* !CONFIG_SERIAL_SPRD_CONSOLE */
@@ -777,7 +777,7 @@ static int sprd_resume(struct device *dev)
 static SIMPLE_DEV_PM_OPS(sprd_pm_ops, sprd_suspend, sprd_resume);
 
 static const struct of_device_id serial_ids[] = {
-	{.compatible = "sprd,sc9836-uart",},
+	{.compatible = "sprd,sc-uart",},
 	{}
 };
 MODULE_DEVICE_TABLE(of, serial_ids);
-- 
2.7.4
