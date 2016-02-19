From: peter.chen@nxp.com (Peter Chen)
Date: Fri, 19 Feb 2016 17:35:04 +0800
Subject: [PATCH 2/2] ARM: dts: imx35.dtsi: change the clock information for usb
In-Reply-To: <1455874504-28993-1-git-send-email-peter.chen@nxp.com>
References: <1455874504-28993-1-git-send-email-peter.chen@nxp.com>
Message-ID: <1455874504-28993-2-git-send-email-peter.chen@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Peter Chen <peter.chen@freescale.com>

For imx35, it needs three clocks to let the controller work,
the old code is wrong, and the usbmisc does not include
clock handling code any more.

Signed-off-by: Peter Chen <peter.chen@freescale.com>
Acked-by: Shawn Guo <shawnguo@kernel.org>
---
 arch/arm/boot/dts/imx35.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/imx35.dtsi b/arch/arm/boot/dts/imx35.dtsi
index ed3dc33..14e1320 100644
--- a/arch/arm/boot/dts/imx35.dtsi
+++ b/arch/arm/boot/dts/imx35.dtsi
@@ -305,7 +305,8 @@
 				compatible = "fsl,imx35-usb", "fsl,imx27-usb";
 				reg = <0x53ff4000 0x0200>;
 				interrupts = <37>;
-				clocks = <&clks 73>;
+				clocks = <&clks 9>, <&clks 73>, <&clks 28>;
+				clock-names = "ipg", "ahb", "per";
 				fsl,usbmisc = <&usbmisc 0>;
 				fsl,usbphy = <&usbphy0>;
 				status = "disabled";
@@ -315,7 +316,8 @@
 				compatible = "fsl,imx35-usb", "fsl,imx27-usb";
 				reg = <0x53ff4400 0x0200>;
 				interrupts = <35>;
-				clocks = <&clks 73>;
+				clocks = <&clks 9>, <&clks 73>, <&clks 28>;
+				clock-names = "ipg", "ahb", "per";
 				fsl,usbmisc = <&usbmisc 1>;
 				fsl,usbphy = <&usbphy1>;
 				dr_mode = "host";
@@ -325,8 +327,6 @@
 			usbmisc: usbmisc at 53ff4600 {
 				#index-cells = <1>;
 				compatible = "fsl,imx35-usbmisc";
-				clocks = <&clks 9>, <&clks 73>, <&clks 28>;
-				clock-names = "ipg", "ahb", "per";
 				reg = <0x53ff4600 0x00f>;
 			};
 		};
-- 
1.9.1
