From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon,  3 Oct 2011 11:46:16 +0200
Subject: [PATCH 3/3] tty/serial: atmel_serial: __devinit_p for probe function
In-Reply-To: <b371e80a96a36d962fb8806c2bd7aa20bb688b88.1317634987.git.nicolas.ferre@atmel.com>
References: <b371e80a96a36d962fb8806c2bd7aa20bb688b88.1317634987.git.nicolas.ferre@atmel.com>
Message-ID: <cd489c1d28c26624d6b68399d222aec371045e53.1317634987.git.nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 drivers/tty/serial/atmel_serial.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index a652f8f..453cdb5 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -1789,7 +1789,7 @@ static int __devexit atmel_serial_remove(struct platform_device *pdev)
 }
 
 static struct platform_driver atmel_serial_driver = {
-	.probe		= atmel_serial_probe,
+	.probe		= __devexit_p(atmel_serial_probe),
 	.remove		= __devexit_p(atmel_serial_remove),
 	.suspend	= atmel_serial_suspend,
 	.resume		= atmel_serial_resume,
-- 
1.7.3
