From: roel.kluin@gmail.com (Roel Kluin)
Date: Sat, 21 Nov 2009 16:15:58 +0100
Subject: [PATCH] imx: bit &/| confusion
Message-ID: <4B08042E.2090705@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

since UCR1_UARTEN is defined 1, the port was always treated as enabled.

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---

diff --git a/drivers/serial/imx.c b/drivers/serial/imx.c
index 18130f1..60d665a 100644
--- a/drivers/serial/imx.c
+++ b/drivers/serial/imx.c
@@ -1088,7 +1088,7 @@ imx_console_get_options(struct imx_port *sport, int *baud,
 			   int *parity, int *bits)
 {
 
-	if ( readl(sport->port.membase + UCR1) | UCR1_UARTEN ) {
+	if (readl(sport->port.membase + UCR1) & UCR1_UARTEN) {
 		/* ok, the port was enabled */
 		unsigned int ucr2, ubir,ubmr, uartclk;
 		unsigned int baud_raw;
