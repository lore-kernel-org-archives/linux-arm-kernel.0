From: john@metanate.com (John Keeping)
Date: Tue, 23 Feb 2016 13:41:00 +0000
Subject: [PATCH 2/2] ARM: dts: rockchip: fix audio interrupts on rk3288
In-Reply-To: <1456234860-18832-1-git-send-email-john@metanate.com>
References: <1456234860-18832-1-git-send-email-john@metanate.com>
Message-ID: <1456234860-18832-3-git-send-email-john@metanate.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These must be translated from the values in the TRM by subtracting 32,
which has not been done.  The SPDIF interrupt is also off-by-one.

Signed-off-by: John Keeping <john@metanate.com>
---
 arch/arm/boot/dts/rk3288.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index 5597105..a82d4b1 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -758,7 +758,7 @@
 		clocks = <&cru HCLK_SPDIF8CH>, <&cru SCLK_SPDIF8CH>;
 		dmas = <&dmac_bus_s 3>;
 		dma-names = "tx";
-		interrupts = <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&spdif_tx>;
 		rockchip,grf = <&grf>;
@@ -768,7 +768,7 @@
 	i2s: i2s at ff890000 {
 		compatible = "rockchip,rk3288-i2s", "rockchip,rk3066-i2s";
 		reg = <0xff890000 0x10000>;
-		interrupts = <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 		dmas = <&dmac_bus_s 0>, <&dmac_bus_s 1>;
-- 
2.7.0.226.gfe986fe
