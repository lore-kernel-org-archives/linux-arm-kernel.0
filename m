From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu,  8 Jun 2017 18:51:22 +0200
Subject: [PATCH 1/4] arm64: dts: marvell: armada-3720-db: Sort the dts node
 alphabetically
In-Reply-To: <20170608165125.27630-1-gregory.clement@free-electrons.com>
References: <20170608165125.27630-1-gregory.clement@free-electrons.com>
Message-ID: <20170608165125.27630-2-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sort the reference nodes in alphabetical order to ease the merge of
future nodes.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm64/boot/dts/marvell/armada-3720-db.dts | 83 +++++++++++++-------------
 1 file changed, 41 insertions(+), 42 deletions(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-3720-db.dts b/arch/arm64/boot/dts/marvell/armada-3720-db.dts
index a89855f57091..d6f12fafac6c 100644
--- a/arch/arm64/boot/dts/marvell/armada-3720-db.dts
+++ b/arch/arm64/boot/dts/marvell/armada-3720-db.dts
@@ -78,6 +78,20 @@
 	};
 };
 
+&eth0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&rgmii_pins>;
+	phy-mode = "rgmii-id";
+	phy = <&phy0>;
+	status = "okay";
+};
+
+&eth1 {
+	phy-mode = "sgmii";
+	phy = <&phy1>;
+	status = "okay";
+};
+
 &i2c0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&i2c1_pins>;
@@ -108,11 +122,36 @@
 	};
 };
 
+&mdio {
+	status = "okay";
+	phy0: ethernet-phy at 0 {
+		reg = <0>;
+	};
+
+	phy1: ethernet-phy at 1 {
+		reg = <1>;
+	};
+};
+
+/* CON17 (PCIe) / CON12 (mini-PCIe) */
+&pcie0 {
+	status = "okay";
+};
+
 /* CON3 */
 &sata {
 	status = "okay";
 };
 
+&sdhci0 {
+	non-removable;
+	bus-width = <8>;
+	mmc-ddr-1_8v;
+	mmc-hs400-1_8v;
+	marvell,pad-type = "fixed-1-8v";
+	status = "okay";
+};
+
 &spi0 {
 	status = "okay";
 	pinctrl-names = "default";
@@ -152,12 +191,8 @@
 	status = "okay";
 };
 
-&sdhci0 {
-	non-removable;
-	bus-width = <8>;
-	mmc-ddr-1_8v;
-	mmc-hs400-1_8v;
-	marvell,pad-type = "fixed-1-8v";
+/* CON27 */
+&usb2 {
 	status = "okay";
 };
 
@@ -166,39 +201,3 @@
 	status = "okay";
 	usb-phy = <&usb3_phy>;
 };
-
-/* CON17 (PCIe) / CON12 (mini-PCIe) */
-&pcie0 {
-	status = "okay";
-};
-
-/* CON27 */
-&usb2 {
-	status = "okay";
-};
-
-
-&mdio {
-	status = "okay";
-	phy0: ethernet-phy at 0 {
-		reg = <0>;
-	};
-
-	phy1: ethernet-phy at 1 {
-		reg = <1>;
-	};
-};
-
-&eth0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&rgmii_pins>;
-	phy-mode = "rgmii-id";
-	phy = <&phy0>;
-	status = "okay";
-};
-
-&eth1 {
-	phy-mode = "sgmii";
-	phy = <&phy1>;
-	status = "okay";
-};
-- 
2.11.0
