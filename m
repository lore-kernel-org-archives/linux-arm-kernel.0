From: manu@bidouilliste.com (Emmanuel Vadot)
Date: Mon, 26 Dec 2016 18:47:48 +0100
Subject: [PATCH v2] ARM: dts: sunxi: Add num-cs for A20 spi nodes
Message-ID: <20161226174748.17544-1-manu@bidouilliste.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The spi0 controller on the A20 have up to 4 CS (Chip Select) while the
others three only have 1.
Add the num-cs property to each node.
The current driver doesn't read this property but this is useful for
downstream user of DTS (FreeBSD for example).

Signed-off-by: Emmanuel Vadot <manu@bidouilliste.com>
---

Changes in v2:
 * Explain that driver doesn't support this but that it is useful
 for downstream users of DTS.

 arch/arm/boot/dts/sun7i-a20.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index 94cf5a1c7172..ed21982c81cb 100644
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
2.11.0
