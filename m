From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 21 Mar 2017 19:28:36 +0100
Subject: [PATCH v2 7/7] ARM64: dts: marvell: armada37xx: add pinctrl definition
In-Reply-To: <cover.26288667a039bc9f8e62dec2fd6342ded4014d12.1490120798.git-series.gregory.clement@free-electrons.com>
References: <cover.26288667a039bc9f8e62dec2fd6342ded4014d12.1490120798.git-series.gregory.clement@free-electrons.com>
Message-ID: <1c9137fbb2ffe2b2a87f765d8f47f3bdef151a4b.1490120798.git-series.gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Start to populate the device tree of the Armada 37xx with the pincontrol
configuration used on the board providing a dts.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm64/boot/dts/marvell/armada-3720-db.dts |  8 +++++-
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi   | 31 +++++++++++++++++++-
 2 files changed, 39 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-3720-db.dts b/arch/arm64/boot/dts/marvell/armada-3720-db.dts
index 86602c907a61..e749c5727490 100644
--- a/arch/arm64/boot/dts/marvell/armada-3720-db.dts
+++ b/arch/arm64/boot/dts/marvell/armada-3720-db.dts
@@ -63,6 +63,8 @@
 };
 
 &i2c0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c1_pins>;
 	status = "okay";
 };
 
@@ -73,6 +75,8 @@
 
 &spi0 {
 	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&spi_quad_pins>;
 
 	m25p80 at 0 {
 		compatible = "jedec,spi-nor";
@@ -103,6 +107,8 @@
 
 /* Exported on the micro USB connector CON32 through an FTDI */
 &uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart1_pins>;
 	status = "okay";
 };
 
@@ -128,6 +134,8 @@
 };
 
 &eth0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&rgmii_pins>;
 	phy-mode = "rgmii-id";
 	phy = <&phy0>;
 	status = "okay";
diff --git a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
index 229946c57a07..dbc842d9310f 100644
--- a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
@@ -185,6 +185,31 @@
 					clock-output-names = "xtal";
 					#clock-cells = <0>;
 				};
+
+				spi_quad_pins: spi-quad-pins {
+					groups = "spi_quad";
+					function = "spi";
+				};
+
+				i2c1_pins: i2c1-pins {
+					groups = "i2c1";
+					function = "i2c";
+				};
+
+				i2c2_pins: i2c2-pins {
+					groups = "i2c2";
+					function = "i2c";
+				};
+
+				uart1_pins: uart1-pins {
+					groups = "uart1";
+					function = "uart";
+				};
+
+				uart2_pins: uart2-pins {
+					groups = "uart2";
+					function = "uart";
+				};
 			};
 
 			pinctrl_sb: pinctrl-sb at 18800 {
@@ -201,6 +226,12 @@
 					<GIC_SPI 157 IRQ_TYPE_LEVEL_HIGH>,
 					<GIC_SPI 156 IRQ_TYPE_LEVEL_HIGH>;
 				};
+
+				rgmii_pins: mii-pins {
+					groups = "rgmii";
+					function = "mii";
+				};
+
 			};
 
 			eth0: ethernet at 30000 {
-- 
git-series 0.9.1
