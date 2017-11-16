From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Thu, 16 Nov 2017 14:35:57 +0100
Subject: [PATCH] ARM: dts: r8a779x: Add '#reset-cells' in cpg-mssr
Message-ID: <1510839357-11450-1-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Arnd Bergmann <arnd@arndb.de>

With the latest dtc, we get many warnings about the missing
'#reset-cells' property in these controllers, e.g.:

arch/arm/boot/dts/r8a7790-lager.dtb: Warning (resets_property): Missing property '#reset-cells' in node /clock-controller at e6150000 or bad phandle (referred from /can at e6e80000:resets[0])
arch/arm/boot/dts/r8a7792-blanche.dtb: Warning (resets_property): Missing property '#reset-cells' in node /soc/clock-controller at e6150000 or bad phandle (referred from /soc/dma-controller at e6700000:resets[0])
arch/arm/boot/dts/r8a7792-wheat.dtb: Warning (resets_property): Missing property '#reset-cells' in node /soc/clock-controller at e6150000 or bad phandle (referred from /soc/ethernet at e6800000:resets[0])
arch/arm/boot/dts/r8a7793-gose.dtb: Warning (resets_property): Missing property '#reset-cells' in node /clock-controller at e6150000 or bad phandle (referred from /gpio at e6050000:resets[0])
arch/arm/boot/dts/r8a7794-alt.dtb: Warning (resets_property): Missing property '#reset-cells' in node /clock-controller at e6150000 or bad phandle (referred from /i2c at e6500000:resets[0])
arch/arm/boot/dts/r8a7794-silk.dtb: Warning (resets_property): Missing property '#reset-cells' in node /clock-controller at e6150000 or bad phandle (referred from /interrupt-controller at e61c0000:resets[0])

This adds it for the three r8a779x chips that were lacking it. The
binding mandates this as <1>, so this is the value I use.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
[geert: Add fix for r8a7793.dtsi]
Fixes: 34fbd2b12761d111 ("ARM: dts: r8a7790: Add reset control properties")
Fixes: 6e11a322f1d7505d ("ARM: dts: r8a7792: Add reset control properties")
Fixes: 84fb19e1d201ba86 ("ARM: dts: r8a7793: Add reset control properties")
Fixes: 615beb759ca494a4 ("ARM: dts: r8a7794: Add reset control properties")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a7790.dtsi | 1 +
 arch/arm/boot/dts/r8a7792.dtsi | 1 +
 arch/arm/boot/dts/r8a7793.dtsi | 1 +
 arch/arm/boot/dts/r8a7794.dtsi | 1 +
 4 files changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index e2c530c330a8eb7e..450bfc0e9796a557 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -1202,6 +1202,7 @@
 		clock-names = "extal", "usb_extal";
 		#clock-cells = <2>;
 		#power-domain-cells = <0>;
+		#reset-cells = <1>;
 	};
 
 	prr: chipid at ff000044 {
diff --git a/arch/arm/boot/dts/r8a7792.dtsi b/arch/arm/boot/dts/r8a7792.dtsi
index 7b394273031e9a90..ac05fdb91798b88d 100644
--- a/arch/arm/boot/dts/r8a7792.dtsi
+++ b/arch/arm/boot/dts/r8a7792.dtsi
@@ -830,6 +830,7 @@
 			clock-names = "extal";
 			#clock-cells = <2>;
 			#power-domain-cells = <0>;
+			#reset-cells = <1>;
 		};
 	};
 
diff --git a/arch/arm/boot/dts/r8a7793.dtsi b/arch/arm/boot/dts/r8a7793.dtsi
index a83c2e9c5723fe2c..61dd291d907da2f5 100644
--- a/arch/arm/boot/dts/r8a7793.dtsi
+++ b/arch/arm/boot/dts/r8a7793.dtsi
@@ -1088,6 +1088,7 @@
 		clock-names = "extal", "usb_extal";
 		#clock-cells = <2>;
 		#power-domain-cells = <0>;
+		#reset-cells = <1>;
 	};
 
 	rst: reset-controller at e6160000 {
diff --git a/arch/arm/boot/dts/r8a7794.dtsi b/arch/arm/boot/dts/r8a7794.dtsi
index 96e405e70d9aeea5..106b4e1649ff695b 100644
--- a/arch/arm/boot/dts/r8a7794.dtsi
+++ b/arch/arm/boot/dts/r8a7794.dtsi
@@ -1106,6 +1106,7 @@
 		clock-names = "extal", "usb_extal";
 		#clock-cells = <2>;
 		#power-domain-cells = <0>;
+		#reset-cells = <1>;
 	};
 
 	rst: reset-controller at e6160000 {
-- 
2.7.4
