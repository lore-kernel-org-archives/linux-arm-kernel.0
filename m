From: hramrach@gmail.com (Michal Suchanek)
Date: 20 Aug 2015 14:19:46 -0000
Subject: [PATCH 5/9] ARM: dts: sun7i: cubieboard2: Enable SPI0
In-Reply-To: <cover.1440080122.git.hramrach@gmail.com>
References: <cover.1440080122.git.hramrach@gmail.com>
Message-ID: <a5a061d98b7ff851866cc668cd8bf8f6fc99d002.1440080122.git.hramrach@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Only SPI0 is enabled. The schematic denotes it as the only SPI bus.
Other SPI pins are reserved for different peripherals.

Signed-off-by: Michal Suchanek <hramrach@gmail.com>
---
 arch/arm/boot/dts/sun7i-a20-cubieboard2.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts b/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts
index 39a51d5..9861304 100644
--- a/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts
+++ b/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts
@@ -198,6 +198,13 @@
 	status = "okay";
 };
 
+&spi0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&spi0_pins_a>,
+		    <&spi0_cs0_pins_a>;
+	status = "okay";
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_pins_a>;
-- 
2.1.4
