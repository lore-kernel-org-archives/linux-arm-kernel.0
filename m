From: voice.shen@atmel.com (Bo Shen)
Date: Mon, 14 Oct 2013 13:38:30 +0800
Subject: [PATCH 2/5] ARM: at91: add ssc dma parameter for at91sam9n12
In-Reply-To: <1381729113-29714-1-git-send-email-voice.shen@atmel.com>
References: <1381729113-29714-1-git-send-email-voice.shen@atmel.com>
Message-ID: <1381729113-29714-3-git-send-email-voice.shen@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add ssc dma parameter for at91sam9n12

Signed-off-by: Bo Shen <voice.shen@atmel.com>
---
 arch/arm/boot/dts/at91sam9n12.dtsi |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/at91sam9n12.dtsi b/arch/arm/boot/dts/at91sam9n12.dtsi
index 9fb7ffd..6224f9f 100644
--- a/arch/arm/boot/dts/at91sam9n12.dtsi
+++ b/arch/arm/boot/dts/at91sam9n12.dtsi
@@ -437,6 +437,9 @@
 				compatible = "atmel,at91sam9g45-ssc";
 				reg = <0xf0010000 0x4000>;
 				interrupts = <28 IRQ_TYPE_LEVEL_HIGH 5>;
+				dmas = <&dma 0 AT91_DMA_CFG_PER_ID(21)>,
+				       <&dma 0 AT91_DMA_CFG_PER_ID(22)>;
+				dma-names = "tx", "rx";
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_ssc0_tx &pinctrl_ssc0_rx>;
 				status = "disabled";
-- 
1.7.9.5
