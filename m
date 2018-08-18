From: ryder.lee@mediatek.com (Ryder Lee)
Date: Sun, 19 Aug 2018 00:02:26 +0800
Subject: [PATCH v1 3/5] arm64: dts: mt7622: fix ram size for rfb1
In-Reply-To: <7d3ce6a89ffeb221dc3197b763521582bf300577.1534607107.git.ryder.lee@mediatek.com>
References: <7d3ce6a89ffeb221dc3197b763521582bf300577.1534607107.git.ryder.lee@mediatek.com>
Message-ID: <303c61949cb9ae949f19b1d040301510f1bdbafe.1534607107.git.ryder.lee@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix ram size to 512 megabytes and sort nodes in alphabetical order.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
Acked-by: Sean Wang <sean.wang@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts | 196 +++++++++++++--------------
 1 file changed, 98 insertions(+), 98 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts b/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts
index a747b7b..dcad086 100644
--- a/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts
+++ b/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts
@@ -51,7 +51,7 @@
 	};
 
 	memory {
-		reg = <0 0x40000000 0 0x3F000000>;
+		reg = <0 0x40000000 0 0x20000000>;
 	};
 
 	reg_1p8v: regulator-1p8v {
@@ -81,6 +81,103 @@
 	};
 };
 
+&bch {
+	status = "disabled";
+};
+
+&btif {
+	status = "okay";
+};
+
+&cir {
+	pinctrl-names = "default";
+	pinctrl-0 = <&irrx_pins>;
+	status = "okay";
+};
+
+&eth {
+	pinctrl-names = "default";
+	pinctrl-0 = <&eth_pins>;
+	status = "okay";
+
+	gmac1: mac at 1 {
+		compatible = "mediatek,eth-mac";
+		reg = <1>;
+		phy-handle = <&phy5>;
+	};
+
+	mdio-bus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		phy5: ethernet-phy at 5 {
+			reg = <5>;
+			phy-mode = "sgmii";
+		};
+	};
+};
+
+&i2c1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c1_pins>;
+	status = "okay";
+};
+
+&i2c2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c2_pins>;
+	status = "okay";
+};
+
+&mmc0 {
+	pinctrl-names = "default", "state_uhs";
+	pinctrl-0 = <&emmc_pins_default>;
+	pinctrl-1 = <&emmc_pins_uhs>;
+	status = "okay";
+	bus-width = <8>;
+	max-frequency = <50000000>;
+	cap-mmc-highspeed;
+	mmc-hs200-1_8v;
+	vmmc-supply = <&reg_3p3v>;
+	vqmmc-supply = <&reg_1p8v>;
+	assigned-clocks = <&topckgen CLK_TOP_MSDC30_0_SEL>;
+	assigned-clock-parents = <&topckgen CLK_TOP_UNIV48M>;
+	non-removable;
+};
+
+&mmc1 {
+	pinctrl-names = "default", "state_uhs";
+	pinctrl-0 = <&sd0_pins_default>;
+	pinctrl-1 = <&sd0_pins_uhs>;
+	status = "okay";
+	bus-width = <4>;
+	max-frequency = <50000000>;
+	cap-sd-highspeed;
+	r_smpl = <1>;
+	cd-gpios = <&pio 81 GPIO_ACTIVE_LOW>;
+	vmmc-supply = <&reg_3p3v>;
+	vqmmc-supply = <&reg_3p3v>;
+	assigned-clocks = <&topckgen CLK_TOP_MSDC30_1_SEL>;
+	assigned-clock-parents = <&topckgen CLK_TOP_UNIV48M>;
+};
+
+&nandc {
+	pinctrl-names = "default";
+	pinctrl-0 = <&parallel_nand_pins>;
+	status = "disabled";
+};
+
+&nor_flash {
+	pinctrl-names = "default";
+	pinctrl-0 = <&spi_nor_pins>;
+	status = "disabled";
+
+	flash at 0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+	};
+};
+
 &pcie {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pcie0_pins>;
@@ -344,103 +441,6 @@
 	};
 };
 
-&bch {
-	status = "disabled";
-};
-
-&btif {
-	status = "okay";
-};
-
-&cir {
-	pinctrl-names = "default";
-	pinctrl-0 = <&irrx_pins>;
-	status = "okay";
-};
-
-&eth {
-	pinctrl-names = "default";
-	pinctrl-0 = <&eth_pins>;
-	status = "okay";
-
-	gmac1: mac at 1 {
-		compatible = "mediatek,eth-mac";
-		reg = <1>;
-		phy-handle = <&phy5>;
-	};
-
-	mdio-bus {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		phy5: ethernet-phy at 5 {
-			reg = <5>;
-			phy-mode = "sgmii";
-		};
-	};
-};
-
-&i2c1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c1_pins>;
-	status = "okay";
-};
-
-&i2c2 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c2_pins>;
-	status = "okay";
-};
-
-&mmc0 {
-	pinctrl-names = "default", "state_uhs";
-	pinctrl-0 = <&emmc_pins_default>;
-	pinctrl-1 = <&emmc_pins_uhs>;
-	status = "okay";
-	bus-width = <8>;
-	max-frequency = <50000000>;
-	cap-mmc-highspeed;
-	mmc-hs200-1_8v;
-	vmmc-supply = <&reg_3p3v>;
-	vqmmc-supply = <&reg_1p8v>;
-	assigned-clocks = <&topckgen CLK_TOP_MSDC30_0_SEL>;
-	assigned-clock-parents = <&topckgen CLK_TOP_UNIV48M>;
-	non-removable;
-};
-
-&mmc1 {
-	pinctrl-names = "default", "state_uhs";
-	pinctrl-0 = <&sd0_pins_default>;
-	pinctrl-1 = <&sd0_pins_uhs>;
-	status = "okay";
-	bus-width = <4>;
-	max-frequency = <50000000>;
-	cap-sd-highspeed;
-	r_smpl = <1>;
-	cd-gpios = <&pio 81 GPIO_ACTIVE_LOW>;
-	vmmc-supply = <&reg_3p3v>;
-	vqmmc-supply = <&reg_3p3v>;
-	assigned-clocks = <&topckgen CLK_TOP_MSDC30_1_SEL>;
-	assigned-clock-parents = <&topckgen CLK_TOP_UNIV48M>;
-};
-
-&nandc {
-	pinctrl-names = "default";
-	pinctrl-0 = <&parallel_nand_pins>;
-	status = "disabled";
-};
-
-&nor_flash {
-	pinctrl-names = "default";
-	pinctrl-0 = <&spi_nor_pins>;
-	status = "disabled";
-
-	flash at 0 {
-		compatible = "jedec,spi-nor";
-		reg = <0>;
-	};
-};
-
 &pwm {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pwm7_pins>;
-- 
1.9.1
