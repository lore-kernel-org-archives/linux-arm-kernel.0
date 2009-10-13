From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Tue, 13 Oct 2009 09:08:00 +0200
Subject: [PATCH] serial/atmel_serial: Fix another fallout of the change to
	BUILD_BUG_ON
Message-ID: <1255417680-25609-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 8c87df457cb5 fixed BUILD_BUG_ON with the result that some
expressions (e.g. "not really constant" ones) result in a build failure.

Some of these were fixed in 8c87df457cb5, but not serial/atmel_serial.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
Cc: Jan Beulich <jbeulich@novell.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Haavard Skinnemoen <hskinnemoen@atmel.com>
Cc: Alan Cox <alan@linux.intel.com>
---
Hello,

currently 27 arm defconfigs fail because of that error, see

	http://armlinux.simtec.co.uk/kautobuild/2.6.32-rc4-git1/errors.html

Best regards
Uwe

 drivers/serial/atmel_serial.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/serial/atmel_serial.c b/drivers/serial/atmel_serial.c
index 3551c5c..b37d75f 100644
--- a/drivers/serial/atmel_serial.c
+++ b/drivers/serial/atmel_serial.c
@@ -1531,7 +1531,7 @@ static int __devinit atmel_serial_probe(struct platform_device *pdev)
 	void *data;
 	int ret;
 
-	BUILD_BUG_ON(!is_power_of_2(ATMEL_SERIAL_RINGSIZE));
+	MAYBE_BUILD_BUG_ON(!is_power_of_2(ATMEL_SERIAL_RINGSIZE));
 
 	port = &atmel_ports[pdev->id];
 	port->backup_imr = 0;
-- 
1.6.4.3
