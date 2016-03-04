From: edo.rus@gmail.com (Ed Spiridonov)
Date: Fri,  4 Mar 2016 08:11:53 +0300
Subject: [PATCH] serial: pl011: add mark/space parity support
Message-ID: <1457068313-16092-1-git-send-email-edo.rus@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

PL011 UART has hardware mark/space parity ability, this trivial patch adds support for it.
Tested on Raspberry Pi v1, v2 (BCM2835 and BCM2836)

Signed-off-by: Ed Spiridonov <edo.rus@gmail.com>
---
 drivers/tty/serial/amba-pl011.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index c0da0cc..9de674a 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -1947,6 +1947,8 @@ pl011_set_termios(struct uart_port *port, struct ktermios *termios,
 		lcr_h |= UART01x_LCRH_PEN;
 		if (!(termios->c_cflag & PARODD))
 			lcr_h |= UART01x_LCRH_EPS;
+		if (termios->c_cflag & CMSPAR)
+			lcr_h |= UART011_LCRH_SPS;
 	}
 	if (uap->fifosize > 1)
 		lcr_h |= UART01x_LCRH_FEN;
-- 
2.7.0
