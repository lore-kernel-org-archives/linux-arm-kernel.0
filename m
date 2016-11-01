From: stillcompiling@gmail.com (Joshua Clayton)
Date: Tue,  1 Nov 2016 16:51:45 -0700
Subject: [PATCH] ARM: dts: imx6: Add imx-weim parameters to dtsi's
Message-ID: <1478044305-5666-1-git-send-email-stillcompiling@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

imx-weim should always set address-cells to 2,
and size_cells to 1.
On imx6, fsl,weim-cs-gpr will always be &gpr

Set these common parameters in the dtsi file,
rather than in a downstream dts.

Signed-off-by: Joshua Clayton <stillcompiling@gmail.com>
---
 arch/arm/boot/dts/imx6q-evi.dts          | 3 ---
 arch/arm/boot/dts/imx6qdl-sabreauto.dtsi | 2 --
 arch/arm/boot/dts/imx6qdl.dtsi           | 3 +++
 arch/arm/boot/dts/imx6sl.dtsi            | 3 +++
 arch/arm/boot/dts/imx6sx.dtsi            | 3 +++
 5 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/imx6q-evi.dts b/arch/arm/boot/dts/imx6q-evi.dts
index bd0b85c..a88cbd8 100644
--- a/arch/arm/boot/dts/imx6q-evi.dts
+++ b/arch/arm/boot/dts/imx6q-evi.dts
@@ -241,10 +241,7 @@
 };
 
 &weim {
-	#address-cells = <2>;
-	#size-cells = <1>;
 	ranges = <0 0 0x08000000 0x08000000>;
-	fsl,weim-cs-gpr = <&gpr>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_weimfpga &pinctrl_weimcs>;
 	status = "okay";
diff --git a/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi b/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
index 8006467..52390ba 100644
--- a/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
@@ -613,8 +613,6 @@
 &weim {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_weim_nor &pinctrl_weim_cs0>;
-	#address-cells = <2>;
-	#size-cells = <1>;
 	ranges = <0 0 0x08000000 0x08000000>;
 	status = "disabled"; /* pin conflict with SPI NOR */
 
diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index 1bbd36f..d7bed1f 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -1092,10 +1092,13 @@
 			};
 
 			weim: weim at 021b8000 {
+				#address-cells = <2>;
+				#size-cells = <1>;
 				compatible = "fsl,imx6q-weim";
 				reg = <0x021b8000 0x4000>;
 				interrupts = <0 14 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks IMX6QDL_CLK_EIM_SLOW>;
+				fsl,weim-cs-gpr = <&gpr>;
 			};
 
 			ocotp: ocotp at 021bc000 {
diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
index 02378db..c2b28c0 100644
--- a/arch/arm/boot/dts/imx6sl.dtsi
+++ b/arch/arm/boot/dts/imx6sl.dtsi
@@ -893,8 +893,11 @@
 			};
 
 			weim: weim at 021b8000 {
+				#address-cells = <2>;
+				#size-cells = <1>;
 				reg = <0x021b8000 0x4000>;
 				interrupts = <0 14 IRQ_TYPE_LEVEL_HIGH>;
+				fsl,weim-cs-gpr = <&gpr>;
 			};
 
 			ocotp: ocotp at 021bc000 {
diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
index 9526c38..78eb023 100644
--- a/arch/arm/boot/dts/imx6sx.dtsi
+++ b/arch/arm/boot/dts/imx6sx.dtsi
@@ -968,10 +968,13 @@
 			};
 
 			weim: weim at 021b8000 {
+				#address-cells = <2>;
+				#size-cells = <1>;
 				compatible = "fsl,imx6sx-weim", "fsl,imx6q-weim";
 				reg = <0x021b8000 0x4000>;
 				interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks IMX6SX_CLK_EIM_SLOW>;
+				fsl,weim-cs-gpr = <&gpr>;
 			};
 
 			ocotp: ocotp at 021bc000 {
-- 
2.7.4
