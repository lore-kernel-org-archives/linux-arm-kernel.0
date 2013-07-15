From: b32955@freescale.com (Huang Shijie)
Date: Mon, 15 Jul 2013 11:08:54 +0800
Subject: [PATCH 1/3] serial: mxs: remove the unused macro
Message-ID: <1373857736-30108-1-git-send-email-b32955@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The MXS_AUART_DMA_CONFIG is originally used to check if the DT node
is configured with the DMA property.

But now, the MXS_AUART_DMA_CONFIG is not used any more.
Just remove it.

Signed-off-by: Huang Shijie <b32955@freescale.com>
---
 drivers/tty/serial/mxs-auart.c |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-auart.c
index 4f5f161..465ef0b 100644
--- a/drivers/tty/serial/mxs-auart.c
+++ b/drivers/tty/serial/mxs-auart.c
@@ -134,7 +134,6 @@ enum mxs_auart_type {
 struct mxs_auart_port {
 	struct uart_port port;
 
-#define MXS_AUART_DMA_CONFIG	0x1
 #define MXS_AUART_DMA_ENABLED	0x2
 #define MXS_AUART_DMA_TX_SYNC	2  /* bit 2 */
 #define MXS_AUART_DMA_RX_READY	3  /* bit 3 */
@@ -640,7 +639,7 @@ static void mxs_auart_settermios(struct uart_port *u,
 		 * we can only implement the DMA support for auart
 		 * in mx28.
 		 */
-		if (is_imx28_auart(s) && (s->flags & MXS_AUART_DMA_CONFIG)) {
+		if (is_imx28_auart(s)) {
 			if (!mxs_auart_dma_init(s))
 				/* enable DMA tranfer */
 				ctrl2 |= AUART_CTRL2_TXDMAE | AUART_CTRL2_RXDMAE
@@ -1002,8 +1001,6 @@ static int serial_mxs_probe_dt(struct mxs_auart_port *s,
 	}
 	s->port.line = ret;
 
-	s->flags |= MXS_AUART_DMA_CONFIG;
-
 	return 0;
 }
 
-- 
1.7.1
