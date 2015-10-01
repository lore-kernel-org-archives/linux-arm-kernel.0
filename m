From: manabian@gmail.com (Joachim Eastwood)
Date: Thu,  1 Oct 2015 22:54:43 +0200
Subject: [PATCH 06/16] ARM: dts: lpc18xx: add dma to uart0/1/2/3
In-Reply-To: <1443732893-17145-1-git-send-email-manabian@gmail.com>
References: <1443732893-17145-1-git-send-email-manabian@gmail.com>
Message-ID: <1443732893-17145-7-git-send-email-manabian@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add dmas entries to the four UART peripherals on LPC18xx/43xx devices
so that DMA can be used to transfer data.

Signed-off-by: Joachim Eastwood <manabian@gmail.com>
---
 arch/arm/boot/dts/lpc18xx.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/lpc18xx.dtsi b/arch/arm/boot/dts/lpc18xx.dtsi
index 5b7ca7066161..f97feea5f5da 100644
--- a/arch/arm/boot/dts/lpc18xx.dtsi
+++ b/arch/arm/boot/dts/lpc18xx.dtsi
@@ -230,6 +230,11 @@
 			interrupts = <24>;
 			clocks = <&ccu2 CLK_APB0_UART0>, <&ccu1 CLK_CPU_UART0>;
 			clock-names = "uartclk", "reg";
+			dmas = <&dmamux  1 1 2
+				&dmamux  2 1 2
+				&dmamux 11 2 2
+				&dmamux 12 2 2>;
+			dma-names = "tx", "rx", "tx", "rx";
 			status = "disabled";
 		};
 
@@ -240,6 +245,9 @@
 			interrupts = <25>;
 			clocks = <&ccu2 CLK_APB0_UART1>, <&ccu1 CLK_CPU_UART1>;
 			clock-names = "uartclk", "reg";
+			dmas = <&dmamux 3 1 2
+				&dmamux 4 1 2>;
+			dma-names = "tx", "rx";
 			status = "disabled";
 		};
 
@@ -294,6 +302,9 @@
 			interrupts = <26>;
 			clocks = <&ccu2 CLK_APB2_UART2>, <&ccu1 CLK_CPU_UART2>;
 			clock-names = "uartclk", "reg";
+			dmas = <&dmamux 5 1 2
+				&dmamux 6 1 2>;
+			dma-names = "tx", "rx";
 			status = "disabled";
 		};
 
@@ -304,6 +315,11 @@
 			interrupts = <27>;
 			clocks = <&ccu2 CLK_APB2_UART3>, <&ccu1 CLK_CPU_UART3>;
 			clock-names = "uartclk", "reg";
+			dmas = <&dmamux  7 1 2
+				&dmamux  8 1 2
+				&dmamux 13 3 2
+				&dmamux 14 3 2>;
+			dma-names = "tx", "rx", "rx", "tx";
 			status = "disabled";
 		};
 
-- 
1.8.0
