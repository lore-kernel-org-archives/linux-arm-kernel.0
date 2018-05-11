From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 10 May 2018 21:16:48 -0300
Subject: [PATCH 1/3] ARM: dts: imx6/7: Remove unit-address from anatop
 regulators
Message-ID: <1525997810-10964-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

Remove unit-address and reg property from anatop regulators to fix
the following DTC warnings with W=1:

arch/arm/boot/dts/imx6dl-apf6dev.dtb: Warning (unique_unit_address): /soc/aips-bus at 2000000/anatop at 20c8000/regulator-vddcore at 20c8140: duplicate unit-address (also used in node /soc/aips-bus at 2000000/anatop at 20c8000/regulator-vddpu at 20c8140)
arch/arm/boot/dts/imx6dl-apf6dev.dtb: Warning (unique_unit_address): /soc/aips-bus at 2000000/anatop at 20c8000/regulator-vddcore at 20c8140: duplicate unit-address (also used in node /soc/aips-bus at 2000000/anatop at 20c8000/regulator-vddsoc at 20c8140)
arch/arm/boot/dts/imx6dl-apf6dev.dtb: Warning (unique_unit_address): /soc/aips-bus at 2000000/anatop at 20c8000/regulator-vddpu at 20c8140: duplicate unit-address (also used in node /soc/aips-bus at 2000000/anatop at 20c8000/regulator-vddsoc at 20c8140)

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/boot/dts/imx6qdl.dtsi | 20 ++++++--------------
 arch/arm/boot/dts/imx6sl.dtsi  | 20 ++++++--------------
 arch/arm/boot/dts/imx6sx.dtsi  | 20 ++++++--------------
 arch/arm/boot/dts/imx6ul.dtsi  | 11 +++--------
 arch/arm/boot/dts/imx7s.dtsi   |  8 ++------
 5 files changed, 23 insertions(+), 56 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index 69648e2..22942dd 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -692,11 +692,8 @@
 				interrupts = <0 49 IRQ_TYPE_LEVEL_HIGH>,
 					     <0 54 IRQ_TYPE_LEVEL_HIGH>,
 					     <0 127 IRQ_TYPE_LEVEL_HIGH>;
-				#address-cells = <1>;
-				#size-cells = <0>;
 
