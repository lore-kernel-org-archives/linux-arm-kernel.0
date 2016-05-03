From: fabio.estevam@nxp.com (Fabio Estevam)
Date: Tue, 3 May 2016 10:57:31 -0300
Subject: [PATCH] ARM: dts: imx: Remove unneeded unit-addresses
Message-ID: <1462283851-10820-1-git-send-email-fabio.estevam@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Building with W=1 option leads to several warnings like:

Warning (unit_address_vs_reg): Node /soc/aips-bus at 02000000/anatop at 020c8000/regulator-1p1 at 110 has a unit name, but no reg property

Fix them by removing the unneeded unit-addresses.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/boot/dts/imx6sl.dtsi | 12 ++++++------
 arch/arm/boot/dts/imx6sx.dtsi | 12 ++++++------
 arch/arm/boot/dts/imx6ul.dtsi |  6 +++---
 arch/arm/boot/dts/imx7d.dtsi  |  2 +-
 4 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
index d12b250..224c0d0 100644
--- a/arch/arm/boot/dts/imx6sl.dtsi
+++ b/arch/arm/boot/dts/imx6sl.dtsi
@@ -461,7 +461,7 @@
 					     <0 54 IRQ_TYPE_LEVEL_HIGH>,
 					     <0 127 IRQ_TYPE_LEVEL_HIGH>;
 
-				regulator-1p1 at 110 {
+				regulator-1p1 {
 					compatible = "fsl,anatop-regulator";
 					regulator-name = "vdd1p1";
 					regulator-min-microvolt = <800000>;
@@ -475,7 +475,7 @@
 					anatop-max-voltage = <1375000>;
 				};
 
-				regulator-3p0 at 120 {
+				regulator-3p0 {
 					compatible = "fsl,anatop-regulator";
 					regulator-name = "vdd3p0";
 					regulator-min-microvolt = <2800000>;
@@ -489,7 +489,7 @@
 					anatop-max-voltage = <3400000>;
 				};
 
-				regulator-2p5 at 130 {
+				regulator-2p5 {
 					compatible = "fsl,anatop-regulator";
 					regulator-name = "vdd2p5";
 					regulator-min-microvolt = <2100000>;
@@ -503,7 +503,7 @@
 					anatop-max-voltage = <2850000>;
 				};
 
-				reg_arm: regulator-vddcore at 140 {
+				reg_arm: regulator-vddcore {
 					compatible = "fsl,anatop-regulator";
 					regulator-name = "vddarm";
 					regulator-min-microvolt = <725000>;
@@ -520,7 +520,7 @@
 					anatop-max-voltage = <1450000>;
 				};
 
-				reg_pu: regulator-vddpu at 140 {
+				reg_pu: regulator-vddpu {
 					compatible = "fsl,anatop-regulator";
 					regulator-name = "vddpu";
 					regulator-min-microvolt = <725000>;
@@ -537,7 +537,7 @@
 					anatop-max-voltage = <1450000>;
 				};
 
-				reg_soc: regulator-vddsoc at 140 {
+				reg_soc: regulator-vddsoc {
 					compatible = "fsl,anatop-regulator";
 					regulator-name = "vddsoc";
 					regulator-min-microvolt = <725000>;
diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
index 6a993bfda..2863c52 100644
--- a/arch/arm/boot/dts/imx6sx.dtsi
+++ b/arch/arm/boot/dts/imx6sx.dtsi
@@ -547,7 +547,7 @@
 					     <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>,
 					     <GIC_SPI 127 IRQ_TYPE_LEVEL_HIGH>;
 
-				regulator-1p1 at 110 {
+				regulator-1p1 {
 					compatible = "fsl,anatop-regulator";
 					regulator-name = "vdd1p1";
 					regulator-min-microvolt = <800000>;
@@ -561,7 +561,7 @@
 					anatop-max-voltage = <1375000>;
 				};
 
-				regulator-3p0 at 120 {
+				regulator-3p0 {
 					compatible = "fsl,anatop-regulator";
 					regulator-name = "vdd3p0";
 					regulator-min-microvolt = <2800000>;
@@ -575,7 +575,7 @@
 					anatop-max-voltage = <3400000>;
 				};
 
-				regulator-2p5 at 130 {
+				regulator-2p5 {
 					compatible = "fsl,anatop-regulator";
 					regulator-name = "vdd2p5";
 					regulator-min-microvolt = <2100000>;
@@ -589,7 +589,7 @@
 					anatop-max-voltage = <2875000>;
 				};
 
-				reg_arm: regulator-vddcore at 140 {
+				reg_arm: regulator-vddcore {
 					compatible = "fsl,anatop-regulator";
 					regulator-name = "vddarm";
 					regulator-min-microvolt = <725000>;
@@ -606,7 +606,7 @@
 					anatop-max-voltage = <1450000>;
 				};
 
-				reg_pcie: regulator-vddpcie at 140 {
+				reg_pcie: regulator-vddpcie {
 					compatible = "fsl,anatop-regulator";
 					regulator-name = "vddpcie";
 					regulator-min-microvolt = <725000>;
@@ -622,7 +622,7 @@
 					anatop-max-voltage = <1450000>;
 				};
 
-				reg_soc: regulator-vddsoc at 140 {
+				reg_soc: regulator-vddsoc {
 					compatible = "fsl,anatop-regulator";
 					regulator-name = "vddsoc";
 					regulator-min-microvolt = <725000>;
diff --git a/arch/arm/boot/dts/imx6ul.dtsi b/arch/arm/boot/dts/imx6ul.dtsi
index 4356b65..b15ed37 100644
--- a/arch/arm/boot/dts/imx6ul.dtsi
+++ b/arch/arm/boot/dts/imx6ul.dtsi
@@ -512,7 +512,7 @@
 					     <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>,
 					     <GIC_SPI 127 IRQ_TYPE_LEVEL_HIGH>;
 
-				reg_3p0: regulator-3p0 at 120 {
+				reg_3p0: regulator-3p0 {
 					compatible = "fsl,anatop-regulator";
 					regulator-name = "vdd3p0";
 					regulator-min-microvolt = <2625000>;
@@ -526,7 +526,7 @@
 					anatop-enable-bit = <0>;
 				};
 
-				reg_arm: regulator-vddcore at 140 {
+				reg_arm: regulator-vddcore {
 					compatible = "fsl,anatop-regulator";
 					regulator-name = "cpu";
 					regulator-min-microvolt = <725000>;
@@ -543,7 +543,7 @@
 					anatop-max-voltage = <1450000>;
 				};
 
-				reg_soc: regulator-vddsoc at 140 {
+				reg_soc: regulator-vddsoc {
 					compatible = "fsl,anatop-regulator";
 					regulator-name = "vddsoc";
 					regulator-min-microvolt = <725000>;
diff --git a/arch/arm/boot/dts/imx7d.dtsi b/arch/arm/boot/dts/imx7d.dtsi
index 6b3faa2..d70d55d 100644
--- a/arch/arm/boot/dts/imx7d.dtsi
+++ b/arch/arm/boot/dts/imx7d.dtsi
@@ -522,7 +522,7 @@
 				interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>,
 					<GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH>;
 
-				reg_1p0d: regulator-vdd1p0d at 210 {
+				reg_1p0d: regulator-vdd1p0d {
 					compatible = "fsl,anatop-regulator";
 					regulator-name = "vdd1p0d";
 					regulator-min-microvolt = <800000>;
-- 
1.9.1
