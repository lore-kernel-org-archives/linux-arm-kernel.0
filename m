From: hayashi.kunihiko@socionext.com (Kunihiko Hayashi)
Date: Wed, 14 Feb 2018 18:30:28 +0900
Subject: [PATCH v2 1/2] ARM: dts: uniphier: add AVE ethernet node
In-Reply-To: <1518600629-14317-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1518600629-14317-1-git-send-email-hayashi.kunihiko@socionext.com>
Message-ID: <1518600629-14317-2-git-send-email-hayashi.kunihiko@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add nodes of the AVE ethernet controller for Pro4, PXs2, LD6b SoCs
and the boards.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Signed-off-by: Jassi Brar <jaswinder.singh@linaro.org>
---
 arch/arm/boot/dts/uniphier-ld6b-ref.dts    | 11 +++++++++++
 arch/arm/boot/dts/uniphier-pro4-ace.dts    | 11 +++++++++++
 arch/arm/boot/dts/uniphier-pro4-ref.dts    | 11 +++++++++++
 arch/arm/boot/dts/uniphier-pro4-sanji.dts  | 11 +++++++++++
 arch/arm/boot/dts/uniphier-pro4.dtsi       | 18 ++++++++++++++++++
 arch/arm/boot/dts/uniphier-pxs2-gentil.dts | 11 +++++++++++
 arch/arm/boot/dts/uniphier-pxs2-vodka.dts  | 11 +++++++++++
 arch/arm/boot/dts/uniphier-pxs2.dtsi       | 18 ++++++++++++++++++
 8 files changed, 102 insertions(+)

diff --git a/arch/arm/boot/dts/uniphier-ld6b-ref.dts b/arch/arm/boot/dts/uniphier-ld6b-ref.dts
index 0e510a7..1116a3d 100644
--- a/arch/arm/boot/dts/uniphier-ld6b-ref.dts
+++ b/arch/arm/boot/dts/uniphier-ld6b-ref.dts
@@ -70,3 +70,14 @@
 &nand {
 	status = "okay";
 };
+
+&eth {
+	status = "okay";
+	phy-handle = <&ethphy>;
+};
+
+&mdio {
+	ethphy: ethphy at 0 {
+		reg = <0>;
+	};
+};
diff --git a/arch/arm/boot/dts/uniphier-pro4-ace.dts b/arch/arm/boot/dts/uniphier-pro4-ace.dts
index 089419c..92b5cbb 100644
--- a/arch/arm/boot/dts/uniphier-pro4-ace.dts
+++ b/arch/arm/boot/dts/uniphier-pro4-ace.dts
@@ -77,3 +77,14 @@
 &usb3 {
 	status = "okay";
 };
+
+&eth {
+	status = "okay";
+	phy-handle = <&ethphy>;
+};
+
+&mdio {
+	ethphy: ethphy at 1 {
+		reg = <1>;
+	};
+};
diff --git a/arch/arm/boot/dts/uniphier-pro4-ref.dts b/arch/arm/boot/dts/uniphier-pro4-ref.dts
index be99467..5135585 100644
--- a/arch/arm/boot/dts/uniphier-pro4-ref.dts
+++ b/arch/arm/boot/dts/uniphier-pro4-ref.dts
@@ -78,3 +78,14 @@
 &nand {
 	status = "okay";
 };
+
+&eth {
+	status = "okay";
+	phy-handle = <&ethphy>;
+};
+
+&mdio {
+	ethphy: ethphy at 0 {
+		reg = <0>;
+	};
+};
diff --git a/arch/arm/boot/dts/uniphier-pro4-sanji.dts b/arch/arm/boot/dts/uniphier-pro4-sanji.dts
index adef212..7c4326a 100644
--- a/arch/arm/boot/dts/uniphier-pro4-sanji.dts
+++ b/arch/arm/boot/dts/uniphier-pro4-sanji.dts
@@ -72,3 +72,14 @@
 &usb3 {
 	status = "okay";
 };
+
+&eth {
+	status = "okay";
+	phy-handle = <&ethphy>;
+};
+
+&mdio {
+	ethphy: ethphy at 1 {
+		reg = <1>;
+	};
+};
diff --git a/arch/arm/boot/dts/uniphier-pro4.dtsi b/arch/arm/boot/dts/uniphier-pro4.dtsi
index 7955c3a..795b656 100644
--- a/arch/arm/boot/dts/uniphier-pro4.dtsi
+++ b/arch/arm/boot/dts/uniphier-pro4.dtsi
@@ -339,6 +339,24 @@
 			};
 		};
 
+		eth: ethernet at 65000000 {
+			compatible = "socionext,uniphier-pro4-ave4";
+			status = "disabled";
+			reg = <0x65000000 0x8500>;
+			interrupts = <0 66 4>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_ether_rgmii>;
+			clocks = <&sys_clk 6>;
+			resets = <&sys_rst 6>;
+			phy-mode = "rgmii";
+			local-mac-address = [00 00 00 00 00 00];
+
+			mdio: mdio {
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+		};
+
 		nand: nand at 68000000 {
 			compatible = "socionext,uniphier-denali-nand-v5a";
 			status = "disabled";
diff --git a/arch/arm/boot/dts/uniphier-pxs2-gentil.dts b/arch/arm/boot/dts/uniphier-pxs2-gentil.dts
index 7dfae26..d09acb8 100644
--- a/arch/arm/boot/dts/uniphier-pxs2-gentil.dts
+++ b/arch/arm/boot/dts/uniphier-pxs2-gentil.dts
@@ -53,3 +53,14 @@
 &i2c2 {
 	status = "okay";
 };
+
+&eth {
+	status = "okay";
+	phy-handle = <&ethphy>;
+};
+
+&mdio {
+	ethphy: ethphy at 1 {
+		reg = <1>;
+	};
+};
diff --git a/arch/arm/boot/dts/uniphier-pxs2-vodka.dts b/arch/arm/boot/dts/uniphier-pxs2-vodka.dts
index 0cf6154..6f13a25 100644
--- a/arch/arm/boot/dts/uniphier-pxs2-vodka.dts
+++ b/arch/arm/boot/dts/uniphier-pxs2-vodka.dts
@@ -41,3 +41,14 @@
 &i2c0 {
 	status = "okay";
 };
+
+&eth {
+	status = "okay";
+	phy-handle = <&ethphy>;
+};
+
+&mdio {
+	ethphy: ethphy at 1 {
+		reg = <1>;
+	};
+};
diff --git a/arch/arm/boot/dts/uniphier-pxs2.dtsi b/arch/arm/boot/dts/uniphier-pxs2.dtsi
index d82d6d8..a91c96e 100644
--- a/arch/arm/boot/dts/uniphier-pxs2.dtsi
+++ b/arch/arm/boot/dts/uniphier-pxs2.dtsi
@@ -427,6 +427,24 @@
 			};
 		};
 
+		eth: ethernet at 65000000 {
+			compatible = "socionext,uniphier-pxs2-ave4";
+			status = "disabled";
+			reg = <0x65000000 0x8500>;
+			interrupts = <0 66 4>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_ether_rgmii>;
+			clocks = <&sys_clk 6>;
+			resets = <&sys_rst 6>;
+			phy-mode = "rgmii";
+			local-mac-address = [00 00 00 00 00 00];
+
+			mdio: mdio {
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+		};
+
 		nand: nand at 68000000 {
 			compatible = "socionext,uniphier-denali-nand-v5b";
 			status = "disabled";
-- 
2.7.4
