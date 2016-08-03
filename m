From: fabien.lahoudere@collabora.co.uk (Fabien Lahoudere)
Date: Wed,  3 Aug 2016 16:13:13 +0200
Subject: [PATCH 2/2] imx53.dtsi : Add DMA configuration for UART
In-Reply-To: <1470233593-4513-1-git-send-email-fabien.lahoudere@collabora.co.uk>
References: <1470233593-4513-1-git-send-email-fabien.lahoudere@collabora.co.uk>
Message-ID: <1470233593-4513-2-git-send-email-fabien.lahoudere@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to use sdma with UART, we need to add DMA configuration in device tree.

Signed-off-by: Fabien Lahoudere <fabien.lahoudere@collabora.co.uk>
---
 arch/arm/boot/dts/imx53.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
index cd17037..de545e2 100644
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
 
@@ -508,6 +510,8 @@
 				clocks = <&clks IMX5_CLK_UART2_IPG_GATE>,
 				         <&clks IMX5_CLK_UART2_PER_GATE>;
 				clock-names = "ipg", "per";
+				dmas = <&sdma 12 4 0>, <&sdma 13 4 0>;
+				dma-names = "rx", "tx";
 				status = "disabled";
 			};
 
@@ -591,6 +595,8 @@
 				clocks = <&clks IMX5_CLK_UART4_IPG_GATE>,
 				         <&clks IMX5_CLK_UART4_PER_GATE>;
 				clock-names = "ipg", "per";
+				dmas = <&sdma 2 4 0>, <&sdma 3 4 0>;
+				dma-names = "rx", "tx";
 				status = "disabled";
 			};
 		};
@@ -621,6 +627,8 @@
 				clocks = <&clks IMX5_CLK_UART5_IPG_GATE>,
 				         <&clks IMX5_CLK_UART5_PER_GATE>;
 				clock-names = "ipg", "per";
+				dmas = <&sdma 16 4 0>, <&sdma 17 4 0>;
+				dma-names = "rx", "tx";
 				status = "disabled";
 			};
 
-- 
2.7.4
