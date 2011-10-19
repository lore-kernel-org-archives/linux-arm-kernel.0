From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 19 Oct 2011 11:36:20 +0200
Subject: [PATCH] tty/serial: atmel_serial: bootconsole removed from
	auto-enumerates
In-Reply-To: <1318981651741@kroah.org>
References: <1318981651741@kroah.org>
Message-ID: <1319016980-10355-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Auto-enumerate mechanism conflicts with bootconsoles: remove
the usage counter for this type of consoles.

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 drivers/tty/serial/atmel_serial.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index 30d8c77..9988c0c 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -1676,7 +1676,6 @@ static int __init atmel_console_init(void)
 		int id = pdata->num;
 		struct atmel_uart_port *port = &atmel_ports[id];
 
-		set_bit(id, &atmel_ports_in_use);
 		port->backup_imr = 0;
 		port->uart.line = id;
 
-- 
1.7.5.4
