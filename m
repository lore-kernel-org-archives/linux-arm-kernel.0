From: hayashi.kunihiko@socionext.com (Kunihiko Hayashi)
Date: Tue, 27 Mar 2018 19:32:46 +0900
Subject: [PATCH 2/2] arm64: dts: uniphier: add ethernet node for PXs3
In-Reply-To: <1522146766-14435-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1522146766-14435-1-git-send-email-hayashi.kunihiko@socionext.com>
Message-ID: <1522146766-14435-3-git-send-email-hayashi.kunihiko@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add nodes of the AVE ethernet controller for PXs3 and the boards.
This SoC has two controllers.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 .../arm64/boot/dts/socionext/uniphier-pxs3-ref.dts | 22 +++++++++++++
 arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi   | 36 ++++++++++++++++++++++
 2 files changed, 58 insertions(+)

diff --git a/arch/arm64/boot/dts/socionext/uniphier-pxs3-ref.dts b/arch/arm64/boot/dts/socionext/uniphier-pxs3-ref.dts
index 3c71087..f9fa61d 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-pxs3-ref.dts
+++ b/arch/arm64/boot/dts/socionext/uniphier-pxs3-ref.dts
@@ -80,3 +80,25 @@
 &nand {
 	status = "okay";
 };
+
+&eth0 {
+	status = "okay";
+	phy-handle = <&ethphy0>;
+};
+
+&eth1 {
+	status = "okay";
+	phy-handle = <&ethphy1>;
+};
+
+&mdio0 {
+	ethphy0: ethphy at 0 {
+		reg = <0>;
+	};
+};
+
+&mdio1 {
+	ethphy1: ethphy at 0 {
+		reg = <0>;
+	};
+};
diff --git a/arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi b/arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi
index 234fc58..0a5a7c2 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi
+++ b/arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi
@@ -407,6 +407,42 @@
 			};
 		};
 
+		eth0: ethernet at 65000000 {
+			compatible = "socionext,uniphier-pxs3-ave4";
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
+			mdio0: mdio {
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+		};
+
+		eth1: ethernet at 65200000 {
+			compatible = "socionext,uniphier-pxs3-ave4";
+			status = "disabled";
+			reg = <0x65200000 0x8500>;
+			interrupts = <0 67 4>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_ether1_rgmii>;
+			clocks = <&sys_clk 7>;
+			resets = <&sys_rst 7>;
+			phy-mode = "rgmii";
+			local-mac-address = [00 00 00 00 00 00];
+
+			mdio1: mdio {
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
