From: manabian@gmail.com (Joachim Eastwood)
Date: Tue, 14 Jul 2015 15:39:37 +0200
Subject: [PATCH 02/17] ARM: dts: lpc18xx: add uart new compat string and clk
 names
In-Reply-To: <1436881192-23930-1-git-send-email-manabian@gmail.com>
References: <1436881192-23930-1-git-send-email-manabian@gmail.com>
Message-ID: <1436881192-23930-3-git-send-email-manabian@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add lpc1850-uart compatible string on uarts together with
proper clock-names.

Signed-off-by: Joachim Eastwood <manabian@gmail.com>
---
 arch/arm/boot/dts/lpc18xx.dtsi | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/lpc18xx.dtsi b/arch/arm/boot/dts/lpc18xx.dtsi
index 78292d0cb263..41a3825b09a4 100644
--- a/arch/arm/boot/dts/lpc18xx.dtsi
+++ b/arch/arm/boot/dts/lpc18xx.dtsi
@@ -101,20 +101,22 @@
 		};
 
 		uart0: serial at 40081000 {
-			compatible = "ns16550a";
+			compatible = "nxp,lpc1850-uart", "ns16550a";
 			reg = <0x40081000 0x1000>;
 			reg-shift = <2>;
 			interrupts = <24>;
 			clocks = <&ccu2 CLK_APB0_UART0>, <&ccu1 CLK_CPU_UART0>;
+			clock-names = "uartclk", "reg";
 			status = "disabled";
 		};
 
 		uart1: serial at 40082000 {
-			compatible = "ns16550a";
+			compatible = "nxp,lpc1850-uart", "ns16550a";
 			reg = <0x40082000 0x1000>;
 			reg-shift = <2>;
 			interrupts = <25>;
 			clocks = <&ccu2 CLK_APB0_UART1>, <&ccu1 CLK_CPU_UART1>;
+			clock-names = "uartclk", "reg";
 			status = "disabled";
 		};
 
@@ -135,20 +137,22 @@
 		};
 
 		uart2: serial at 400c1000 {
-			compatible = "ns16550a";
+			compatible = "nxp,lpc1850-uart", "ns16550a";
 			reg = <0x400c1000 0x1000>;
 			reg-shift = <2>;
 			interrupts = <26>;
 			clocks = <&ccu2 CLK_APB2_UART2>, <&ccu1 CLK_CPU_UART2>;
+			clock-names = "uartclk", "reg";
 			status = "disabled";
 		};
 
 		uart3: serial at 400c2000 {
-			compatible = "ns16550a";
+			compatible = "nxp,lpc1850-uart", "ns16550a";
 			reg = <0x400c2000 0x1000>;
 			reg-shift = <2>;
 			interrupts = <27>;
 			clocks = <&ccu2 CLK_APB2_UART3>, <&ccu1 CLK_CPU_UART3>;
+			clock-names = "uartclk", "reg";
 			status = "disabled";
 		};
 
-- 
1.8.0
