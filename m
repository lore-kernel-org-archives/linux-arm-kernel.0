From: 21cnbao@gmail.com (Barry Song)
Date: Tue, 26 May 2015 09:35:59 +0000
Subject: [PATCH 2/3] serial: sirf: correct the fifo empty_bit
In-Reply-To: <1432632960-19748-1-git-send-email-21cnbao@gmail.com>
References: <1432632960-19748-1-git-send-email-21cnbao@gmail.com>
Message-ID: <1432632960-19748-2-git-send-email-21cnbao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Qipan Li <Qipan.Li@csr.com>

Signed-off-by: Qipan Li <Qipan.Li@csr.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 drivers/tty/serial/sirfsoc_uart.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sirfsoc_uart.h b/drivers/tty/serial/sirfsoc_uart.h
index 3ab3141..644f865 100644
--- a/drivers/tty/serial/sirfsoc_uart.h
+++ b/drivers/tty/serial/sirfsoc_uart.h
@@ -117,7 +117,7 @@ u32 uart_usp_ff_empty_mask(struct uart_port *port)
 {
 	u32 empty_bit;
 
-	empty_bit = ilog2(port->fifosize);
+	empty_bit = ilog2(port->fifosize) + 1;
 	return (1 << empty_bit);
 }
 struct sirfsoc_uart_register sirfsoc_usp = {
-- 
2.3.5
