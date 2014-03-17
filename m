From: voice.shen@atmel.com (Bo Shen)
Date: Mon, 17 Mar 2014 17:45:34 +0800
Subject: [PATCH 1/8] ARM: at91: sama5d3: add DMA property for SSC devices
In-Reply-To: <1395049541-28128-1-git-send-email-voice.shen@atmel.com>
References: <1395049541-28128-1-git-send-email-voice.shen@atmel.com>
Message-ID: <1395049541-28128-2-git-send-email-voice.shen@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add DMA property for SSC devices on SAMA5D3 SoC.

Signed-off-by: Bo Shen <voice.shen@atmel.com>
---

 arch/arm/boot/dts/sama5d3.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/sama5d3.dtsi b/arch/arm/boot/dts/sama5d3.dtsi
index 3d5faf8..3e753e1 100644
--- a/arch/arm/boot/dts/sama5d3.dtsi
+++ b/arch/arm/boot/dts/sama5d3.dtsi
@@ -113,6 +113,9 @@
 				compatible = "atmel,at91sam9g45-ssc";
 				reg = <0xf0008000 0x4000>;
 				interrupts = <38 IRQ_TYPE_LEVEL_HIGH 4>;
+				dmas = <&dma0 2 AT91_DMA_CFG_PER_ID(13)>,
+				       <&dma0 2 AT91_DMA_CFG_PER_ID(14)>;
+				dma-names = "tx", "rx";
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_ssc0_tx &pinctrl_ssc0_rx>;
 				clocks = <&ssc0_clk>;
@@ -231,6 +234,9 @@
 				compatible = "atmel,at91sam9g45-ssc";
 				reg = <0xf800c000 0x4000>;
 				interrupts = <39 IRQ_TYPE_LEVEL_HIGH 4>;
+				dmas = <&dma1 2 AT91_DMA_CFG_PER_ID(3)>,
+				       <&dma1 2 AT91_DMA_CFG_PER_ID(4)>;
+				dma-names = "tx", "rx";
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_ssc1_tx &pinctrl_ssc1_rx>;
 				clocks = <&ssc1_clk>;
-- 
1.8.5.2
