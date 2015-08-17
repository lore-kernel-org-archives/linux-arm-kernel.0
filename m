From: michal.simek@xilinx.com (Michal Simek)
Date: Mon, 17 Aug 2015 09:22:32 +0200
Subject: [PATCH 2/4] serial: xuartps: Do not handle overrun errors under
 IGNPAR option
In-Reply-To: <5b154ba97bcd79e49e2131152eb2fc1761594a6c.1439796149.git.michal.simek@xilinx.com>
References: <5b154ba97bcd79e49e2131152eb2fc1761594a6c.1439796149.git.michal.simek@xilinx.com>
Message-ID: <41df6eb35d69801afa5b686a6974e3c3bf65178a.1439796149.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Anirudha Sarangi <anirudha.sarangi@xilinx.com>

The existing implementation includes overrun errors under IGNPAR
option. This patch fixes it by including only parity and framing
error under IGNPAR option.

Signed-off-by: Anirudha Sarangi <anirudh@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 drivers/tty/serial/xilinx_uartps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index a3020344ac9d..c4437e8929ff 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -691,7 +691,7 @@ static void cdns_uart_set_termios(struct uart_port *port,
 
 	if (termios->c_iflag & IGNPAR)
 		port->ignore_status_mask |= CDNS_UART_IXR_PARITY |
-			CDNS_UART_IXR_FRAMING | CDNS_UART_IXR_OVERRUN;
+					    CDNS_UART_IXR_FRAMING;
 
 	/* ignore all characters if CREAD is not set */
 	if ((termios->c_cflag & CREAD) == 0)
-- 
2.3.5
