From: hayashi.kunihiko@socionext.com (Kunihiko Hayashi)
Date: Thu, 18 Jan 2018 21:48:08 +0900
Subject: [PATCH 1/2] ARM: dts: uniphier: add AVE ethernet node
In-Reply-To: <1516279689-3119-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1516279689-3119-1-git-send-email-hayashi.kunihiko@socionext.com>
Message-ID: <1516279689-3119-2-git-send-email-hayashi.kunihiko@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add nodes of the AVE ethernet controller for Pro4, PXs2, LD6b SoCs
and the boards.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Signed-off-by: Jassi Brar <jaswinder.singh@linaro.org>
---
 arch/arm/boot/dts/uniphier-ld6b-ref.dts    | 15 +++++++++++++++
 arch/arm/boot/dts/uniphier-pro4-ace.dts    | 15 +++++++++++++++
 arch/arm/boot/dts/uniphier-pro4-ref.dts    | 15 +++++++++++++++
 arch/arm/boot/dts/uniphier-pro4-sanji.dts  | 15 +++++++++++++++
 arch/arm/boot/dts/uniphier-pro4.dtsi       | 12 ++++++++++++
 arch/arm/boot/dts/uniphier-pxs2-gentil.dts | 15 +++++++++++++++
 arch/arm/boot/dts/uniphier-pxs2-vodka.dts  | 15 +++++++++++++++
 arch/arm/boot/dts/uniphier-pxs2.dtsi       | 12 ++++++++++++
 8 files changed, 114 insertions(+)

diff --git a/arch/arm/boot/dts/uniphier-ld6b-ref.dts b/arch/arm/boot/dts/uniphier-ld6b-ref.dts
index 811b999..1dd6541 100644
--- a/arch/arm/boot/dts/uniphier-ld6b-ref.dts
+++ b/arch/arm/boot/dts/uniphier-ld6b-ref.dts
@@ -70,3 +70,18 @@
 &nand {
 	status = "okay";
 };
+
+&ether {
+	status = "okay";
+	local-mac-address = [00 00 00 00 00 00];
+	phy-handle = <&ethphy>;
+
+	mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		ethphy: ethphy at 0 {
+			reg = <0>;
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/uniphier-pro4-ace.dts b/arch/arm/boot/dts/uniphier-pro4-ace.dts
index 089419c..d9ba4e2 100644
--- a/arch/arm/boot/dts/uniphier-pro4-ace.dts
+++ b/arch/arm/boot/dts/uniphier-pro4-ace.dts
@@ -77,3 +77,18 @@
 &usb3 {
 	status = "okay";
 };
+
+&ether {
+	status = "okay";
+	local-mac-address = [00 00 00 00 00 00];
+	phy-handle = <&ethphy>;
+
+	mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		ethphy: ethphy at 1 {
+			reg = <1>;
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/uniphier-pro4-ref.dts b/arch/arm/boot/dts/uniphier-pro4-ref.dts
index 6a004e5..fe32f57 100644
--- a/arch/arm/boot/dts/uniphier-pro4-ref.dts
+++ b/arch/arm/boot/dts/uniphier-pro4-ref.dts
@@ -78,3 +78,18 @@
 &nand {
 	status = "okay";
 };
+
+&ether {
+	status = "okay";
+	local-mac-address = [00 00 00 00 00 00];
+	phy-handle = <&ethphy>;
+
+	mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		ethphy: ethphy at 0 {
+			reg = <0>;
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/uniphier-pro4-sanji.dts b/arch/arm/boot/dts/uniphier-pro4-sanji.dts
index adef212..ad6758d 100644
--- a/arch/arm/boot/dts/uniphier-pro4-sanji.dts
+++ b/arch/arm/boot/dts/uniphier-pro4-sanji.dts
@@ -72,3 +72,18 @@
 &usb3 {
 	status = "okay";
 };
+
+&ether {
+	status = "okay";
+	local-mac-address = [00 00 00 00 00 00];
+	phy-handle = <&ethphy>;
+
+	mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		ethphy: ethphy at 1 {
+			reg = <1>;
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/uniphier-pro4.dtsi b/arch/arm/boot/dts/uniphier-pro4.dtsi
index 1a29a86..d192a7f 100644
--- a/arch/arm/boot/dts/uniphier-pro4.dtsi
+++ b/arch/arm/boot/dts/uniphier-pro4.dtsi
@@ -366,6 +366,18 @@
 			};
 		};
 
+		ether: ethernet at 65000000 {
+			compatible = "socionext,uniphier-pro4-ave4";
+			status = "disabled";
+			reg = <0x65000000 0x8500>;
+			interrupts = <0 66 4>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_ether_rgmii>;
+			clocks = <&sys_clk 6>;
+			resets = <&sys_rst 6>;
+			phy-mode = "rgmii";
+		};
+
 		nand: nand at 68000000 {
 			compatible = "socionext,uniphier-denali-nand-v5a";
 			status = "disabled";
diff --git a/arch/arm/boot/dts/uniphier-pxs2-gentil.dts b/arch/arm/boot/dts/uniphier-pxs2-gentil.dts
index 7dfae26..d83ad09 100644
--- a/arch/arm/boot/dts/uniphier-pxs2-gentil.dts
+++ b/arch/arm/boot/dts/uniphier-pxs2-gentil.dts
@@ -53,3 +53,18 @@
 &i2c2 {
 	status = "okay";
 };
+
+&ether {
+	status = "okay";
+	local-mac-address = [00 00 00 00 00 00];
+	phy-handle = <&ethphy>;
+
+	mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		ethphy: ethphy at 1 {
+			reg = <1>;
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/uniphier-pxs2-vodka.dts b/arch/arm/boot/dts/uniphier-pxs2-vodka.dts
index 0cf6154..9a67574 100644
--- a/arch/arm/boot/dts/uniphier-pxs2-vodka.dts
+++ b/arch/arm/boot/dts/uniphier-pxs2-vodka.dts
@@ -41,3 +41,18 @@
 &i2c0 {
 	status = "okay";
 };
+
+&ether {
+	status = "okay";
+	local-mac-address = [00 00 00 00 00 00];
+	phy-handle = <&ethphy>;
+
+	mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		ethphy: ethphy at 1 {
+			reg = <1>;
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/uniphier-pxs2.dtsi b/arch/arm/boot/dts/uniphier-pxs2.dtsi
index c083468..a6abc85 100644
--- a/arch/arm/boot/dts/uniphier-pxs2.dtsi
+++ b/arch/arm/boot/dts/uniphier-pxs2.dtsi
@@ -446,6 +446,18 @@
 			};
 		};
 
+		ether: ethernet at 65000000 {
+			compatible = "socionext,uniphier-pxs2-ave4";
+			status = "disabled";
+			reg = <0x65000000 0x8500>;
+			interrupts = <0 66 4>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_ether_rgmii>;
+			clocks = <&sys_clk 6>;
+			resets = <&sys_rst 6>;
+			phy-mode = "rgmii";
+		};
+
 		nand: nand at 68000000 {
 			compatible = "socionext,uniphier-denali-nand-v5b";
 			status = "disabled";
-- 
2.7.4
