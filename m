From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Mon, 28 Apr 2014 15:20:22 +0300
Subject: [PATCH] ARM: dts: keystone: add cell's information to spi nodes
Message-ID: <1398687622-29880-1-git-send-email-grygorii.strashko@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

SPI nodes should always have #address-cells and #size-cells defined,
otherwise warnings will be produced in case of adding any child
nodes to the SPI bus in DT:
Warning (avoid_default_addr_size): Relying on default #address-cells value for /soc/spi at 21000400/n25q128a11 at 0
Warning (avoid_default_addr_size): Relying on default #size-cells value for /soc/spi at 21000400/n25q128a11 at 0

Hence, ensure that all SPIx nodes have #address-cells and #size-cells
properties defined.

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 arch/arm/boot/dts/keystone.dtsi |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/keystone.dtsi b/arch/arm/boot/dts/keystone.dtsi
index 7563934..905227f 100644
--- a/arch/arm/boot/dts/keystone.dtsi
+++ b/arch/arm/boot/dts/keystone.dtsi
@@ -131,6 +131,8 @@
 			ti,davinci-spi-intr-line = <0>;
 			interrupts = <GIC_SPI 292 IRQ_TYPE_EDGE_RISING>;
 			clocks = <&clkspi>;
+			#address-cells = <1>;
+			#size-cells = <0>;
 		};
 
 		spi1: spi at 21000600 {
@@ -140,6 +142,8 @@
 			ti,davinci-spi-intr-line = <0>;
 			interrupts = <GIC_SPI 296 IRQ_TYPE_EDGE_RISING>;
 			clocks = <&clkspi>;
+			#address-cells = <1>;
+			#size-cells = <0>;
 		};
 
 		spi2: spi at 21000800 {
@@ -149,6 +153,8 @@
 			ti,davinci-spi-intr-line = <0>;
 			interrupts = <GIC_SPI 300 IRQ_TYPE_EDGE_RISING>;
 			clocks = <&clkspi>;
+			#address-cells = <1>;
+			#size-cells = <0>;
 		};
 
 		usb_phy: usb_phy at 2620738 {
-- 
1.7.9.5
