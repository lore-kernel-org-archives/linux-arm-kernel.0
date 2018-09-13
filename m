From: robh@kernel.org (Rob Herring)
Date: Thu, 13 Sep 2018 13:12:25 -0500
Subject: [PATCH] ARM: dts: ti: Fix SPI and I2C bus warnings
Message-ID: <20180913181245.25484-1-robh@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

dtc has new checks for I2C and SPI buses. Fix the warnings in node names
and unit-addresses.

arch/arm/boot/dts/am437x-idk-evm.dtb: Warning (spi_bus_bridge): /ocp at 44000000/qspi at 47900000: node name for SPI buses should be 'spi'
arch/arm/boot/dts/am437x-sk-evm.dtb: Warning (spi_bus_bridge): /ocp at 44000000/qspi at 47900000: node name for SPI buses should be 'spi'
arch/arm/boot/dts/am43x-epos-evm.dtb: Warning (spi_bus_bridge): /ocp at 44000000/qspi at 47900000: node name for SPI buses should be 'spi'
arch/arm/boot/dts/omap3-n9.dtb: Warning (i2c_bus_reg): /ocp at 68000000/i2c at 48060000/ak8975 at 0f: I2C bus unit address format error, expected "f"
arch/arm/boot/dts/am335x-osd3358-sm-red.dtb: Warning (i2c_bus_reg): /ocp/i2c at 44e0b000/pressure at 78: I2C bus unit address format error, expected "76"
arch/arm/boot/dts/am335x-boneblack.dtb: Warning (i2c_bus_reg): /ocp/i2c at 44e0b000/tda19988: I2C bus unit address format error, expected "70"
arch/arm/boot/dts/am335x-boneblack-wireless.dtb: Warning (i2c_bus_reg): /ocp/i2c at 44e0b000/tda19988: I2C bus unit address format error, expected "70"
arch/arm/boot/dts/am335x-sancloud-bbe.dtb: Warning (i2c_bus_reg): /ocp/i2c at 44e0b000/tda19988: I2C bus unit address format error, expected "70"
arch/arm/boot/dts/am571x-idk.dtb: Warning (spi_bus_bridge): /ocp/qspi at 4b300000: node name for SPI buses should be 'spi'
arch/arm/boot/dts/am572x-idk.dtb: Warning (spi_bus_bridge): /ocp/qspi at 4b300000: node name for SPI buses should be 'spi'
arch/arm/boot/dts/am574x-idk.dtb: Warning (spi_bus_bridge): /ocp/qspi at 4b300000: node name for SPI buses should be 'spi'
arch/arm/boot/dts/am57xx-cl-som-am57x.dtb: Warning (spi_bus_bridge): /ocp/qspi at 4b300000: node name for SPI buses should be 'spi'
arch/arm/boot/dts/am57xx-sbc-am57x.dtb: Warning (spi_bus_bridge): /ocp/qspi at 4b300000: node name for SPI buses should be 'spi'
arch/arm/boot/dts/dra72-evm.dtb: Warning (spi_bus_bridge): /ocp/qspi at 4b300000: node name for SPI buses should be 'spi'
arch/arm/boot/dts/dra72-evm-revc.dtb: Warning (spi_bus_bridge): /ocp/qspi at 4b300000: node name for SPI buses should be 'spi'
arch/arm/boot/dts/dra76-evm.dtb: Warning (spi_bus_bridge): /ocp/qspi at 4b300000: node name for SPI buses should be 'spi'
arch/arm/boot/dts/dra7-evm.dtb: Warning (spi_bus_bridge): /ocp/qspi at 4b300000: node name for SPI buses should be 'spi'
arch/arm/boot/dts/am335x-pdu001.dtb: Warning (spi_bus_reg): /ocp/spi at 481a0000/cfaf240320a032t: SPI bus unit address format error, expected "0"
arch/arm/boot/dts/keystone-k2g-evm.dtb: Warning (spi_bus_bridge): /soc at 0/qspi at 2940000: node name for SPI buses should be 'spi'
arch/arm/boot/dts/keystone-k2g-ice.dtb: Warning (spi_bus_bridge): /soc at 0/qspi at 2940000: node name for SPI buses should be 'spi'

