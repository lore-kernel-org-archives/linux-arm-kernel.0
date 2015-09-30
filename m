From: peter.chen@freescale.com (Peter Chen)
Date: Wed, 30 Sep 2015 10:25:24 +0800
Subject: [RESEND PATCH v3 4/5] ARM: dts: imx35.dtsi: change the clock
 information for usb
In-Reply-To: <1443579925-1330-1-git-send-email-peter.chen@freescale.com>
References: <1443579925-1330-1-git-send-email-peter.chen@freescale.com>
Message-ID: <1443579925-1330-5-git-send-email-peter.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For imx35, it needs three clocks to let the controller work,
the old code is wrong, and the usbmisc does not include
clock handling code any more.

Signed-off-by: Peter Chen <peter.chen@freescale.com>
---
 arch/arm/boot/dts/imx35.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/imx35.dtsi b/arch/arm/boot/dts/imx35.dtsi
index e6540b5..5b887d0 100644
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
