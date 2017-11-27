From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 27 Nov 2017 12:17:44 +0100
Subject: [PATCH 1/1] ARM: dts: r8a779x: Add '#reset-cells' in cpg-mssr
In-Reply-To: <cover.1511781272.git.horms+renesas@verge.net.au>
References: <cover.1511781272.git.horms+renesas@verge.net.au>
Message-ID: <098f53050154498876ef3febde706ff5c8b25cf4.1511781272.git.horms+renesas@verge.net.au>
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

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7790.dtsi | 1 +
 arch/arm/boot/dts/r8a7792.dtsi | 1 +
 arch/arm/boot/dts/r8a7793.dtsi | 1 +
 arch/arm/boot/dts/r8a7794.dtsi | 1 +
 4 files changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index 2f017fee4009..62baabd757b6 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -1201,6 +1201,7 @@
 		clock-names = "extal", "usb_extal";
 		#clock-cells = <2>;
 		#power-domain-cells = <0>;
+		#reset-cells = <1>;
 	};
 
 	prr: chipid at ff000044 {
diff --git a/arch/arm/boot/dts/r8a7792.dtsi b/arch/arm/boot/dts/r8a7792.dtsi
index 131f65b0426e..3d080e07374c 100644
--- a/arch/arm/boot/dts/r8a7792.dtsi
+++ b/arch/arm/boot/dts/r8a7792.dtsi
@@ -829,6 +829,7 @@
 			clock-names = "extal";
 			#clock-cells = <2>;
 			#power-domain-cells = <0>;
+			#reset-cells = <1>;
 		};
 	};
 
diff --git a/arch/arm/boot/dts/r8a7793.dtsi b/arch/arm/boot/dts/r8a7793.dtsi
index 58eae569b4e0..0cd1035de1a4 100644
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
index 905e50c9b524..5643976c1356 100644
--- a/arch/arm/boot/dts/r8a7794.dtsi
+++ b/arch/arm/boot/dts/r8a7794.dtsi
@@ -1099,6 +1099,7 @@
 		clock-names = "extal", "usb_extal";
 		#clock-cells = <2>;
 		#power-domain-cells = <0>;
+		#reset-cells = <1>;
 	};
 
 	rst: reset-controller at e6160000 {
-- 
2.11.0
