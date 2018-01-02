From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue,  2 Jan 2018 15:55:58 +0100
Subject: [PATCH v2 8/8] arm64: dts: marvell: replace cpm by cp0, cps by cp1
In-Reply-To: <20180102145558.9773-1-thomas.petazzoni@free-electrons.com>
References: <20180102145558.9773-1-thomas.petazzoni@free-electrons.com>
Message-ID: <20180102145558.9773-9-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In preparation for the introduction of more than 2 CPs in upcoming
SoCs, it makes sense to move away from the "CP master" (cpm) and "CP
slave" (cps) naming, and use instead cp0/cp1.

This commit is the result of:

 sed 's%cpm%cp0g%' arch/arm64/boot/dts/marvell/*
 sed 's%cps%cp1g%' arch/arm64/boot/dts/marvell/*

So it is a purely mechaninal change.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Suggested-by: Hanna Hawa <hannah@marvell.com>
---
 arch/arm64/boot/dts/marvell/armada-7040-db.dts    | 46 ++++++-------
 arch/arm64/boot/dts/marvell/armada-70x0.dtsi      | 18 ++---
 arch/arm64/boot/dts/marvell/armada-8020.dtsi      |  2 +-
 arch/arm64/boot/dts/marvell/armada-8040-db.dts    | 80 +++++++++++------------
 arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts | 76 ++++++++++-----------
 arch/arm64/boot/dts/marvell/armada-8040.dtsi      |  2 +-
 arch/arm64/boot/dts/marvell/armada-80x0.dtsi      | 34 +++++-----
 7 files changed, 129 insertions(+), 129 deletions(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-7040-db.dts b/arch/arm64/boot/dts/marvell/armada-7040-db.dts
index 52b5341cb270..44c95b97a422 100644
--- a/arch/arm64/boot/dts/marvell/armada-7040-db.dts
+++ b/arch/arm64/boot/dts/marvell/armada-7040-db.dts
@@ -61,7 +61,7 @@
 		reg = <0x0 0x0 0x0 0x80000000>;
 	};
 
-	cpm_reg_usb3_0_vbus: cpm-usb3-0-vbus {
+	cp0_reg_usb3_0_vbus: cp0-usb3-0-vbus {
 		compatible = "regulator-fixed";
 		regulator-name = "usb3h0-vbus";
 		regulator-min-microvolt = <5000000>;
@@ -70,7 +70,7 @@
 		gpio = <&expander0 0 GPIO_ACTIVE_HIGH>;
 	};
 
-	cpm_reg_usb3_1_vbus: cpm-usb3-1-vbus {
+	cp0_reg_usb3_1_vbus: cp0-usb3-1-vbus {
 		compatible = "regulator-fixed";
 		regulator-name = "usb3h1-vbus";
 		regulator-min-microvolt = <5000000>;
@@ -79,14 +79,14 @@
 		gpio = <&expander0 1 GPIO_ACTIVE_HIGH>;
 	};
 
-	cpm_usb3_0_phy: cpm-usb3-0-phy {
+	cp0_usb3_0_phy: cp0-usb3-0-phy {
 		compatible = "usb-nop-xceiv";
-		vcc-supply = <&cpm_reg_usb3_0_vbus>;
+		vcc-supply = <&cp0_reg_usb3_0_vbus>;
 	};
 
-	cpm_usb3_1_phy: cpm-usb3-1-phy {
+	cp0_usb3_1_phy: cp0-usb3-1-phy {
 		compatible = "usb-nop-xceiv";
-		vcc-supply = <&cpm_reg_usb3_1_vbus>;
+		vcc-supply = <&cp0_reg_usb3_1_vbus>;
 	};
 };
 
@@ -129,11 +129,11 @@
 };
 
 
-&cpm_pcie2 {
+&cp0_pcie2 {
 	status = "okay";
 };
 
-&cpm_i2c0 {
+&cp0_i2c0 {
 	status = "okay";
 	clock-frequency = <100000>;
 
@@ -156,7 +156,7 @@
 	};
 };
 
-&cpm_nand {
+&cp0_nand {
 	/*
 	 * SPI on CPM and NAND have common pins on this board. We can
 	 * use only one at a time. To enable the NAND (whihch will
@@ -186,7 +186,7 @@
 };
 
 
-&cpm_spi1 {
+&cp0_spi1 {
 	status = "okay";
 
 	spi-flash at 0 {
@@ -214,17 +214,17 @@
 	};
 };
 
-&cpm_sata0 {
+&cp0_sata0 {
 	status = "okay";
 };
 
-&cpm_usb3_0 {
-	usb-phy = <&cpm_usb3_0_phy>;
+&cp0_usb3_0 {
+	usb-phy = <&cp0_usb3_0_phy>;
 	status = "okay";
 };
 
-&cpm_usb3_1 {
-	usb-phy = <&cpm_usb3_1_phy>;
+&cp0_usb3_1 {
+	usb-phy = <&cp0_usb3_1_phy>;
 	status = "okay";
 };
 
@@ -235,14 +235,14 @@
 	non-removable;
 };
 
-&cpm_sdhci0 {
+&cp0_sdhci0 {
 	status = "okay";
 	bus-width = <4>;
 	no-1-8-v;
 	cd-gpios = <&expander0 12 GPIO_ACTIVE_LOW>;
 };
 
-&cpm_mdio {
+&cp0_mdio {
 	status = "okay";
 
 	phy0: ethernet-phy at 0 {
@@ -253,28 +253,28 @@
 	};
 };
 
-&cpm_ethernet {
+&cp0_ethernet {
 	status = "okay";
 };
 
-&cpm_eth0 {
+&cp0_eth0 {
 	status = "okay";
 	/* Network PHY */
 	phy-mode = "10gbase-kr";
 	/* Generic PHY, providing serdes lanes */
