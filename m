From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon,  3 Oct 2011 12:11:19 +0200
Subject: [PATCH 3/3] tty/serial: atmel_serial: __devinit_p for probe function
In-Reply-To: <cd489c1d28c26624d6b68399d222aec371045e53.1317634987.git.nicolas.ferre@atmel.com>
References: <cd489c1d28c26624d6b68399d222aec371045e53.1317634987.git.nicolas.ferre@atmel.com>
Message-ID: <d7c2023edfbeb3d21bccd5b997f7806874b01b04.1317636473.git.nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 drivers/tty/serial/atmel_serial.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index a652f8f..e40a10a 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -1789,7 +1789,7 @@ static int __devexit atmel_serial_remove(struct platform_device *pdev)
 }
 
 static struct platform_driver atmel_serial_driver = {
-	.probe		= atmel_serial_probe,
+	.probe		= __devinit_p(atmel_serial_probe),
 	.remove		= __devexit_p(atmel_serial_remove),
 	.suspend	= atmel_serial_suspend,
 	.resume		= atmel_serial_resume,
-- 
1.7.3
