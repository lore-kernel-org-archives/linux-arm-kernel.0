From: 21cnbao@gmail.com (Barry Song)
Date: Thu, 14 May 2015 06:45:26 +0000
Subject: [PATCH 6/6] serial: sirf: assign console default index if users not
 set a valid one
In-Reply-To: <1431585926-10746-1-git-send-email-21cnbao@gmail.com>
References: <1431585926-10746-1-git-send-email-21cnbao@gmail.com>
Message-ID: <1431585926-10746-6-git-send-email-21cnbao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Qipan Li <Qipan.Li@csr.com>

it seems this is a more typical behaviour from reviewing other console
drivers.

Signed-off-by: Qipan Li <Qipan.Li@csr.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 drivers/tty/serial/sirfsoc_uart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sirfsoc_uart.c b/drivers/tty/serial/sirfsoc_uart.c
index 0e43799..8d75962 100644
--- a/drivers/tty/serial/sirfsoc_uart.c
+++ b/drivers/tty/serial/sirfsoc_uart.c
@@ -1236,7 +1236,7 @@ sirfsoc_uart_console_setup(struct console *co, char *options)
 	struct sirfsoc_uart_port *sirfport;
 	struct sirfsoc_register *ureg;
 	if (co->index < 0 || co->index >= SIRFSOC_UART_NR)
-		return -EINVAL;
+		co->index = 1;
 	sirfport = sirf_ports[co->index];
 	if (!sirfport)
 		return -ENODEV;
-- 
2.3.5
