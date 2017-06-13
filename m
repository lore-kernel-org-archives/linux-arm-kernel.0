From: jeffy.chen@rock-chips.com (Jeffy Chen)
Date: Tue, 13 Jun 2017 13:25:42 +0800
Subject: [PATCH v2 3/4] dt-bindings: spi/rockchip: add "cs-gpios" optional
 property
In-Reply-To: <1497331543-8565-1-git-send-email-jeffy.chen@rock-chips.com>
References: <1497331543-8565-1-git-send-email-jeffy.chen@rock-chips.com>
Message-ID: <1497331543-8565-3-git-send-email-jeffy.chen@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update document devicetree bindings to support "cs-gpios" property.

Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
---

Changes in v2: None

 Documentation/devicetree/bindings/spi/spi-rockchip.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-rockchip.txt b/Documentation/devicetree/bindings/spi/spi-rockchip.txt
index 83da493..d0be2e6 100644
--- a/Documentation/devicetree/bindings/spi/spi-rockchip.txt
+++ b/Documentation/devicetree/bindings/spi/spi-rockchip.txt
@@ -25,6 +25,7 @@ Required Properties:
 
 Optional Properties:
 
+- cs-gpios : Specifies the gpio pins to be used for chipselects.
 - dmas: DMA specifiers for tx and rx dma. See the DMA client binding,
 		Documentation/devicetree/bindings/dma/dma.txt
 - dma-names: DMA request names should include "tx" and "rx" if present.
@@ -48,6 +49,7 @@ Example:
 		#address-cells = <1>;
 		#size-cells = <0>;
 		interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>;
+		cs-gpios = <&gpio2 23 GPIO_ACTIVE_HIGH>;
 		clocks = <&cru SCLK_SPI0>, <&cru PCLK_SPI0>;
 		clock-names = "spiclk", "apb_pclk";
 		pinctrl-0 = <&spi1_pins>;
-- 
2.1.4
