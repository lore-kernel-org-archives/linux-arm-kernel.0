From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Tue, 8 Apr 2014 14:46:06 +0300
Subject: [PATCH v2 1/2] ARM: dts: keystone: add cell's information to i2c nodes
In-Reply-To: <1396957567-14540-1-git-send-email-grygorii.strashko@ti.com>
References: <1396957567-14540-1-git-send-email-grygorii.strashko@ti.com>
Message-ID: <1396957567-14540-2-git-send-email-grygorii.strashko@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I2C nodes should always have #address-cells and #size-cells defined,
otherwise warnings will be produced in case of adding child
nodes to the I2C bus in DT:
Warning (avoid_default_addr_size): Relying on default #address-cells value for /soc/i2c at 2530800/pca at 20
Warning (avoid_default_addr_size): Relying on default #size-cells value for /soc/i2c at 2530800/pca at 20

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
