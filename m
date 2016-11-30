From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 30 Nov 2016 18:36:30 +0100
Subject: [PATCH 2/2] ARM: dts: at91: sama5d4 Xplained: enable UART1 node with
 DMA
In-Reply-To: <20161130173630.11944-1-nicolas.ferre@atmel.com>
References: <20161130173630.11944-1-nicolas.ferre@atmel.com>
Message-ID: <20161130173630.11944-2-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable UART1 and use DMA configuration with it.

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/boot/dts/at91-sama5d4_xplained.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/at91-sama5d4_xplained.dts b/arch/arm/boot/dts/at91-sama5d4_xplained.dts
index ed7fce297738..91cf69e26aa1 100644
--- a/arch/arm/boot/dts/at91-sama5d4_xplained.dts
+++ b/arch/arm/boot/dts/at91-sama5d4_xplained.dts
@@ -69,6 +69,12 @@
 
 	ahb {
 		apb {
+			uart0: serial at f8004000 {
+				atmel,use-dma-rx;
+				atmel,use-dma-tx;
+				status = "okay";
+			};
+
 			spi0: spi at f8010000 {
 				cs-gpios = <&pioC 3 0>, <0>, <0>, <0>;
 				status = "okay";
-- 
2.9.0
