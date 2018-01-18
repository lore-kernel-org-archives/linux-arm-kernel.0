From: hayashi.kunihiko@socionext.com (Kunihiko Hayashi)
Date: Thu, 18 Jan 2018 21:48:09 +0900
Subject: [PATCH 2/2] arm64: dts: uniphier: add AVE ethernet node
In-Reply-To: <1516279689-3119-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1516279689-3119-1-git-send-email-hayashi.kunihiko@socionext.com>
Message-ID: <1516279689-3119-3-git-send-email-hayashi.kunihiko@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add nodes of the AVE ethernet controller for LD11 and LD20 SoCs
and the boards.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Signed-off-by: Jassi Brar <jaswinder.singh@linaro.org>
---
 arch/arm64/boot/dts/socionext/uniphier-ld11-global.dts | 15 +++++++++++++++
 arch/arm64/boot/dts/socionext/uniphier-ld11-ref.dts    | 15 +++++++++++++++
 arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi       | 10 ++++++++++
 arch/arm64/boot/dts/socionext/uniphier-ld20-global.dts | 17 +++++++++++++++++
 arch/arm64/boot/dts/socionext/uniphier-ld20-ref.dts    | 15 +++++++++++++++
 arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi       | 12 ++++++++++++
 6 files changed, 84 insertions(+)

diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld11-global.dts b/arch/arm64/boot/dts/socionext/uniphier-ld11-global.dts
index 2452b22..60de0b0 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld11-global.dts
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld11-global.dts
@@ -72,3 +72,18 @@
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
+		ethphy: ethphy at 1 {
+			reg = <1>;
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld11-ref.dts b/arch/arm64/boot/dts/socionext/uniphier-ld11-ref.dts
index 54c5317..e6e8477 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld11-ref.dts
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld11-ref.dts
@@ -70,3 +70,18 @@
 &usb2 {
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
diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi b/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi
index cd7c2d0..862a618 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi
@@ -460,6 +460,16 @@
 			};
 		};
 
+		ether: ethernet at 65000000 {
+			compatible = "socionext,uniphier-ld11-ave4";
+			status = "disabled";
+			reg = <0x65000000 0x8500>;
+			interrupts = <0 66 4>;
+			clocks = <&sys_clk 6>;
+			resets = <&sys_rst 6>;
+			phy-mode = "rmii";
+		};
+
 		nand: nand at 68000000 {
 			compatible = "socionext,uniphier-denali-nand-v5b";
 			status = "disabled";
diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld20-global.dts b/arch/arm64/boot/dts/socionext/uniphier-ld20-global.dts
index fc2bc9d..6566fd5 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld20-global.dts
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld20-global.dts
@@ -54,3 +54,20 @@
 &nand {
 	status = "okay";
 };
+
+&ether {
+	status = "okay";
+	local-mac-address = [00 00 00 00 00 00];
+	phy-mode = "rmii";
+	pinctrl-0 = <&pinctrl_ether_rmii>;
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
diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld20-ref.dts b/arch/arm64/boot/dts/socionext/uniphier-ld20-ref.dts
index 6933710..6f971c6 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld20-ref.dts
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld20-ref.dts
@@ -58,3 +58,18 @@
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
+		ethphy: ethphy at 0 {
+			reg = <0>;
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi b/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
index 8a3276b..3edcd54 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
@@ -513,6 +513,18 @@
 			};
 		};
 
+		ether: ethernet at 65000000 {
+			compatible = "socionext,uniphier-ld20-ave4";
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
