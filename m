From: fabien.lahoudere@collabora.co.uk (Fabien Lahoudere)
Date: Mon,  8 Aug 2016 11:29:26 +0200
Subject: [PATCH 2/2] imx53.dtsi : Add DMA configuration for UART
In-Reply-To: <1470648566-11698-1-git-send-email-fabien.lahoudere@collabora.co.uk>
References: <CAOMZO5DAAU0jUpd2xwgTwL9Y1Bhido35fxvhQ9HGZRXbRnB2Gg@mail.gmail.com>
 <1470648566-11698-1-git-send-email-fabien.lahoudere@collabora.co.uk>
Message-ID: <1470648566-11698-2-git-send-email-fabien.lahoudere@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to use sdma with UART, we need to add DMA configuration
in device tree.

Signed-off-by: Fabien Lahoudere <fabien.lahoudere@collabora.co.uk>
---
 arch/arm/boot/dts/imx53.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
index cd17037..c1bc97c 100644
--- a/arch/arm/boot/dts/imx53.dtsi
+++ b/arch/arm/boot/dts/imx53.dtsi
@@ -217,6 +217,8 @@
 					clocks = <&clks IMX5_CLK_UART3_IPG_GATE>,
 					         <&clks IMX5_CLK_UART3_PER_GATE>;
 					clock-names = "ipg", "per";
+					dmas = <&sdma 42 4 0>, <&sdma 43 4 0>;
+					dma-names = "rx", "tx";
 					status = "disabled";
 				};
 
@@ -498,6 +500,8 @@
 				clocks = <&clks IMX5_CLK_UART1_IPG_GATE>,
 				         <&clks IMX5_CLK_UART1_PER_GATE>;
 				clock-names = "ipg", "per";
+				dmas = <&sdma 18 4 0>, <&sdma 19 4 0>;
+				dma-names = "rx", "tx";
 				status = "disabled";
 			};
 
@@ -508,6 +512,8 @@
 				clocks = <&clks IMX5_CLK_UART2_IPG_GATE>,
 				         <&clks IMX5_CLK_UART2_PER_GATE>;
 				clock-names = "ipg", "per";
+				dmas = <&sdma 12 4 0>, <&sdma 13 4 0>;
+				dma-names = "rx", "tx";
 				status = "disabled";
 			};
 
@@ -591,6 +597,8 @@
 				clocks = <&clks IMX5_CLK_UART4_IPG_GATE>,
 				         <&clks IMX5_CLK_UART4_PER_GATE>;
 				clock-names = "ipg", "per";
+				dmas = <&sdma 2 4 0>, <&sdma 3 4 0>;
+				dma-names = "rx", "tx";
 				status = "disabled";
 			};
 		};
@@ -621,6 +629,8 @@
 				clocks = <&clks IMX5_CLK_UART5_IPG_GATE>,
 				         <&clks IMX5_CLK_UART5_PER_GATE>;
 				clock-names = "ipg", "per";
+				dmas = <&sdma 16 4 0>, <&sdma 17 4 0>;
+				dma-names = "rx", "tx";
 				status = "disabled";
 			};
 
-- 
2.7.4
