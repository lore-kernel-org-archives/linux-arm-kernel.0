From: tyler@opensourcefoundries.com (tyler at opensourcefoundries.com)
Date: Thu, 30 Nov 2017 12:14:30 -0800
Subject: [PATCH 4/8] ARM: dts: imx7s: add dma support
In-Reply-To: <20171130201434.14122-1-tyler@opensourcefoundries.com>
References: <20171130201434.14122-1-tyler@opensourcefoundries.com>
Message-ID: <20171130201434.14122-5-tyler@opensourcefoundries.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Tyler Baker <tyler@opensourcefoundries.com>

Enable dma on all SPI and UART interfaces.

Signed-off-by: Tyler Baker <tyler@opensourcefoundries.com>
---
 arch/arm/boot/dts/imx7s.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/imx7s.dtsi b/arch/arm/boot/dts/imx7s.dtsi
index 82ad26e..7b85659 100644
--- a/arch/arm/boot/dts/imx7s.dtsi
+++ b/arch/arm/boot/dts/imx7s.dtsi
@@ -700,6 +700,8 @@
 				clocks = <&clks IMX7D_ECSPI1_ROOT_CLK>,
 					<&clks IMX7D_ECSPI1_ROOT_CLK>;
 				clock-names = "ipg", "per";
+				dmas = <&sdma 0 7 1>, <&sdma 1 7 2>;
+				dma-names = "rx", "tx";
 				status = "disabled";
 			};
 
@@ -712,6 +714,8 @@
 				clocks = <&clks IMX7D_ECSPI2_ROOT_CLK>,
 					<&clks IMX7D_ECSPI2_ROOT_CLK>;
 				clock-names = "ipg", "per";
+				dmas = <&sdma 2 7 1>, <&sdma 3 7 2>;
+				dma-names = "rx", "tx";
 				status = "disabled";
 			};
 
@@ -724,6 +728,8 @@
 				clocks = <&clks IMX7D_ECSPI3_ROOT_CLK>,
 					<&clks IMX7D_ECSPI3_ROOT_CLK>;
 				clock-names = "ipg", "per";
+				dmas = <&sdma 4 7 1>, <&sdma 5 7 2>;
+				dma-names = "rx", "tx";
 				status = "disabled";
 			};
 
-- 
2.9.3
