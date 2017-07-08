From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Sat, 08 Jul 2017 20:16:39 +0100
Subject: [PATCH 3/6] arm64: dts: marvell: mcbin: add pinctrl nodes
In-Reply-To: <20170708191317.GM4902@n2100.armlinux.org.uk>
References: <20170708191317.GM4902@n2100.armlinux.org.uk>
Message-ID: <E1dTvDb-0007Eo-PK@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add pinctrl nodes to describe the CPM I2C0 and CPS SPI1 settings.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts | 31 +++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts b/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts
index dfced8c8f9e9..773a157e4af5 100644
--- a/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts
+++ b/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts
@@ -115,10 +115,14 @@
 
 &cpm_i2c0 {
 	clock-frequency = <100000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&cpm_i2c0_pins>;
 	status = "okay";
 };
 
 &cpm_mdio {
+	pinctrl-names = "default";
+	pinctrl-0 = <&cpm_ge_mdio_pins>;
 	status = "okay";
 
 	ge_phy: ethernet-phy at 0 {
@@ -126,6 +130,22 @@
 	};
 };
 
+&cpm_pinctrl {
+	cpm_ge_mdio_pins: ge-mdio-pins {
+		marvell,pins = "mpp32", "mpp34";
+		marvell,function = "ge";
+	};
+	cpm_i2c0_pins: i2c0-pins {
+		marvell,pins = "mpp37", "mpp38";
+		marvell,function = "i2c0";
+	};
+	cpm_sdhci_pins: sdhci-pins {
+		marvell,pins = "mpp55", "mpp56", "mpp57", "mpp58", "mpp59",
+			       "mpp60", "mpp61";
+		marvell,function = "sdio";
+	};
+};
+
 &cpm_sata0 {
 	/* CPM Lane 0 - U29 */
 	status = "okay";
@@ -135,6 +155,8 @@
 	/* U6 */
 	broken-cd;
 	bus-width = <4>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&cpm_sdhci_pins>;
 	status = "okay";
 	vqmmc-supply = <&v_3_3>;
 };
@@ -160,6 +182,13 @@
 	phy-mode = "sgmii";
 };
 
+&cps_pinctrl {
+	cps_spi1_pins: spi1-pins {
+		marvell,pins = "mpp12", "mpp13", "mpp14", "mpp15", "mpp16";
+		marvell,function = "spi1";
+	};
+};
+
 &cps_sata0 {
 	/* CPS Lane 1 - U32 */
 	/* CPS Lane 3 - U31 */
@@ -167,6 +196,8 @@
 };
 
 &cps_spi1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&cps_spi1_pins>;
 	status = "okay";
 
 	spi-flash at 0 {
-- 
2.7.4
