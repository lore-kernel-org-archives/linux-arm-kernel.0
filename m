From: otavio@ossystems.com.br (Otavio Salvador)
Date: Mon, 26 Nov 2018 15:35:05 -0200
Subject: [PATCH v2 3/4] ARM: dts: rockchip: Add UART DMA support for rv1108
In-Reply-To: <20181126173506.24068-1-otavio@ossystems.com.br>
References: <20181126173506.24068-1-otavio@ossystems.com.br>
Message-ID: <20181126173506.24068-3-otavio@ossystems.com.br>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Pass the 'dmas' property to the UART ports so that DMA can
be supported.

Signed-off-by: Otavio Salvador <otavio@ossystems.com.br>
Tested-by: Fabio Berton <fabio.berton@ossystems.com.br>
---

Changes in v2:
- fixup commit signed-off-by
- fixup commit log

 arch/arm/boot/dts/rv1108.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/rv1108.dtsi b/arch/arm/boot/dts/rv1108.dtsi
index 300de8e1475b..23ac4b10d690 100644
--- a/arch/arm/boot/dts/rv1108.dtsi
+++ b/arch/arm/boot/dts/rv1108.dtsi
@@ -116,6 +116,8 @@
 		interrupts = <GIC_SPI 46 IRQ_TYPE_LEVEL_HIGH>;
 		reg-shift = <2>;
 		reg-io-width = <4>;
+		dmas = <&pdma 6>, <&pdma 7>;
+		#dma-cells = <2>;
 		clock-frequency = <24000000>;
 		clocks = <&cru SCLK_UART2>, <&cru PCLK_UART2>;
 		clock-names = "baudclk", "apb_pclk";
@@ -130,6 +132,8 @@
 		interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
 		reg-shift = <2>;
 		reg-io-width = <4>;
+		dmas = <&pdma 4>, <&pdma 5>;
+		#dma-cells = <2>;
 		clock-frequency = <24000000>;
 		clocks = <&cru SCLK_UART1>, <&cru PCLK_UART1>;
 		clock-names = "baudclk", "apb_pclk";
@@ -144,6 +148,8 @@
 		interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>;
 		reg-shift = <2>;
 		reg-io-width = <4>;
+		dmas = <&pdma 2>, <&pdma 3>;
+		#dma-cells = <2>;
 		clock-frequency = <24000000>;
 		clocks = <&cru SCLK_UART0>, <&cru PCLK_UART0>;
 		clock-names = "baudclk", "apb_pclk";
-- 
2.19.2
