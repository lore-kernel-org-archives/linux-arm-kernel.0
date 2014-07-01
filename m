From: addy.ke@rock-chips.com (addy ke)
Date: Tue,  1 Jul 2014 09:02:57 +0800
Subject: [PATCH v2 1/2] documentation: add rockchip spi documentation
In-Reply-To: <1403582324-9485-2-git-send-email-addy.ke@rock-chips.com>
References: <1403582324-9485-2-git-send-email-addy.ke@rock-chips.com>
Message-ID: <1404176577-3274-1-git-send-email-addy.ke@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: addy ke <addy.ke@rock-chips.com>
---
changes since v1:
- fix binding document according to comments from Mark Rutland
- fix address according to comments from Mark Brown
- combine all properties into "Required Properties" suggested by Heiko St?bner
- remove "Board Specific Portion" suggested by Heiko St?bner

 .../devicetree/bindings/spi/spi-rockchip.txt       | 37 ++++++++++++++++++++++
 1 file changed, 37 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-rockchip.txt

diff --git a/Documentation/devicetree/bindings/spi/spi-rockchip.txt b/Documentation/devicetree/bindings/spi/spi-rockchip.txt
new file mode 100644
index 0000000..7bab355
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/spi-rockchip.txt
@@ -0,0 +1,37 @@
+* Rockchip SPI Controller
+
+The Rockchip SPI controller is used to interface with various devices such as flash
+and display controllers using the SPI communication interface.
+
+Required Properties:
+
+- compatible: should be one of the following.
+    "rockchip,rk3066-spi" for rk3066.
+    "rockchip,rk3188-spi", "rockchip,rk3066-spi" for rk3188.
+    "rockchip,rk3288-spi", "rockchip,rk3066-spi" for rk3288.
+- reg: physical base address of the controller and length of memory mapped
+       region.
+- interrupts: The interrupt number to the cpu. The interrupt specifier format
+              depends on the interrupt controller.
+- clocks: Must contain an entry for each entry in clock-names.
+- clock-names: Shall be "spiclk" for the transfer-clock, and "apb_pclk" for
+			   the peripheral clock.
+- dmas: DMA specifiers for tx and rx dma. See the DMA client binding,
+		Documentation/devicetree/bindings/dma/dma.txt
+- dma-names: DMA request names should include "tx" and "rx" if present.
+- #address-cells: should be 1.
+- #size-cells: should be 0.
+
+Example:
+
+	spi0: spi at ff110000 {
+		compatible = "rockchip,rk3066-spi";
+		reg = <0xff110000 0x1000>;
+		dmas = <&pdma1 11>, <&pdma1 12>;
+		dma-names = "tx", "rx";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru SCLK_SPI0>, <&cru PCLK_SPI0>;
+		clock-names = "spiclk", "apb_pclk";
+	};
-- 
1.8.3.2
