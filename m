From: manu@bidouilliste.com (Emmanuel Vadot)
Date: Tue, 22 Nov 2016 18:06:16 +0100
Subject: [PATCH] ARM: dts: sunxi: Add num-cs for A20 spi nodes
Message-ID: <20161122170616.29557-1-manu@bidouilliste.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The spi0 controller on the A20 have up to 4 CS (Chip Select) while the
others three only have 1.
Add the num-cs property to each node.

Signed-off-by: Emmanuel Vadot <manu@bidouilliste.com>
---
 arch/arm/boot/dts/sun7i-a20.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index 94cf5a1..ed21982 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -871,6 +871,7 @@
 			status = "disabled";
 			#address-cells = <1>;
 			#size-cells = <0>;
+			num-cs = 4;
 		};
 
 		spi1: spi at 01c06000 {
@@ -885,6 +886,7 @@
 			status = "disabled";
 			#address-cells = <1>;
 			#size-cells = <0>;
+			num-cs = 1;
 		};
 
 		emac: ethernet at 01c0b000 {
@@ -1037,6 +1039,7 @@
 			status = "disabled";
 			#address-cells = <1>;
 			#size-cells = <0>;
+			num-cs = 1;
 		};
 
 		ahci: sata at 01c18000 {
@@ -1079,6 +1082,7 @@
 			status = "disabled";
 			#address-cells = <1>;
 			#size-cells = <0>;
+			num-cs = 1;
 		};
 
 		pio: pinctrl at 01c20800 {
-- 
2.9.2
