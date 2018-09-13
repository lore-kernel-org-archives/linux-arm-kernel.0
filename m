From: robh@kernel.org (Rob Herring)
Date: Thu, 13 Sep 2018 13:12:43 -0500
Subject: [PATCH] arm64: dts: fsl: Fix I2C and SPI bus warnings
Message-ID: <20180913181245.25484-19-robh@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

dtc has new checks for I2C and SPI buses. Fix the SPI bus node names
and warnings in unit-addresses.

arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dtb: Warning (i2c_bus_reg): /soc/i2c at 2180000/eeprom at 57: I2C bus unit address format error, expected "53"
arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dtb: Warning (i2c_bus_reg): /soc/i2c at 2180000/eeprom at 56: I2C bus unit address format error, expected "52"

Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Li Yang <leoyang.li@nxp.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
Please apply to the sub-arch tree. The dtc changes haven't landed, but 
will for 4.20.

 arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi    | 2 +-
 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi    | 6 +++---
 arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dts | 4 ++--
 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi    | 4 ++--
 arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi    | 4 ++--
 5 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
index 68ac78c4564d..5da732f82fa0 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
@@ -337,7 +337,7 @@
 			status = "disabled";
 		};
 
-		dspi: dspi at 2100000 {
+		dspi: spi at 2100000 {
 			compatible = "fsl,ls1012a-dspi", "fsl,ls1021a-v1.0-dspi";
 			#address-cells = <1>;
 			#size-cells = <0>;
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
index 7881e3d81a9a..b9c0f2de8f12 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
@@ -284,7 +284,7 @@
 			interrupts = <0 43 0x4>;
 		};
 
-		qspi: quadspi at 1550000 {
+		qspi: spi at 1550000 {
 			compatible = "fsl,ls1043a-qspi", "fsl,ls1021a-qspi";
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -382,7 +382,7 @@
 			ranges = <0x0 0x5 0x00000000 0x8000000>;
 		};
 
-		dspi0: dspi at 2100000 {
+		dspi0: spi at 2100000 {
 			compatible = "fsl,ls1043a-dspi", "fsl,ls1021a-v1.0-dspi";
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -395,7 +395,7 @@
 			status = "disabled";
 		};
 
-		dspi1: dspi at 2110000 {
+		dspi1: spi at 2110000 {
 			compatible = "fsl,ls1043a-dspi", "fsl,ls1021a-v1.0-dspi";
 			#address-cells = <1>;
 			#size-cells = <0>;
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dts
index 440e111651d5..a59b48203688 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dts
@@ -57,12 +57,12 @@
 		reg = <0x4c>;
 	};
 
-	eeprom at 56 {
+	eeprom at 52 {
 		compatible = "atmel,24c512";
 		reg = <0x52>;
 	};
 
-	eeprom at 57 {
+	eeprom at 53 {
 		compatible = "atmel,24c512";
 		reg = <0x53>;
 	};
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
index ef83786b8b90..de6af453a6e1 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
@@ -202,7 +202,7 @@
 			interrupts = <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
-		qspi: quadspi at 1550000 {
+		qspi: spi at 1550000 {
 			compatible = "fsl,ls1021a-qspi";
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -361,7 +361,7 @@
 			#thermal-sensor-cells = <1>;
 		};
 
-		dspi: dspi at 2100000 {
+		dspi: spi at 2100000 {
 			compatible = "fsl,ls1021a-v1.0-dspi";
 			#address-cells = <1>;
 			#size-cells = <0>;
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
index 8cb78dd99672..ebe0cd4bf2b7 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
@@ -469,7 +469,7 @@
 			mmu-masters = <&fsl_mc 0x300 0>;
 		};
 
-		dspi: dspi at 2100000 {
+		dspi: spi at 2100000 {
 			status = "disabled";
 			compatible = "fsl,ls2080a-dspi", "fsl,ls2085a-dspi";
 			#address-cells = <1>;
@@ -595,7 +595,7 @@
 				  3 0 0x5 0x20000000 0x00010000>;
 		};
 
-		qspi: quadspi at 20c0000 {
+		qspi: spi at 20c0000 {
 			status = "disabled";
 			compatible = "fsl,ls2080a-qspi", "fsl,ls1021a-qspi";
 			#address-cells = <1>;
-- 
2.17.1
