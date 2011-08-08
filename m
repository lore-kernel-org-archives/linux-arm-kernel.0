From: n.voss@weinmann.de (Nikolaus Voss)
Date: Mon, 8 Aug 2011 15:10:01 +0000 (UTC)
Subject: [PATCH] =?utf-8?b?YXRtZWxfc2VyaWFsOg==?= fix
	=?utf-8?b?YXRtZWxfZGVmYXVsdF9jb25zb2xlX2RldmljZQ==?=
References: <1307541740.10626.15.camel@hcegtvedt.norway.atmel.com>
	<1308666679-12111-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <loom.20110808T170457-559@post.gmane.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

reflect new static uart platform ids introduced by patch
http://article.gmane.org/gmane.linux.kernel/1126105

Signed-off-by: Nikolaus Voss <n.voss@weinmannn.de>
 
---
 drivers/tty/serial/atmel_serial.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/atmel_serial.c \
	b/drivers/tty/serial/atmel_serial.c
index af9b781..29c7857 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -1609,9 +1609,10 @@ static struct console atmel_console = {
 static int __init atmel_console_init(void)
 {
 	if (atmel_default_console_device) {
-		add_preferred_console(ATMEL_DEVICENAME,
-				      atmel_default_console_device->id, NULL);
-		atmel_init_port(&atmel_ports[atmel_default_console_device->id],
+		struct atmel_uart_data *pdata =
+			atmel_default_console_device->dev.platform_data;
+		add_preferred_console(ATMEL_DEVICENAME, pdata->num, NULL);
+		atmel_init_port(&atmel_ports[pdata->num],
 				atmel_default_console_device);
 		register_console(&atmel_console);
 	}
-- 
1.7.4.1