-				regulator-1p1 at 20c8110 {
-					reg = <0x20c8110>;
+				regulator-1p1 {
 					compatible = "fsl,anatop-regulator";
 					regulator-name = "vdd1p1";
 					regulator-min-microvolt = <1000000>;
@@ -711,8 +708,7 @@
 					anatop-enable-bit = <0>;
 				};
 
-				regulator-3p0 at 20c8120 {
-					reg = <0x20c8120>;
+				regulator-3p0 {
 					compatible = "fsl,anatop-regulator";
 					regulator-name = "vdd3p0";
 					regulator-min-microvolt = <2800000>;
@@ -727,8 +723,7 @@
 					anatop-enable-bit = <0>;
 				};
 
-				regulator-2p5 at 20c8130 {
-					reg = <0x20c8130>;
+				regulator-2p5 {
 					compatible = "fsl,anatop-regulator";
 					regulator-name = "vdd2p5";
 					regulator-min-microvolt = <2250000>;
@@ -743,8 +738,7 @@
 					anatop-enable-bit = <0>;
 				};
 
-				reg_arm: regulator-vddcore at 20c8140 {
-					reg = <0x20c8140>;
+				reg_arm: regulator-vddcore {
 					compatible = "fsl,anatop-regulator";
 					regulator-name = "vddarm";
 					regulator-min-microvolt = <725000>;
@@ -761,8 +755,7 @@
 					anatop-max-voltage = <1450000>;
 				};
 
-				reg_pu: regulator-vddpu at 20c8140 {
-					reg = <0x20c8140>;
+				reg_pu: regulator-vddpu {
 					compatible = "fsl,anatop-regulator";
 					regulator-name = "vddpu";
 					regulator-min-microvolt = <725000>;
@@ -779,8 +772,7 @@
 					anatop-max-voltage = <1450000>;
 				};
 
-				reg_soc: regulator-vddsoc at 20c8140 {
-					reg = <0x20c8140>;
+				reg_soc: regulator-vddsoc {
 					compatible = "fsl,anatop-regulator";
 					regulator-name = "vddsoc";
 					regulator-min-microvolt = <725000>;
diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
index 2002db2..8c838ba 100644
--- a/arch/arm/boot/dts/imx6sl.dtsi
+++ b/arch/arm/boot/dts/imx6sl.dtsi
@@ -524,11 +524,8 @@
 				interrupts = <0 49 IRQ_TYPE_LEVEL_HIGH>,
 					     <0 54 IRQ_TYPE_LEVEL_HIGH>,
 					     <0 127 IRQ_TYPE_LEVEL_HIGH>;
-				#address-cells = <1>;
-				#size-cells = <0>;
 
-				regulator-1p1 at 20c8110 {
-					reg = <0x20c8110>;
+				regulator-1p1 {
 					compatible = "fsl,anatop-regulator";
 					regulator-name = "vdd1p1";
 					regulator-min-microvolt = <800000>;
@@ -543,8 +540,7 @@
 					anatop-enable-bit = <0>;
 				};
 
-				regulator-3p0 at 20c8120 {
-					reg = <0x20c8120>;
+				regulator-3p0 {
 					compatible = "fsl,anatop-regulator";
 					regulator-name = "vdd3p0";
 					regulator-min-microvolt = <2800000>;
@@ -559,8 +555,7 @@
 					anatop-enable-bit = <0>;
 				};
 
-				regulator-2p5 at 20c8130 {
-					reg = <0x20c8130>;
+				regulator-2p5 {
 					compatible = "fsl,anatop-regulator";
 					regulator-name = "vdd2p5";
 					regulator-min-microvolt = <2100000>;
@@ -575,8 +570,7 @@
 					anatop-enable-bit = <0>;
 				};
 
-				reg_arm: regulator-vddcore at 20c8140 {
-					reg = <0x20c8140>;
+				reg_arm: regulator-vddcore {
 					compatible = "fsl,anatop-regulator";
 					regulator-name = "vddarm";
 					regulator-min-microvolt = <725000>;
@@ -593,8 +587,7 @@
 					anatop-max-voltage = <1450000>;
 				};
 
-				reg_pu: regulator-vddpu at 20c8140 {
-					reg = <0x20c8140>;
+				reg_pu: regulator-vddpu {
 					compatible = "fsl,anatop-regulator";
 					regulator-name = "vddpu";
 					regulator-min-microvolt = <725000>;
@@ -611,8 +604,7 @@
 					anatop-max-voltage = <1450000>;
 				};
 
-				reg_soc: regulator-vddsoc at 20c8140 {
-					reg = <0x20c8140>;
+				reg_soc: regulator-vddsoc {
 					compatible = "fsl,anatop-regulator";
 					regulator-name = "vddsoc";
 					regulator-min-microvolt = <725000>;
diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
index 7e463d2..4a97513 100644
--- a/arch/arm/boot/dts/imx6sx.dtsi
+++ b/arch/arm/boot/dts/imx6sx.dtsi
@@ -591,11 +591,8 @@
 				interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>,
 					     <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>,
 					     <GIC_SPI 127 IRQ_TYPE_LEVEL_HIGH>;
-				#address-cells = <1>;
-				#size-cells = <0>;
 
-				regulator-1p1 at 20c8110 {
-					reg = <0x20c8110>;
+				regulator-1p1 {
 					compatible = "fsl,anatop-regulator";
 					regulator-name = "vdd1p1";
 					regulator-min-microvolt = <800000>;
@@ -610,8 +607,7 @@
 					anatop-enable-bit = <0>;
 				};
 
-				regulator-3p0 at 20c8120 {
-					reg = <0x20c8120>;
+				regulator-3p0 {
 					compatible = "fsl,anatop-regulator";
 					regulator-name = "vdd3p0";
 					regulator-min-microvolt = <2800000>;
@@ -626,8 +622,7 @@
 					anatop-enable-bit = <0>;
 				};
 
-				regulator-2p5 at 20c8130 {
-					reg = <0x20c8130>;
+				regulator-2p5 {
 					compatible = "fsl,anatop-regulator";
 					regulator-name = "vdd2p5";
 					regulator-min-microvolt = <2100000>;
@@ -642,8 +637,7 @@
 					anatop-enable-bit = <0>;
 				};
 
-				reg_arm: regulator-vddcore at 20c8140 {
-					reg = <0x20c8140>;
+				reg_arm: regulator-vddcore {
 					compatible = "fsl,anatop-regulator";
 					regulator-name = "vddarm";
 					regulator-min-microvolt = <725000>;
@@ -660,8 +654,7 @@
 					anatop-max-voltage = <1450000>;
 				};
 
-				reg_pcie: regulator-vddpcie at 20c8140 {
-					reg = <0x20c8140>;
+				reg_pcie: regulator-vddpcie {
 					compatible = "fsl,anatop-regulator";
 					regulator-name = "vddpcie";
 					regulator-min-microvolt = <725000>;
@@ -677,8 +670,7 @@
 					anatop-max-voltage = <1450000>;
 				};
 
-				reg_soc: regulator-vddsoc at 20c8140 {
-					reg = <0x20c8140>;
+				reg_soc: regulator-vddsoc {
 					compatible = "fsl,anatop-regulator";
 					regulator-name = "vddsoc";
 					regulator-min-microvolt = <725000>;
diff --git a/arch/arm/boot/dts/imx6ul.dtsi b/arch/arm/boot/dts/imx6ul.dtsi
index 2b854d1..1818b6c 100644
--- a/arch/arm/boot/dts/imx6ul.dtsi
+++ b/arch/arm/boot/dts/imx6ul.dtsi
@@ -551,11 +551,8 @@
 				interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>,
 					     <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>,
 					     <GIC_SPI 127 IRQ_TYPE_LEVEL_HIGH>;
-				#address-cells = <1>;
-				#size-cells = <0>;
 
-				reg_3p0: regulator-3p0 at 20c8110 {
-					reg = <0x20c8110>;
+				reg_3p0: regulator-3p0 {
 					compatible = "fsl,anatop-regulator";
 					regulator-name = "vdd3p0";
 					regulator-min-microvolt = <2625000>;
@@ -569,8 +566,7 @@
 					anatop-enable-bit = <0>;
 				};
 
-				reg_arm: regulator-vddcore at 20c8140 {
-					reg = <0x20c8140>;
+				reg_arm: regulator-vddcore {
 					compatible = "fsl,anatop-regulator";
 					regulator-name = "cpu";
 					regulator-min-microvolt = <725000>;
@@ -587,8 +583,7 @@
 					anatop-max-voltage = <1450000>;
 				};
 
-				reg_soc: regulator-vddsoc at 20c8140 {
-					reg = <0x20c8140>;
+				reg_soc: regulator-vddsoc {
 					compatible = "fsl,anatop-regulator";
 					regulator-name = "vddsoc";
 					regulator-min-microvolt = <725000>;
diff --git a/arch/arm/boot/dts/imx7s.dtsi b/arch/arm/boot/dts/imx7s.dtsi
index b416d2b..99f92ec 100644
--- a/arch/arm/boot/dts/imx7s.dtsi
+++ b/arch/arm/boot/dts/imx7s.dtsi
@@ -557,11 +557,8 @@
 				reg = <0x30360000 0x10000>;
 				interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>,
 					<GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH>;
-				#address-cells = <1>;
-				#size-cells = <0>;
 
-				reg_1p0d: regulator-vdd1p0d at 30360210 {
-					reg = <0x30360210>;
+				reg_1p0d: regulator-vdd1p0d {
 					compatible = "fsl,anatop-regulator";
 					regulator-name = "vdd1p0d";
 					regulator-min-microvolt = <800000>;
@@ -575,8 +572,7 @@
 					anatop-enable-bit = <0>;
 				};
 
-				reg_1p2: regulator-vdd1p2 at 30360220 {
-					reg = <0x30360220>;
+				reg_1p2: regulator-vdd1p2 {
 					compatible = "fsl,anatop-regulator";
 					regulator-name = "vdd1p2";
 					regulator-min-microvolt = <1100000>;
-- 
2.7.4
