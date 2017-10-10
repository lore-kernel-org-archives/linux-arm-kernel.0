From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 10 Oct 2017 10:45:51 +0200
Subject: [PATCH] ARM: dts: r8a779x: add '#reset-cells' in cpg-mssr
Message-ID: <20171010084611.968735-1-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

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
---
 arch/arm/boot/dts/r8a7790.dtsi | 1 +
 arch/arm/boot/dts/r8a7792.dtsi | 1 +
 arch/arm/boot/dts/r8a7794.dtsi | 1 +
 3 files changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index 17a48199b7a9..8215a971cf17 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -1186,6 +1186,7 @@
 		clock-names = "extal", "usb_extal";
 		#clock-cells = <2>;
 		#power-domain-cells = <0>;
+		#reset-cells = <1>;
 	};
 
 	prr: chipid at ff000044 {
diff --git a/arch/arm/boot/dts/r8a7792.dtsi b/arch/arm/boot/dts/r8a7792.dtsi
index 549eafe8ff12..cde709e3a916 100644
--- a/arch/arm/boot/dts/r8a7792.dtsi
+++ b/arch/arm/boot/dts/r8a7792.dtsi
@@ -828,6 +828,7 @@
 			clock-names = "extal";
 			#clock-cells = <2>;
 			#power-domain-cells = <0>;
+			#reset-cells = <1>;
 		};
 	};
 
diff --git a/arch/arm/boot/dts/r8a7794.dtsi b/arch/arm/boot/dts/r8a7794.dtsi
index 19cff0dd90cf..a406d56234ba 100644
--- a/arch/arm/boot/dts/r8a7794.dtsi
+++ b/arch/arm/boot/dts/r8a7794.dtsi
@@ -1098,6 +1098,7 @@
 		clock-names = "extal", "usb_extal";
 		#clock-cells = <2>;
 		#power-domain-cells = <0>;
+		#reset-cells = <1>;
 	};
 
 	rst: reset-controller at e6160000 {
-- 
2.9.0
