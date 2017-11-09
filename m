From: robh@kernel.org (Rob Herring)
Date: Thu,  9 Nov 2017 16:26:10 -0600
Subject: [PATCH 2/6] arm: dts: imx: Add missing #phy-cells to usb-nop-xceiv
In-Reply-To: <20171109222614.5719-1-robh@kernel.org>
References: <20171109222614.5719-1-robh@kernel.org>
Message-ID: <20171109222614.5719-2-robh@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

"usb-nop-xceiv" is using the phy binding, but is missing #phy-cells
property. This is probably because the binding was the precursor to the phy
binding.

Fixes the following warning in i.MX dts files:

Warning (phys_property): Missing property '#phy-cells' in node ...

Signed-off-by: Rob Herring <robh@kernel.org>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
---
Please apply to i.MX tree.

 arch/arm/boot/dts/imx25.dtsi                           | 2 ++
 arch/arm/boot/dts/imx27-pdk.dts                        | 1 +
 arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts         | 1 +
 arch/arm/boot/dts/imx27-phytec-phycore-som.dtsi        | 1 +
 arch/arm/boot/dts/imx35.dtsi                           | 2 ++
 arch/arm/boot/dts/imx51-babbage.dts                    | 1 +
 arch/arm/boot/dts/imx51-eukrea-mbimxsd51-baseboard.dts | 1 +
 arch/arm/boot/dts/imx51.dtsi                           | 1 +
 arch/arm/boot/dts/imx53.dtsi                           | 2 ++
 arch/arm/boot/dts/imx7d.dtsi                           | 1 +
 arch/arm/boot/dts/imx7s.dtsi                           | 2 ++
 11 files changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/imx25.dtsi b/arch/arm/boot/dts/imx25.dtsi
index 09ce8b81fafa..c43cf704b768 100644
--- a/arch/arm/boot/dts/imx25.dtsi
+++ b/arch/arm/boot/dts/imx25.dtsi
@@ -628,11 +628,13 @@
 		usbphy0: usb-phy at 0 {
 			reg = <0>;
 			compatible = "usb-nop-xceiv";
+			#phy-cells = <0>;
 		};
 
 		usbphy1: usb-phy at 1 {
 			reg = <1>;
 			compatible = "usb-nop-xceiv";
+			#phy-cells = <0>;
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/imx27-pdk.dts b/arch/arm/boot/dts/imx27-pdk.dts
index 96f442ba6d22..2a140c8ae6d2 100644
--- a/arch/arm/boot/dts/imx27-pdk.dts
+++ b/arch/arm/boot/dts/imx27-pdk.dts
@@ -30,6 +30,7 @@
 			reg = <0>;
 			clocks = <&clks IMX27_CLK_DUMMY>;
 			clock-names = "main_clk";
+			#phy-cells = <0>;
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts b/arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts
index 2a9198f99a8d..2ed2d73b087e 100644
--- a/arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts
+++ b/arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts
@@ -63,6 +63,7 @@
 			vcc-supply = <&reg_5v0>;
 			clocks = <&clks IMX27_CLK_DUMMY>;
 			clock-names = "main_clk";
+			#phy-cells = <0>;
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/imx27-phytec-phycore-som.dtsi b/arch/arm/boot/dts/imx27-phytec-phycore-som.dtsi
index c973c5d91875..c9095b7654c6 100644
--- a/arch/arm/boot/dts/imx27-phytec-phycore-som.dtsi
+++ b/arch/arm/boot/dts/imx27-phytec-phycore-som.dtsi
@@ -53,6 +53,7 @@
 			vcc-supply = <&sw3_reg>;
 			clocks = <&clks IMX27_CLK_DUMMY>;
 			clock-names = "main_clk";
+			#phy-cells = <0>;
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/imx35.dtsi b/arch/arm/boot/dts/imx35.dtsi
index 6d5e6a60bee7..f049c692c6b0 100644
--- a/arch/arm/boot/dts/imx35.dtsi
+++ b/arch/arm/boot/dts/imx35.dtsi
@@ -402,11 +402,13 @@
 		usbphy0: usb-phy at 0 {
 			reg = <0>;
 			compatible = "usb-nop-xceiv";
+			#phy-cells = <0>;
 		};
 
 		usbphy1: usb-phy at 1 {
 			reg = <1>;
 			compatible = "usb-nop-xceiv";
+			#phy-cells = <0>;
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/imx51-babbage.dts b/arch/arm/boot/dts/imx51-babbage.dts
index 873cf242679c..699ee77c284e 100644
--- a/arch/arm/boot/dts/imx51-babbage.dts
+++ b/arch/arm/boot/dts/imx51-babbage.dts
@@ -165,6 +165,7 @@
 			clocks = <&clks IMX5_CLK_DUMMY>;
 			clock-names = "main_clk";
 			reset-gpios = <&gpio2 5 GPIO_ACTIVE_LOW>;
+			#phy-cells = <0>;
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/imx51-eukrea-mbimxsd51-baseboard.dts b/arch/arm/boot/dts/imx51-eukrea-mbimxsd51-baseboard.dts
index 1305b05c7ed9..b3d952f37cdc 100644
--- a/arch/arm/boot/dts/imx51-eukrea-mbimxsd51-baseboard.dts
+++ b/arch/arm/boot/dts/imx51-eukrea-mbimxsd51-baseboard.dts
@@ -94,6 +94,7 @@
 			clocks = <&clks IMX5_CLK_USB_PHY_GATE>;
 			clock-names = "main_clk";
 			clock-frequency = <19200000>;
+			#phy-cells = <0>;
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/imx51.dtsi b/arch/arm/boot/dts/imx51.dtsi
index 1ee1d542d9ad..c27ab6d88263 100644
--- a/arch/arm/boot/dts/imx51.dtsi
+++ b/arch/arm/boot/dts/imx51.dtsi
@@ -113,6 +113,7 @@
 			reg = <0>;
 			clocks = <&clks IMX5_CLK_USB_PHY_GATE>;
 			clock-names = "main_clk";
+			#phy-cells = <0>;
 		};
 	};
 
diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
index 8bf0d89cdd35..423309df103f 100644
--- a/arch/arm/boot/dts/imx53.dtsi
+++ b/arch/arm/boot/dts/imx53.dtsi
@@ -303,6 +303,7 @@
 				compatible = "usb-nop-xceiv";
 				clocks = <&clks IMX5_CLK_USB_PHY1_GATE>;
 				clock-names = "main_clk";
+				#phy-cells = <0>;
 				status = "okay";
 			};
 
@@ -310,6 +311,7 @@
 				compatible = "usb-nop-xceiv";
 				clocks = <&clks IMX5_CLK_USB_PHY2_GATE>;
 				clock-names = "main_clk";
+				#phy-cells = <0>;
 				status = "okay";
 			};
 
diff --git a/arch/arm/boot/dts/imx7d.dtsi b/arch/arm/boot/dts/imx7d.dtsi
index f46814a7ea44..7bcdc953dc9e 100644
--- a/arch/arm/boot/dts/imx7d.dtsi
+++ b/arch/arm/boot/dts/imx7d.dtsi
@@ -109,6 +109,7 @@
 		compatible = "usb-nop-xceiv";
 		clocks = <&clks IMX7D_USB_PHY2_CLK>;
 		clock-names = "main_clk";
+		#phy-cells = <0>;
 	};
 
 	fec2: ethernet at 30bf0000 {
diff --git a/arch/arm/boot/dts/imx7s.dtsi b/arch/arm/boot/dts/imx7s.dtsi
index 82ad26e766eb..ded1504bf602 100644
--- a/arch/arm/boot/dts/imx7s.dtsi
+++ b/arch/arm/boot/dts/imx7s.dtsi
@@ -949,12 +949,14 @@
 				compatible = "usb-nop-xceiv";
 				clocks = <&clks IMX7D_USB_PHY1_CLK>;
 				clock-names = "main_clk";
+				#phy-cells = <0>;
 			};
 
 			usbphynop3: usbphynop3 {
 				compatible = "usb-nop-xceiv";
 				clocks = <&clks IMX7D_USB_HSIC_ROOT_CLK>;
 				clock-names = "main_clk";
+				#phy-cells = <0>;
 			};
 
 			usdhc1: usdhc at 30b40000 {
-- 
2.14.1
