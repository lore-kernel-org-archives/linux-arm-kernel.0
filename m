From: bich.hemon@st.com (Bich HEMON)
Date: Mon, 26 Jun 2017 12:49:13 +0000
Subject: [PATCH 11/20] serial: stm32: add RTS support
In-Reply-To: <1498481318-1894-1-git-send-email-bich.hemon@st.com>
References: <1498481318-1894-1-git-send-email-bich.hemon@st.com>
Message-ID: <1498481318-1894-12-git-send-email-bich.hemon@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bich Hemon <bich.hemon@st.com>

Signed-off-by: Bich Hemon <bich.hemon@st.com>
---
 drivers/tty/serial/stm32-usart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
index 13fc520..a7401b0 100644
--- a/drivers/tty/serial/stm32-usart.c
+++ b/drivers/tty/serial/stm32-usart.c
@@ -617,7 +617,7 @@ static void stm32_set_termios(struct uart_port *port, struct ktermios *termios,
 	port->status &= ~(UPSTAT_AUTOCTS | UPSTAT_AUTORTS);
 	if (cflag & CRTSCTS) {
 		port->status |= UPSTAT_AUTOCTS | UPSTAT_AUTORTS;
-		cr3 |= USART_CR3_CTSE;
+		cr3 |= USART_CR3_CTSE | USART_CR3_RTSE;
 	}
 
 	usartdiv = DIV_ROUND_CLOSEST(port->uartclk, baud);
-- 
1.9.1
