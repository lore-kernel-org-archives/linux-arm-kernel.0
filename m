From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Mon, 7 Apr 2014 18:24:32 +0300
Subject: [PATCH] ARM: dts: keystone: add cell's information to i2c nodes
Message-ID: <1396884272-8307-1-git-send-email-grygorii.strashko@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I2C nodes should always have #address-cells and #size-cells defined.
Hence, ensure that all i2cX nodes have #address-cells and #size-cells
properties defined.

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 arch/arm/boot/dts/keystone.dtsi |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/keystone.dtsi b/arch/arm/boot/dts/keystone.dtsi
index 90823eb..f730392 100644
--- a/arch/arm/boot/dts/keystone.dtsi
+++ b/arch/arm/boot/dts/keystone.dtsi
@@ -115,6 +115,8 @@
 			clock-frequency = <100000>;
 			clocks = <&clki2c>;
 			interrupts = <GIC_SPI 286 IRQ_TYPE_EDGE_RISING>;
+			#address-cells = <1>;
+			#size-cells = <0>;
 		};
 
 		i2c2: i2c at 2530800 {
@@ -123,6 +125,8 @@
 			clock-frequency = <100000>;
 			clocks = <&clki2c>;
 			interrupts = <GIC_SPI 289 IRQ_TYPE_EDGE_RISING>;
+			#address-cells = <1>;
+			#size-cells = <0>;
 		};
 
 		spi0: spi at 21000400 {
-- 
1.7.9.5