Cc: "Beno?t Cousson" <bcousson@baylibre.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Santosh Shilimkar <ssantosh@kernel.org>
Cc: linux-omap at vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
Please apply to the sub-arch tree. The dtc changes haven't landed, but 
will for 4.20.

 arch/arm/boot/dts/am335x-boneblack-common.dtsi | 2 +-
 arch/arm/boot/dts/am335x-osd3358-sm-red.dts    | 2 +-
 arch/arm/boot/dts/am335x-pdu001.dts            | 2 +-
 arch/arm/boot/dts/am4372.dtsi                  | 2 +-
 arch/arm/boot/dts/am57xx-cl-som-am57x.dts      | 2 +-
 arch/arm/boot/dts/dra7.dtsi                    | 2 +-
 arch/arm/boot/dts/keystone-k2g.dtsi            | 2 +-
 arch/arm/boot/dts/omap2.dtsi                   | 4 ++--
 arch/arm/boot/dts/omap2430.dtsi                | 2 +-
 arch/arm/boot/dts/omap3-n9.dts                 | 2 +-
 10 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-boneblack-common.dtsi b/arch/arm/boot/dts/am335x-boneblack-common.dtsi
index 325daae40278..21bc1173fa6b 100644
--- a/arch/arm/boot/dts/am335x-boneblack-common.dtsi
+++ b/arch/arm/boot/dts/am335x-boneblack-common.dtsi
@@ -88,7 +88,7 @@
 };
 
 &i2c0 {
-	tda19988: tda19988 {
+	tda19988: tda19988 at 70 {
 		compatible = "nxp,tda998x";
 		reg = <0x70>;
 
diff --git a/arch/arm/boot/dts/am335x-osd3358-sm-red.dts b/arch/arm/boot/dts/am335x-osd3358-sm-red.dts
index 4d969013f99a..d9e92671055b 100644
--- a/arch/arm/boot/dts/am335x-osd3358-sm-red.dts
+++ b/arch/arm/boot/dts/am335x-osd3358-sm-red.dts
@@ -161,7 +161,7 @@
 		invensense,key = [4e cc 7e eb f6 1e 35 22 00 34 0d 65 32 e9 94 89];*/
 	};
 
-	bmp280: pressure at 78 {
+	bmp280: pressure at 76 {
 		compatible = "bosch,bmp280";
 		reg = <0x76>;
 	};
diff --git a/arch/arm/boot/dts/am335x-pdu001.dts b/arch/arm/boot/dts/am335x-pdu001.dts
index 1ad530a39a95..34fb63ef420f 100644
--- a/arch/arm/boot/dts/am335x-pdu001.dts
+++ b/arch/arm/boot/dts/am335x-pdu001.dts
@@ -373,7 +373,7 @@
 	ti,pindir-d0-out-d1-in;
 	status = "okay";
 
-	cfaf240320a032t {
+	display-controller at 0 {
 		compatible = "orisetech,otm3225a";
 		reg = <0>;
 		spi-max-frequency = <1000000>;
diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
index d4b7c59eec68..a68e89dae7a1 100644
--- a/arch/arm/boot/dts/am4372.dtsi
+++ b/arch/arm/boot/dts/am4372.dtsi
@@ -1101,7 +1101,7 @@
 			};
 		};
 
-		qspi: qspi at 47900000 {
+		qspi: spi at 47900000 {
 			compatible = "ti,am4372-qspi";
 			reg = <0x47900000 0x100>,
 			      <0x30000000 0x4000000>;
diff --git a/arch/arm/boot/dts/am57xx-cl-som-am57x.dts b/arch/arm/boot/dts/am57xx-cl-som-am57x.dts
index 203266f88480..52ae8eef60fc 100644
--- a/arch/arm/boot/dts/am57xx-cl-som-am57x.dts
+++ b/arch/arm/boot/dts/am57xx-cl-som-am57x.dts
@@ -518,7 +518,7 @@
 	};
 
 	/* touch controller */
-	ads7846 at 0 {
+	touchscreen at 1 {
 		pinctrl-names = "default";
 		pinctrl-0 = <&ads7846_pins>;
 
diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index a0ddf497e8cd..160c1c454b9c 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -1369,7 +1369,7 @@
 			status = "disabled";
 		};
 
-		qspi: qspi at 4b300000 {
+		qspi: spi at 4b300000 {
 			compatible = "ti,dra7xxx-qspi";
 			reg = <0x4b300000 0x100>,
 			      <0x5c000000 0x4000000>;
diff --git a/arch/arm/boot/dts/keystone-k2g.dtsi b/arch/arm/boot/dts/keystone-k2g.dtsi
index 738b44cf2b0b..1c833105d6c5 100644
--- a/arch/arm/boot/dts/keystone-k2g.dtsi
+++ b/arch/arm/boot/dts/keystone-k2g.dtsi
@@ -416,7 +416,7 @@
 			clock-names = "fck", "mmchsdb_fck";
 		};
 
-		qspi: qspi at 2940000 {
+		qspi: spi at 2940000 {
 			compatible = "ti,k2g-qspi", "cdns,qspi-nor";
 			#address-cells = <1>;
 			#size-cells = <0>;
diff --git a/arch/arm/boot/dts/omap2.dtsi b/arch/arm/boot/dts/omap2.dtsi
index f1d6de8b3c19..000bf16de651 100644
--- a/arch/arm/boot/dts/omap2.dtsi
+++ b/arch/arm/boot/dts/omap2.dtsi
@@ -114,7 +114,7 @@
 			dma-names = "tx", "rx";
 		};
 
-		mcspi1: mcspi at 48098000 {
+		mcspi1: spi at 48098000 {
 			compatible = "ti,omap2-mcspi";
 			ti,hwmods = "mcspi1";
 			reg = <0x48098000 0x100>;
@@ -125,7 +125,7 @@
 				    "tx2", "rx2", "tx3", "rx3";
 		};
 
-		mcspi2: mcspi at 4809a000 {
+		mcspi2: spi at 4809a000 {
 			compatible = "ti,omap2-mcspi";
 			ti,hwmods = "mcspi2";
 			reg = <0x4809a000 0x100>;
diff --git a/arch/arm/boot/dts/omap2430.dtsi b/arch/arm/boot/dts/omap2430.dtsi
index 84635eeb99cd..7f57af2f10ac 100644
--- a/arch/arm/boot/dts/omap2430.dtsi
+++ b/arch/arm/boot/dts/omap2430.dtsi
@@ -285,7 +285,7 @@
 			ti,timer-alwon;
 		};
 
-		mcspi3: mcspi at 480b8000 {
+		mcspi3: spi at 480b8000 {
 			compatible = "ti,omap2-mcspi";
 			ti,hwmods = "mcspi3";
 			reg = <0x480b8000 0x100>;
diff --git a/arch/arm/boot/dts/omap3-n9.dts b/arch/arm/boot/dts/omap3-n9.dts
index ded5fcf084eb..1f91646b8951 100644
--- a/arch/arm/boot/dts/omap3-n9.dts
+++ b/arch/arm/boot/dts/omap3-n9.dts
@@ -40,7 +40,7 @@
 };
 
 &i2c3 {
-	ak8975 at 0f {
+	ak8975 at f {
 		compatible = "asahi-kasei,ak8975";
 		reg = <0x0f>;
 	};
-- 
2.17.1
