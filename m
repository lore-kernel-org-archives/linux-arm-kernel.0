From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 18 Sep 2014 15:23:22 +0200
Subject: [PATCH] ARM: at91: sama5d3xek: reserve dma channel for audio
Message-ID: <1411046602-4864-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bo Shen <voice.shen@atmel.com>

We set the DMA configuration on USARTs in the SoC DT in (ARM: at91: sama5d3:
add usart dma configurations). As the audio must work with DMA channels, we
reserve some dma channels for audio, or else audio won't work.

Signed-off-by: Bo Shen <voice.shen@atmel.com>
[nicolas.ferre at atmel.com: move to the sama5d3xmb.dtsi to cover all board variants]
Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/boot/dts/sama5d3xmb.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/sama5d3xmb.dtsi b/arch/arm/boot/dts/sama5d3xmb.dtsi
index b8c6f20e780c..49c10d33df30 100644
--- a/arch/arm/boot/dts/sama5d3xmb.dtsi
+++ b/arch/arm/boot/dts/sama5d3xmb.dtsi
@@ -25,6 +25,8 @@
 			};
 
 			spi0: spi at f0004000 {
+				dmas = <0>, <0>;	/*  Do not use DMA for spi0 */
+
 				m25p80 at 0 {
 					compatible = "atmel,at25df321a";
 					spi-max-frequency = <50000000>;
@@ -51,6 +53,7 @@
 			};
 
 			usart1: serial at f0020000 {
+				dmas = <0>, <0>;	/*  Do not use DMA for usart1 */
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_usart1 &pinctrl_usart1_rts_cts>;
 				status = "okay";
@@ -132,6 +135,7 @@
 			};
 
 			dbgu: serial at ffffee00 {
+				dmas = <0>, <0>;	/*  Do not use DMA for dbgu */
 				status = "okay";
 			};
 
-- 
1.8.2.2
