From: alexandre.torgue@st.com (Alexandre TORGUE)
Date: Thu, 15 Sep 2016 18:42:36 +0200
Subject: [PATCH 04/11] serial: stm32: disable tx and rx during shutdown
In-Reply-To: <1473957763-30629-1-git-send-email-alexandre.torgue@st.com>
References: <1473957763-30629-1-git-send-email-alexandre.torgue@st.com>
Message-ID: <1473957763-30629-5-git-send-email-alexandre.torgue@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Gerald Baeza <gerald.baeza@st.com>
Signed-off-by: Alexandre TORGUE <alexandre.torgue@st.com>

diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
index 6236deb..184b018 100644
--- a/drivers/tty/serial/stm32-usart.c
+++ b/drivers/tty/serial/stm32-usart.c
@@ -276,7 +276,7 @@ static void stm32_shutdown(struct uart_port *port)
 	u32 val;
 
 	val = USART_CR1_TXEIE | USART_CR1_RXNEIE | USART_CR1_TE | USART_CR1_RE;
-	stm32_set_bits(port, ofs->cr1, val);
+	stm32_clr_bits(port, ofs->cr1, val);
 
 	free_irq(port->irq, port);
 }
-- 
1.9.1
