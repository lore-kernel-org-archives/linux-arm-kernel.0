From: richard.genoud@gmail.com (Richard Genoud)
Date: Tue, 14 Aug 2012 15:49:36 +0200
Subject: [PATCH 22/23] spi-atmel: complete DMA slave OF documentation
In-Reply-To: <1344952177-18385-1-git-send-email-richard.genoud@gmail.com>
References: <1344952177-18385-1-git-send-email-richard.genoud@gmail.com>
Message-ID: <1344952177-18385-23-git-send-email-richard.genoud@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Richard Genoud <richard.genoud@gmail.com>
---
 .../devicetree/bindings/spi/spi_atmel.txt          |   25 ++++++++++++++++++++
 1 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/spi_atmel.txt b/Documentation/devicetree/bindings/spi/spi_atmel.txt
index 6d2e5e1..b5d8082 100644
--- a/Documentation/devicetree/bindings/spi/spi_atmel.txt
+++ b/Documentation/devicetree/bindings/spi/spi_atmel.txt
@@ -5,6 +5,24 @@ Required properties:
 - reg: Address and length of the register set for the device
 - interrupts: Should contain macb interrupt
 - cs-gpio: Should contain the GPIOs used for chipselect.
+- dma-mask: device coherent dma mask.
+/* dma transfer configuration. Cf DMA Channel configuration register */
+- dma: handle to the dma controller that should be used.
+- atc_src_per: source channel for DMA operation.
+- atc_dst_per: destination channel for DMA operation.
+- atc_src_h2sel_hw: Hardware handshaking interface is used to trigger a
+transfer request.
+- atc_dst_h2sel_hw: Hardware handshaking interface is used to trigger a
+transfer request.
+- atc_sod: STOP ON DONE activated.
+- atc_lock_if: Interface Lock capability is enabled.
+- atc_lock_b: AHB Bus Locking capability is enabled.
+- atc_lock_if_l_buffer: The Master Interface Arbiter is locked by the channel x for a buffer transfer.
+- atc_fifocfg_halffifo: When half FIFO size is available/filled, a source/destination request is serviced.
+- atc_fifocfg_enoughspace: When there is enough space/data available to perform a single AHB access, then the request is serviced.
+- atc_fifocfg_largestburst: The largest defined length AHB burst is performed on the destination AHB interface.
+- atc_ahb_prot: AHB Protection value. (cf release manual)
+
 
 spi0: spi at f0000000 {
 	#address-cells = <1>;
@@ -17,5 +35,12 @@ spi0: spi at f0000000 {
 		    &pioA 1 0 /* conflicts with RXD0 */
 		    &pioB 3 0 /* conflicts with ERXDV */
 		   >;
+	dma-mask = <0xffffffff>;
+	dma = <&dma0>;
+	atc_src_per = <2>; /* AT_DMA_ID_SPI0_RX */
+	atc_dst_per = <1>; /* AT_DMA_ID_SPI0_TX */
+	atc_fifocfg_halffifo;
+	atc_src_h2sel_hw;
+	atc_dst_h2sel_hw;
 	status = "disabled";
 };
-- 
1.7.2.5
