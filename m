From: manivannan.sadhasivam@linaro.org (Manivannan Sadhasivam)
Date: Thu, 20 Sep 2018 23:01:02 -0700
Subject: [PATCH 3/4] arm64: dts: hisilicon: Source SoC clock for UART6
In-Reply-To: <20180921060103.21370-1-manivannan.sadhasivam@linaro.org>
References: <20180921060103.21370-1-manivannan.sadhasivam@linaro.org>
Message-ID: <20180921060103.21370-4-manivannan.sadhasivam@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove fixed clock and source SoC clock for UART6 for
HiSilicon Hi3670 SoC.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/hisilicon/hi3670.dtsi | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3670.dtsi b/arch/arm64/boot/dts/hisilicon/hi3670.dtsi
index 8a0ee4b08886..34a2f0dbc6f7 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3670.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi3670.dtsi
@@ -187,17 +187,12 @@
 			#clock-cells = <1>;
 		};
 
-		uart6_clk: clk_19_2M {
-			compatible = "fixed-clock";
-			#clock-cells = <0>;
-			clock-frequency = <19200000>;
-		};
-
 		uart6: serial at fff32000 {
 			compatible = "arm,pl011", "arm,primecell";
 			reg = <0x0 0xfff32000 0x0 0x1000>;
 			interrupts = <GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&uart6_clk &uart6_clk>;
+			clocks = <&crg_ctrl HI3670_CLK_UART6>,
+				 <&crg_ctrl HI3670_PCLK>;
 			clock-names = "uartclk", "apb_pclk";
 			status = "disabled";
 		};
-- 
2.17.1