-	phys = <&cpm_comphy2 0>;
+	phys = <&cp0_comphy2 0>;
 };
 
-&cpm_eth1 {
+&cp0_eth1 {
 	status = "okay";
 	/* Network PHY */
 	phy = <&phy0>;
 	phy-mode = "sgmii";
 	/* Generic PHY, providing serdes lanes */
-	phys = <&cpm_comphy0 1>;
+	phys = <&cp0_comphy0 1>;
 };
 
-&cpm_eth2 {
+&cp0_eth2 {
 	status = "okay";
 	phy = <&phy1>;
 	phy-mode = "rgmii-id";
diff --git a/arch/arm64/boot/dts/marvell/armada-70x0.dtsi b/arch/arm64/boot/dts/marvell/armada-70x0.dtsi
index 9917cff3dae6..f63b4fbd642b 100644
--- a/arch/arm64/boot/dts/marvell/armada-70x0.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-70x0.dtsi
@@ -46,17 +46,17 @@
 
 / {
 	aliases {
-		gpio1 = &cpm_gpio1;
-		gpio2 = &cpm_gpio2;
-		spi1 = &cpm_spi0;
-		spi2 = &cpm_spi1;
+		gpio1 = &cp0_gpio1;
+		gpio2 = &cp0_gpio2;
+		spi1 = &cp0_spi0;
+		spi2 = &cp0_spi1;
 	};
 };
 
 /*
  * Instantiate the CP110
  */
-#define CP110_NAME		cpm
+#define CP110_NAME		cp0
 #define CP110_BASE		f2000000
 #define CP110_PCIE_IO_BASE	0xf9000000
 #define CP110_PCIE_MEM_BASE	0xf6000000
@@ -74,16 +74,16 @@
 #undef CP110_PCIE1_BASE
 #undef CP110_PCIE2_BASE
 
-&cpm_gpio1 {
+&cp0_gpio1 {
 	status = "okay";
 };
 
-&cpm_gpio2 {
+&cp0_gpio2 {
 	status = "okay";
 };
 
-&cpm_syscon0 {
-	cpm_pinctrl: pinctrl {
+&cp0_syscon0 {
+	cp0_pinctrl: pinctrl {
 		compatible = "marvell,armada-7k-pinctrl";
 
 		nand_pins: nand-pins {
diff --git a/arch/arm64/boot/dts/marvell/armada-8020.dtsi b/arch/arm64/boot/dts/marvell/armada-8020.dtsi
index 0ba0bc942598..3318d6b0214b 100644
--- a/arch/arm64/boot/dts/marvell/armada-8020.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-8020.dtsi
@@ -60,6 +60,6 @@
  * oscillator so this one is let enabled.
  */
 
-&cpm_rtc {
+&cp0_rtc {
 	status = "disabled";
 };
diff --git a/arch/arm64/boot/dts/marvell/armada-8040-db.dts b/arch/arm64/boot/dts/marvell/armada-8040-db.dts
index b1f6cccc5081..13e3209d554a 100644
--- a/arch/arm64/boot/dts/marvell/armada-8040-db.dts
+++ b/arch/arm64/boot/dts/marvell/armada-8040-db.dts
@@ -61,46 +61,46 @@
 		reg = <0x0 0x0 0x0 0x80000000>;
 	};
 
-	cpm_reg_usb3_0_vbus: cpm-usb3-0-vbus {
+	cp0_reg_usb3_0_vbus: cp0-usb3-0-vbus {
 		compatible = "regulator-fixed";
-		regulator-name = "cpm-usb3h0-vbus";
+		regulator-name = "cp0-usb3h0-vbus";
 		regulator-min-microvolt = <5000000>;
 		regulator-max-microvolt = <5000000>;
 		enable-active-high;
 		gpio = <&expander0 0 GPIO_ACTIVE_HIGH>;
 	};
 
-	cpm_reg_usb3_1_vbus: cpm-usb3-1-vbus {
+	cp0_reg_usb3_1_vbus: cp0-usb3-1-vbus {
 		compatible = "regulator-fixed";
-		regulator-name = "cpm-usb3h1-vbus";
+		regulator-name = "cp0-usb3h1-vbus";
 		regulator-min-microvolt = <5000000>;
 		regulator-max-microvolt = <5000000>;
 		enable-active-high;
 		gpio = <&expander0 1 GPIO_ACTIVE_HIGH>;
 	};
 
-	cpm_usb3_0_phy: cpm-usb3-0-phy {
+	cp0_usb3_0_phy: cp0-usb3-0-phy {
 		compatible = "usb-nop-xceiv";
-		vcc-supply = <&cpm_reg_usb3_0_vbus>;
+		vcc-supply = <&cp0_reg_usb3_0_vbus>;
 	};
 
-	cpm_usb3_1_phy: cpm-usb3-1-phy {
+	cp0_usb3_1_phy: cp0-usb3-1-phy {
 		compatible = "usb-nop-xceiv";
-		vcc-supply = <&cpm_reg_usb3_1_vbus>;
+		vcc-supply = <&cp0_reg_usb3_1_vbus>;
 	};
 
-	cps_reg_usb3_0_vbus: cps-usb3-0-vbus {
+	cp1_reg_usb3_0_vbus: cp1-usb3-0-vbus {
 		compatible = "regulator-fixed";
-		regulator-name = "cps-usb3h0-vbus";
+		regulator-name = "cp1-usb3h0-vbus";
 		regulator-min-microvolt = <5000000>;
 		regulator-max-microvolt = <5000000>;
 		enable-active-high;
 		gpio = <&expander1 0 GPIO_ACTIVE_HIGH>;
 	};
 
-	cps_usb3_0_phy: cps-usb3-0-phy {
+	cp1_usb3_0_phy: cp1-usb3-0-phy {
 		compatible = "usb-nop-xceiv";
-		vcc-supply = <&cps_reg_usb3_0_vbus>;
+		vcc-supply = <&cp1_reg_usb3_0_vbus>;
 	};
 };
 
@@ -144,16 +144,16 @@
 };
 
 /* CON6 on CP0 expansion */
-&cpm_pcie0 {
+&cp0_pcie0 {
 	status = "okay";
 };
 
 /* CON5 on CP0 expansion */
-&cpm_pcie2 {
+&cp0_pcie2 {
 	status = "okay";
 };
 
-&cpm_i2c0 {
+&cp0_i2c0 {
 	status = "okay";
 	clock-frequency = <100000>;
 
@@ -178,23 +178,23 @@
 };
 
 /* CON4 on CP0 expansion */
-&cpm_sata0 {
+&cp0_sata0 {
 	status = "okay";
 };
 
 /* CON9 on CP0 expansion */
-&cpm_usb3_0 {
-	usb-phy = <&cpm_usb3_0_phy>;
+&cp0_usb3_0 {
+	usb-phy = <&cp0_usb3_0_phy>;
 	status = "okay";
 };
 
 /* CON10 on CP0 expansion */
-&cpm_usb3_1 {
-	usb-phy = <&cpm_usb3_1_phy>;
+&cp0_usb3_1 {
+	usb-phy = <&cp0_usb3_1_phy>;
 	status = "okay";
 };
 
-&cpm_mdio {
+&cp0_mdio {
 	status = "okay";
 
 	phy1: ethernet-phy at 1 {
@@ -202,42 +202,42 @@
 	};
 };
 
-&cpm_ethernet {
+&cp0_ethernet {
 	status = "okay";
 };
 
-&cpm_eth0 {
+&cp0_eth0 {
 	status = "okay";
 	phy-mode = "10gbase-kr";
 };
 
-&cpm_eth2 {
+&cp0_eth2 {
 	status = "okay";
 	phy = <&phy1>;
 	phy-mode = "rgmii-id";
 };
 
 /* CON6 on CP1 expansion */
-&cps_pcie0 {
+&cp1_pcie0 {
 	status = "okay";
 };
 
 /* CON7 on CP1 expansion */
-&cps_pcie1 {
+&cp1_pcie1 {
 	status = "okay";
 };
 
 /* CON5 on CP1 expansion */
-&cps_pcie2 {
+&cp1_pcie2 {
 	status = "okay";
 };
 
-&cps_i2c0 {
+&cp1_i2c0 {
 	status = "okay";
 	clock-frequency = <100000>;
 };
 
-&cps_spi1 {
+&cp1_spi1 {
 	status = "okay";
 
 	spi-flash at 0 {
@@ -272,14 +272,14 @@
  * Proper NAND usage will require DPR-76 to be in position 1-2, which disables
  * MDIO signal of CP1.
  */
-&cps_nand {
+&cp1_nand {
 	num-cs = <1>;
 	pinctrl-0 = <&nand_pins>, <&nand_rb>;
 	pinctrl-names = "default";
 	nand-ecc-strength = <4>;
 	nand-ecc-step-size = <512>;
 	marvell,nand-enable-arbiter;
-	marvell,system-controller = <&cps_syscon0>;
+	marvell,system-controller = <&cp1_syscon0>;
 	nand-on-flash-bbt;
 
 	partition at 0 {
@@ -297,22 +297,22 @@
 };
 
 /* CON4 on CP1 expansion */
-&cps_sata0 {
+&cp1_sata0 {
 	status = "okay";
 };
 
 /* CON9 on CP1 expansion */
-&cps_usb3_0 {
-	usb-phy = <&cps_usb3_0_phy>;
+&cp1_usb3_0 {
+	usb-phy = <&cp1_usb3_0_phy>;
 	status = "okay";
 };
 
 /* CON10 on CP1 expansion */
-&cps_usb3_1 {
+&cp1_usb3_1 {
 	status = "okay";
 };
 
-&cps_mdio {
+&cp1_mdio {
 	status = "okay";
 
 	phy0: ethernet-phy at 0 {
@@ -320,16 +320,16 @@
 	};
 };
 
-&cps_ethernet {
+&cp1_ethernet {
 	status = "okay";
 };
 
-&cps_eth0 {
+&cp1_eth0 {
 	status = "okay";
 	phy-mode = "10gbase-kr";
 };
 
-&cps_eth1 {
+&cp1_eth1 {
 	status = "okay";
 	phy = <&phy0>;
 	phy-mode = "rgmii-id";
@@ -341,7 +341,7 @@
 	non-removable;
 };
 
-&cpm_sdhci0 {
+&cp0_sdhci0 {
 	status = "okay";
 	bus-width = <8>;
 	non-removable;
diff --git a/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts b/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts
index b3350827ee55..c7aca67bd244 100644
--- a/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts
+++ b/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts
@@ -84,9 +84,9 @@
 	v_5v0_usb3_hst_vbus: regulator-usb3-vbus0 {
 		compatible = "regulator-fixed";
 		enable-active-high;
-		gpio = <&cpm_gpio2 15 GPIO_ACTIVE_HIGH>;
+		gpio = <&cp0_gpio2 15 GPIO_ACTIVE_HIGH>;
 		pinctrl-names = "default";
-		pinctrl-0 = <&cpm_xhci_vbus_pins>;
+		pinctrl-0 = <&cp0_xhci_vbus_pins>;
 		regulator-name = "v_5v0_usb3_hst_vbus";
 		regulator-min-microvolt = <5000000>;
 		regulator-max-microvolt = <5000000>;
@@ -120,17 +120,17 @@
 	vqmmc-supply = <&v_vddo_h>;
 };
 
-&cpm_i2c0 {
+&cp0_i2c0 {
 	clock-frequency = <100000>;
 	pinctrl-names = "default";
-	pinctrl-0 = <&cpm_i2c0_pins>;
+	pinctrl-0 = <&cp0_i2c0_pins>;
 	status = "okay";
 };
 
-&cpm_i2c1 {
+&cp0_i2c1 {
 	clock-frequency = <100000>;
 	pinctrl-names = "default";
-	pinctrl-0 = <&cpm_i2c1_pins>;
+	pinctrl-0 = <&cp0_i2c1_pins>;
 	status = "okay";
 
 	i2c-switch at 70 {
@@ -157,9 +157,9 @@
 	};
 };
 
-&cpm_mdio {
+&cp0_mdio {
 	pinctrl-names = "default";
-	pinctrl-0 = <&cpm_ge_mdio_pins>;
+	pinctrl-0 = <&cp0_ge_mdio_pins>;
 	status = "okay";
 
 	ge_phy: ethernet-phy at 0 {
@@ -167,44 +167,44 @@
 	};
 };
 
-&cpm_pcie0 {
+&cp0_pcie0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&cpm_pcie_pins>;
+	pinctrl-0 = <&cp0_pcie_pins>;
 	num-lanes = <4>;
 	num-viewport = <8>;
-	reset-gpio = <&cpm_gpio1 20 GPIO_ACTIVE_LOW>;
+	reset-gpio = <&cp0_gpio1 20 GPIO_ACTIVE_LOW>;
 	status = "okay";
 };
 
-&cpm_pinctrl {
-	cpm_ge_mdio_pins: ge-mdio-pins {
+&cp0_pinctrl {
+	cp0_ge_mdio_pins: ge-mdio-pins {
 		marvell,pins = "mpp32", "mpp34";
 		marvell,function = "ge";
 	};
-	cpm_i2c1_pins: i2c1-pins {
+	cp0_i2c1_pins: i2c1-pins {
 		marvell,pins = "mpp35", "mpp36";
 		marvell,function = "i2c1";
 	};
-	cpm_i2c0_pins: i2c0-pins {
+	cp0_i2c0_pins: i2c0-pins {
 		marvell,pins = "mpp37", "mpp38";
 		marvell,function = "i2c0";
 	};
-	cpm_xhci_vbus_pins: xhci0-vbus-pins {
+	cp0_xhci_vbus_pins: xhci0-vbus-pins {
 		marvell,pins = "mpp47";
 		marvell,function = "gpio";
 	};
-	cpm_pcie_pins: pcie-pins {
+	cp0_pcie_pins: pcie-pins {
 		marvell,pins = "mpp52";
 		marvell,function = "gpio";
 	};
-	cpm_sdhci_pins: sdhci-pins {
+	cp0_sdhci_pins: sdhci-pins {
 		marvell,pins = "mpp55", "mpp56", "mpp57", "mpp58", "mpp59",
 			       "mpp60", "mpp61";
 		marvell,function = "sdio";
 	};
 };
 
-&cpm_xmdio {
+&cp0_xmdio {
 	status = "okay";
 
 	phy0: ethernet-phy at 0 {
@@ -218,83 +218,83 @@
 	};
 };
 
-&cpm_ethernet {
+&cp0_ethernet {
 	status = "okay";
 };
 
-&cpm_eth0 {
+&cp0_eth0 {
 	status = "okay";
 	/* Network PHY */
 	phy = <&phy0>;
 	phy-mode = "10gbase-kr";
 	/* Generic PHY, providing serdes lanes */
-	phys = <&cpm_comphy4 0>;
+	phys = <&cp0_comphy4 0>;
 };
 
-&cpm_sata0 {
+&cp0_sata0 {
 	/* CPM Lane 0 - U29 */
 	status = "okay";
 };
 
-&cpm_sdhci0 {
+&cp0_sdhci0 {
 	/* U6 */
 	broken-cd;
 	bus-width = <4>;
 	pinctrl-names = "default";
-	pinctrl-0 = <&cpm_sdhci_pins>;
+	pinctrl-0 = <&cp0_sdhci_pins>;
 	status = "okay";
 	vqmmc-supply = <&v_3_3>;
 };
 
-&cpm_usb3_0 {
+&cp0_usb3_0 {
 	/* J38? - USB2.0 only */
 	status = "okay";
 };
 
-&cpm_usb3_1 {
+&cp0_usb3_1 {
 	/* J38? - USB2.0 only */
 	status = "okay";
 };
 
-&cps_ethernet {
+&cp1_ethernet {
 	status = "okay";
 };
 
-&cps_eth0 {
+&cp1_eth0 {
 	status = "okay";
 	/* Network PHY */
 	phy = <&phy8>;
 	phy-mode = "10gbase-kr";
 	/* Generic PHY, providing serdes lanes */
-	phys = <&cps_comphy4 0>;
+	phys = <&cp1_comphy4 0>;
 };
 
-&cps_eth1 {
+&cp1_eth1 {
 	/* CPS Lane 0 - J5 (Gigabit RJ45) */
 	status = "okay";
 	/* Network PHY */
 	phy = <&ge_phy>;
 	phy-mode = "sgmii";
 	/* Generic PHY, providing serdes lanes */
-	phys = <&cps_comphy0 1>;
+	phys = <&cp1_comphy0 1>;
 };
 
-&cps_pinctrl {
-	cps_spi1_pins: spi1-pins {
+&cp1_pinctrl {
+	cp1_spi1_pins: spi1-pins {
 		marvell,pins = "mpp12", "mpp13", "mpp14", "mpp15", "mpp16";
 		marvell,function = "spi1";
 	};
 };
 
-&cps_sata0 {
+&cp1_sata0 {
 	/* CPS Lane 1 - U32 */
 	/* CPS Lane 3 - U31 */
 	status = "okay";
 };
 
-&cps_spi1 {
+&cp1_spi1 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&cps_spi1_pins>;
+	pinctrl-0 = <&cp1_spi1_pins>;
 	status = "okay";
 
 	spi-flash at 0 {
@@ -304,7 +304,7 @@
 	};
 };
 
-&cps_usb3_0 {
+&cp1_usb3_0 {
 	/* CPS Lane 2 - CON7 */
 	usb-phy = <&usb3h0_phy>;
 	status = "okay";
diff --git a/arch/arm64/boot/dts/marvell/armada-8040.dtsi b/arch/arm64/boot/dts/marvell/armada-8040.dtsi
index 60fe84f5cbcc..83d2b40e5981 100644
--- a/arch/arm64/boot/dts/marvell/armada-8040.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-8040.dtsi
@@ -59,6 +59,6 @@
  * disable it. However, the RTC clock in CP slave is connected to the
  * oscillator so this one is let enabled.
  */
-&cpm_rtc {
+&cp0_rtc {
 	status = "disabled";
 };
diff --git a/arch/arm64/boot/dts/marvell/armada-80x0.dtsi b/arch/arm64/boot/dts/marvell/armada-80x0.dtsi
index 5e038e7b7b30..0d36b0fa7153 100644
--- a/arch/arm64/boot/dts/marvell/armada-80x0.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-80x0.dtsi
@@ -46,19 +46,19 @@
 
 / {
 	aliases {
-		gpio1 = &cps_gpio1;
-		gpio2 = &cpm_gpio2;
-		spi1 = &cpm_spi0;
-		spi2 = &cpm_spi1;
-		spi3 = &cps_spi0;
-		spi4 = &cps_spi1;
+		gpio1 = &cp1_gpio1;
+		gpio2 = &cp0_gpio2;
+		spi1 = &cp0_spi0;
+		spi2 = &cp0_spi1;
+		spi3 = &cp1_spi0;
+		spi4 = &cp1_spi1;
 	};
 };
 
 /*
  * Instantiate the master CP110
  */
-#define CP110_NAME		cpm
+#define CP110_NAME		cp0
 #define CP110_BASE		f2000000
 #define CP110_PCIE_IO_BASE	0xf9000000
 #define CP110_PCIE_MEM_BASE	0xf6000000
@@ -79,7 +79,7 @@
 /*
  * Instantiate the slave CP110
  */
-#define CP110_NAME		cps
+#define CP110_NAME		cp1
 #define CP110_BASE		f4000000
 #define CP110_PCIE_IO_BASE	0xfd000000
 #define CP110_PCIE_MEM_BASE	0xfa000000
@@ -98,23 +98,23 @@
 #undef CP110_PCIE2_BASE
 
 /* The 80x0 has two CP blocks, but uses only one block from each. */
-&cps_gpio1 {
+&cp1_gpio1 {
 	status = "okay";
 };
 
-&cpm_gpio2 {
+&cp0_gpio2 {
 	status = "okay";
 };
 
-&cpm_syscon0 {
-	cpm_pinctrl: pinctrl {
-		compatible = "marvell,armada-8k-cpm-pinctrl";
+&cp0_syscon0 {
+	cp0_pinctrl: pinctrl {
+		compatible = "marvell,armada-8k-cp0-pinctrl";
 	};
 };
 
-&cps_syscon0 {
-	cps_pinctrl: pinctrl {
-		compatible = "marvell,armada-8k-cps-pinctrl";
+&cp1_syscon0 {
+	cp1_pinctrl: pinctrl {
+		compatible = "marvell,armada-8k-cp1-pinctrl";
 
 		nand_pins: nand-pins {
 			marvell,pins =
@@ -135,7 +135,7 @@
 	};
 };
 
-&cps_crypto {
+&cp1_crypto {
 	/*
 	 * The cryptographic engine found on the cp110
 	 * master is enabled by default at the SoC
-- 
2.14.3
