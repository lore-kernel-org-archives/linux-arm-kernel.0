From: sjoerd.simons@collabora.co.uk (Sjoerd Simons)
Date: Mon, 19 Oct 2015 10:15:39 +0200
Subject: [PATCH] ASoC: dt-bindings: Drop unneeded properties rockchip
 i2s/spdif bindings
Message-ID: <1445242539-9098-1-git-send-email-sjoerd.simons@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Neither the rockchip i2s nor the rockchip spdif binding support child
devices so #address-cells and #size-cells properties aren't required.
Remove these from the bindings.

Signed-off-by: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
---
This patch is on top of the ASoC tree

 Documentation/devicetree/bindings/sound/rockchip-i2s.txt   | 4 ----
 Documentation/devicetree/bindings/sound/rockchip-spdif.txt | 4 ----
 2 files changed, 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/rockchip-i2s.txt b/Documentation/devicetree/bindings/sound/rockchip-i2s.txt
index 9b82c20..085e0bc 100644
--- a/Documentation/devicetree/bindings/sound/rockchip-i2s.txt
+++ b/Documentation/devicetree/bindings/sound/rockchip-i2s.txt
@@ -12,8 +12,6 @@ Required properties:
 - reg: physical base address of the controller and length of memory mapped
   region.
 - interrupts: should contain the I2S interrupt.
-- #address-cells: should be 1.
-- #size-cells: should be 0.
 - dmas: DMA specifiers for tx and rx dma. See the DMA client binding,
 	Documentation/devicetree/bindings/dma/dma.txt
 - dma-names: should include "tx" and "rx".
@@ -28,8 +26,6 @@ i2s at ff890000 {
 	compatible = "rockchip,rk3288-i2s", "rockchip,rk3066-i2s";
 	reg = <0xff890000 0x10000>;
 	interrupts = <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>;
-	#address-cells = <1>;
-	#size-cells = <0>;
 	dmas = <&pdma1 0>, <&pdma1 1>;
 	dma-names = "tx", "rx";
 	clock-names = "i2s_hclk", "i2s_clk";
diff --git a/Documentation/devicetree/bindings/sound/rockchip-spdif.txt b/Documentation/devicetree/bindings/sound/rockchip-spdif.txt
index 33dd82c..e64dbde 100644
--- a/Documentation/devicetree/bindings/sound/rockchip-spdif.txt
+++ b/Documentation/devicetree/bindings/sound/rockchip-spdif.txt
@@ -12,8 +12,6 @@ Required properties:
 - reg: physical base address of the controller and length of memory mapped
   region.
 - interrupts: should contain the SPDIF interrupt.
-- #address-cells: should be 1.
-- #size-cells: should be 0.
 - dmas: DMA specifiers for tx dma. See the DMA client binding,
   Documentation/devicetree/bindings/dma/dma.txt
 - dma-names: should be "tx"
@@ -33,8 +31,6 @@ spdif: spdif at 0x1011e000 {
 	compatible = "rockchip,rk3188-spdif", "rockchip,rk3066-spdif";
 	reg = <0x1011e000 0x2000>;
 	interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
-	#address-cells = <1>;
-	#size-cells = <0>;
 	dmas = <&dmac1_s 8>;
 	dma-names = "tx";
 	clock-names = "hclk", "mclk";
-- 
2.6.1
