From: hayashi.kunihiko@socionext.com (Kunihiko Hayashi)
Date: Tue,  2 Oct 2018 20:12:00 +0900
Subject: [PATCH 2/4] ARM: dts: uniphier: Add USB2 phy nodes
In-Reply-To: <1538478722-20351-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1538478722-20351-1-git-send-email-hayashi.kunihiko@socionext.com>
Message-ID: <1538478722-20351-3-git-send-email-hayashi.kunihiko@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add nodes of USB2 physical layer for UniPhier SoC. This supports Pro4.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 arch/arm/boot/dts/uniphier-pro4.dtsi | 35 ++++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/uniphier-pro4.dtsi b/arch/arm/boot/dts/uniphier-pro4.dtsi
index b994494..4b2e291 100644
--- a/arch/arm/boot/dts/uniphier-pro4.dtsi
+++ b/arch/arm/boot/dts/uniphier-pro4.dtsi
@@ -269,6 +269,8 @@
 				 <&mio_clk 12>;
 			resets = <&sys_rst 8>, <&mio_rst 7>, <&mio_rst 8>,
 				 <&mio_rst 12>;
+			phy-names = "usb";
+			phys = <&usb_phy0>;
 			has-transaction-translator;
 		};
 
@@ -283,6 +285,8 @@
 				 <&mio_clk 13>;
 			resets = <&sys_rst 8>, <&mio_rst 7>, <&mio_rst 9>,
 				 <&mio_rst 13>;
+			phy-names = "usb";
+			phys = <&usb_phy1>;
 			has-transaction-translator;
 		};
 
@@ -294,6 +298,34 @@
 			pinctrl: pinctrl {
 				compatible = "socionext,uniphier-pro4-pinctrl";
 			};
+
+			usb-phy {
+				compatible = "socionext,uniphier-pro4-usb2-phy";
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				usb_phy0: phy at 0 {
+					reg = <0>;
+					#phy-cells = <0>;
+				};
+
+				usb_phy1: phy at 1 {
+					reg = <1>;
+					#phy-cells = <0>;
+				};
+
+				usb_phy2: phy at 2 {
+					reg = <2>;
+					#phy-cells = <0>;
+					vbus-supply = <&usb0_vbus>;
+				};
+
+				usb_phy3: phy at 3 {
+					reg = <3>;
+					#phy-cells = <0>;
+					vbus-supply = <&usb1_vbus>;
+				};
+			};
 		};
 
 		soc-glue at 5f900000 {
@@ -397,7 +429,7 @@
 			clock-names = "ref", "bus_early", "suspend";
 			clocks = <&sys_clk 12>, <&sys_clk 12>, <&sys_clk 12>;
 			resets = <&usb0_rst 4>;
-			phys = <&usb0_ssphy>;
+			phys = <&usb_phy2>, <&usb0_ssphy>;
 			dr_mode = "host";
 		};
 
@@ -450,6 +482,7 @@
 			clock-names = "ref", "bus_early", "suspend";
 			clocks = <&sys_clk 12>, <&sys_clk 12>, <&sys_clk 12>;
 			resets = <&usb1_rst 4>;
+			phys = <&usb_phy3>;
 			dr_mode = "host";
 		};
 
-- 
2.7.4
