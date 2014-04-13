From: shc_work@mail.ru (Alexander Shiyan)
Date: Sun, 13 Apr 2014 10:59:48 +0400
Subject: [PATCH 1/2] ARM: dts: i.MX27: Allow to define partitions onto SDHC
Message-ID: <1397372389-32016-1-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch allow to define partitions onto SDHC in user defined
devicetrees.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/boot/dts/imx27.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/imx27.dtsi b/arch/arm/boot/dts/imx27.dtsi
index 83a8247..843aefc 100644
--- a/arch/arm/boot/dts/imx27.dtsi
+++ b/arch/arm/boot/dts/imx27.dtsi
@@ -263,6 +263,8 @@
 			};
 
 			sdhci1: sdhci at 10013000 {
+				#address-cells = <1>;
+				#size-cells = <1>;
 				compatible = "fsl,imx27-mmc", "fsl,imx21-mmc";
 				reg = <0x10013000 0x1000>;
 				interrupts = <11>;
@@ -274,6 +276,8 @@
 			};
 
 			sdhci2: sdhci at 10014000 {
+				#address-cells = <1>;
+				#size-cells = <1>;
 				compatible = "fsl,imx27-mmc", "fsl,imx21-mmc";
 				reg = <0x10014000 0x1000>;
 				interrupts = <10>;
@@ -416,6 +420,8 @@
 			};
 
 			sdhci3: sdhci at 1001e000 {
+				#address-cells = <1>;
+				#size-cells = <1>;
 				compatible = "fsl,imx27-mmc", "fsl,imx21-mmc";
 				reg = <0x1001e000 0x1000>;
 				interrupts = <9>;
-- 
1.8.3.2
