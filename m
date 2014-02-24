From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 24 Feb 2014 13:57:18 +0100
Subject: [PATCH 2/2] ARM: u300: switch SSP/SPI clock name to "SSPCLK"
Message-ID: <1393246638-16236-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As noted in recent discussions the name of the core clock for
the PL022 derived SPI blocks is erroneously named in the
U300 device tree. The kernel doesn't currently use the name,
but may do so soon so let use rename all these clocks in
accordance with the name given in the PL022 TRM (ARM DDI 0194G).

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/ste-u300.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/ste-u300.dts b/arch/arm/boot/dts/ste-u300.dts
index a9da4800daf0..6fe688e9e4da 100644
--- a/arch/arm/boot/dts/ste-u300.dts
+++ b/arch/arm/boot/dts/ste-u300.dts
@@ -457,7 +457,7 @@
 			interrupt-parent = <&vica>;
 			interrupts = <23>;
 			clocks = <&spi_clk>, <&spi_clk>;
-			clock-names = "apb_pclk", "spi_clk";
+			clock-names = "SSPCLK", "apb_pclk";
 			dmas = <&dmac 27 &dmac 28>;
 			dma-names = "tx", "rx";
 			num-cs = <3>;
-- 
1.8.5.3
