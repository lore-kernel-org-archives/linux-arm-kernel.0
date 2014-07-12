From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Sat, 12 Jul 2014 21:30:20 +0200
Subject: [PATCH 5/7] ARM: dts: rockchip: add both clocks to uart nodes
In-Reply-To: <16344051.ZPa9bzz4Fj@diego>
References: <16344051.ZPa9bzz4Fj@diego>
Message-ID: <3113430.UuP3AzC14j@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the newly ammended dw_8250 clock binding to define both the baudclk as
well as the pclk supplying the ip.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/boot/dts/rk3xxx.dtsi | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/rk3xxx.dtsi b/arch/arm/boot/dts/rk3xxx.dtsi
index 86062a0..8b083e8 100644
--- a/arch/arm/boot/dts/rk3xxx.dtsi
+++ b/arch/arm/boot/dts/rk3xxx.dtsi
@@ -90,7 +90,8 @@
 			interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
 			reg-shift = <2>;
 			reg-io-width = <1>;
-			clocks = <&cru SCLK_UART0>;
+			clock-names = "baudclk", "apb_pclk";
+			clocks = <&cru SCLK_UART0>, <&cru PCLK_UART0>;
 			status = "disabled";
 		};
 
@@ -100,7 +101,8 @@
 			interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
 			reg-shift = <2>;
 			reg-io-width = <1>;
-			clocks = <&cru SCLK_UART1>;
+			clock-names = "baudclk", "apb_pclk";
+			clocks = <&cru SCLK_UART1>, <&cru PCLK_UART1>;
 			status = "disabled";
 		};
 
@@ -110,7 +112,8 @@
 			interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
 			reg-shift = <2>;
 			reg-io-width = <1>;
-			clocks = <&cru SCLK_UART2>;
+			clock-names = "baudclk", "apb_pclk";
+			clocks = <&cru SCLK_UART2>, <&cru PCLK_UART2>;
 			status = "disabled";
 		};
 
@@ -120,7 +123,8 @@
 			interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
 			reg-shift = <2>;
 			reg-io-width = <1>;
-			clocks = <&cru SCLK_UART3>;
+			clock-names = "baudclk", "apb_pclk";
+			clocks = <&cru SCLK_UART3>, <&cru PCLK_UART3>;
 			status = "disabled";
 		};
 
-- 
1.9.0
