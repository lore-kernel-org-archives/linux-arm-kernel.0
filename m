From: denis@eukrea.com (Denis Carikli)
Date: Fri,  7 Mar 2014 18:04:16 +0100
Subject: [PATCH 2/9] ARM: dts: i.MX51: Add a second usbphy.
In-Reply-To: <1394211863-7569-1-git-send-email-denis@eukrea.com>
References: <1394211863-7569-1-git-send-email-denis@eukrea.com>
Message-ID: <1394211863-7569-2-git-send-email-denis@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Denis Carikli <denis@eukrea.com>
---
 arch/arm/boot/dts/imx51.dtsi |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/imx51.dtsi b/arch/arm/boot/dts/imx51.dtsi
index e508e6f..917b6ed 100644
--- a/arch/arm/boot/dts/imx51.dtsi
+++ b/arch/arm/boot/dts/imx51.dtsi
@@ -100,6 +100,13 @@
 			clocks = <&clks IMX5_CLK_USB_PHY_GATE>;
 			clock-names = "main_clk";
 		};
+
+		usbphy1: usbphy at 1 {
+			compatible = "usb-nop-xceiv";
+			reg = <1>;
+			clocks = <&clks IMX5_CLK_USB_PHY_GATE>;
+			clock-names = "main_clk";
+		};
 	};
 
 	soc {
@@ -239,6 +246,7 @@
 				interrupts = <14>;
 				clocks = <&clks IMX5_CLK_USBOH3_GATE>;
 				fsl,usbmisc = <&usbmisc 1>;
+				fsl,usbphy = <&usbphy1>;
 				status = "disabled";
 			};
 
-- 
1.7.9.5
