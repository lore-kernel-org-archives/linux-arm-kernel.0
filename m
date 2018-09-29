From: manivannan.sadhasivam@linaro.org (Manivannan Sadhasivam)
Date: Sat, 29 Sep 2018 13:16:35 +0530
Subject: [PATCH v2 1/3] arm64: dts: actions: s900: Enable Tx DMA for UART5
In-Reply-To: <20180929074637.9766-1-manivannan.sadhasivam@linaro.org>
References: <20180929074637.9766-1-manivannan.sadhasivam@linaro.org>
Message-ID: <20180929074637.9766-2-manivannan.sadhasivam@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable Tx DMA for UART5 in Actions Semi S900 SoC.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/actions/s900.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/actions/s900.dtsi b/arch/arm64/boot/dts/actions/s900.dtsi
index eceba914762c..39af1236f611 100644
--- a/arch/arm64/boot/dts/actions/s900.dtsi
+++ b/arch/arm64/boot/dts/actions/s900.dtsi
@@ -156,6 +156,8 @@
 			compatible = "actions,s900-uart", "actions,owl-uart";
 			reg = <0x0 0xe012a000 0x0 0x2000>;
 			interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
+			dma-names = "tx";
+			dmas = <&dma 26>;
 			status = "disabled";
 		};
 
-- 
2.17.1
