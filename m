From: cyrille.pitchen@atmel.com (Cyrille Pitchen)
Date: Tue, 2 Jun 2015 16:18:21 +0200
Subject: [PATCH linux-next 1/4] ARM: at91/dt: add new DT properties for Atmel
 usart
In-Reply-To: <cover.1433253787.git.cyrille.pitchen@atmel.com>
References: <cover.1433253787.git.cyrille.pitchen@atmel.com>
Message-ID: <6fe7914a2c39245ac9a05cdb9962b88c409ec1a4.1433253787.git.cyrille.pitchen@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

add 3 new properties:
- "atmel,fifo-size": to enable FIFO support
- "atmel,rts-low-threshold" and "atmel,rts-high-threshold": to control
  the hardware handshake flow control.

Signed-off-by: Cyrille Pitchen <cyrille.pitchen@atmel.com>
---
 Documentation/devicetree/bindings/serial/atmel-usart.txt | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/atmel-usart.txt b/Documentation/devicetree/bindings/serial/atmel-usart.txt
index 90787aa..6158418 100644
--- a/Documentation/devicetree/bindings/serial/atmel-usart.txt
+++ b/Documentation/devicetree/bindings/serial/atmel-usart.txt
@@ -22,6 +22,21 @@ Optional properties:
 		memory peripheral interface and USART DMA channel ID, FIFO configuration.
 		Refer to dma.txt and atmel-dma.txt for details.
 	- dma-names: "rx" for RX channel, "tx" for TX channel.
+- atmel,fifo-size: size of the TX and RX FIFOs. That is to say the maximum
+  number of data each FIFO can store. A positive size enables FIFO support.
+  A zero size or a missing property disables FIFO support.
+- atmel,rts-low-threshold: when the RX FIFO level, ie the number of data
+  available to be read from the RX FIFO, crosses down this threshold the RTS
+  line is driven to low level to tell the remote peer that it can (re)start
+  sending new data.
+- atmel,rts-high-threshold: when the RX FIFO level crosses up this threshold,
+  the RTS line is driven to high level to tell the remote peer that it should
+  stop sending new data.
+
+0 < rts-low-threshold < rts-high-threshold <= fifo-size
+
+These two thresholds are only used when both the FIFO support and the hardware
+handshake mode are enabled.
 
 <chip> compatible description:
 - at91rm9200:  legacy USART support
-- 
1.8.2.2
