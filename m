From: shc_work@mail.ru (Alexander Shiyan)
Date: Sun, 13 Apr 2014 10:59:49 +0400
Subject: [PATCH 2/2] ARM: dts: i.MX51: Allow to define partitions onto SDHC,
 PATA and NFC
In-Reply-To: <1397372389-32016-1-git-send-email-shc_work@mail.ru>
References: <1397372389-32016-1-git-send-email-shc_work@mail.ru>
Message-ID: <1397372389-32016-2-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch allow to define partitions onto SDHC, PATA and NFC in
user defined devicetrees.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/boot/dts/imx51.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/imx51.dtsi b/arch/arm/boot/dts/imx51.dtsi
index cb3204a..12f0084 100644
--- a/arch/arm/boot/dts/imx51.dtsi
+++ b/arch/arm/boot/dts/imx51.dtsi
@@ -161,6 +161,8 @@
 				ranges;
 
 				esdhc1: esdhc at 70004000 {
+					#address-cells = <1>;
+					#size-cells = <1>;
 					compatible = "fsl,imx51-esdhc";
 					reg = <0x70004000 0x4000>;
 					interrupts = <1>;
@@ -172,6 +174,8 @@
 				};
 
 				esdhc2: esdhc at 70008000 {
+					#address-cells = <1>;
+					#size-cells = <1>;
 					compatible = "fsl,imx51-esdhc";
 					reg = <0x70008000 0x4000>;
 					interrupts = <2>;
@@ -219,6 +223,8 @@
 				};
 
 				esdhc3: esdhc at 70020000 {
+					#address-cells = <1>;
+					#size-cells = <1>;
 					compatible = "fsl,imx51-esdhc";
 					reg = <0x70020000 0x4000>;
 					interrupts = <3>;
@@ -231,6 +237,8 @@
 				};
 
 				esdhc4: esdhc at 70024000 {
+					#address-cells = <1>;
+					#size-cells = <1>;
 					compatible = "fsl,imx51-esdhc";
 					reg = <0x70024000 0x4000>;
 					interrupts = <4>;
@@ -534,6 +542,8 @@
 			};
 
 			nfc: nand at 83fdb000 {
+				#address-cells = <1>;
+				#size-cells = <1>;
 				compatible = "fsl,imx51-nand";
 				reg = <0x83fdb000 0x1000 0xcfff0000 0x10000>;
 				interrupts = <8>;
@@ -542,6 +552,8 @@
 			};
 
 			pata: pata at 83fe0000 {
+				#address-cells = <1>;
+				#size-cells = <1>;
 				compatible = "fsl,imx51-pata", "fsl,imx27-pata";
 				reg = <0x83fe0000 0x4000>;
 				interrupts = <70>;
-- 
1.8.3.2
