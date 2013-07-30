From: richard.genoud@gmail.com (Richard Genoud)
Date: Tue, 30 Jul 2013 11:59:48 +0200
Subject: [PATCH v6 4/8] ARM: AT91: DTS: sam9x5: add SSC DMA parameters
In-Reply-To: <1375178392-26060-1-git-send-email-richard.genoud@gmail.com>
References: <1375178392-26060-1-git-send-email-richard.genoud@gmail.com>
Message-ID: <1375178392-26060-5-git-send-email-richard.genoud@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Richard Genoud <richard.genoud@gmail.com>
---
 arch/arm/boot/dts/at91sam9x5.dtsi |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/at91sam9x5.dtsi b/arch/arm/boot/dts/at91sam9x5.dtsi
index 20b6423..d6c9895 100644
--- a/arch/arm/boot/dts/at91sam9x5.dtsi
+++ b/arch/arm/boot/dts/at91sam9x5.dtsi
@@ -716,6 +716,9 @@
 				compatible = "atmel,at91sam9g45-ssc";
 				reg = <0xf0010000 0x4000>;
 				interrupts = <28 IRQ_TYPE_LEVEL_HIGH 5>;
+				dmas = <&dma0 1 AT91_DMA_CFG_PER_ID(13)>,
+				       <&dma0 1 AT91_DMA_CFG_PER_ID(14)>;
+				dma-names = "tx", "rx";
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_ssc0_tx &pinctrl_ssc0_rx>;
 				clocks = <&periph 28>;
-- 
1.7.10.4
