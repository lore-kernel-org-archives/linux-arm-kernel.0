From: bich.hemon@st.com (Bich HEMON)
Date: Thu, 13 Jul 2017 15:08:28 +0000
Subject: [PATCH 5/9] serial: stm32: add RTS support
In-Reply-To: <1499958494-19354-1-git-send-email-bich.hemon@st.com>
References: <1499958494-19354-1-git-send-email-bich.hemon@st.com>
Message-ID: <1499958494-19354-6-git-send-email-bich.hemon@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Implement support of RTS in USART control register

Signed-off-by: Bich Hemon <bich.hemon@st.com>
---
 drivers/tty/serial/stm32-usart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
index ca61bfe..9158d31 100644
--- a/drivers/tty/serial/stm32-usart.c
+++ b/drivers/tty/serial/stm32-usart.c
@@ -518,7 +518,7 @@ static void stm32_set_termios(struct uart_port *port, struct ktermios *termios,
 	port->status &= ~(UPSTAT_AUTOCTS | UPSTAT_AUTORTS);
 	if (cflag & CRTSCTS) {
 		port->status |= UPSTAT_AUTOCTS | UPSTAT_AUTORTS;
-		cr3 |= USART_CR3_CTSE;
+		cr3 |= USART_CR3_CTSE | USART_CR3_RTSE;
 	}
 
 	usartdiv = DIV_ROUND_CLOSEST(port->uartclk, baud);
-- 
1.9.1
