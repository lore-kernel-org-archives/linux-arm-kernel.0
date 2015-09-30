From: peter.chen@freescale.com (Peter Chen)
Date: Wed, 30 Sep 2015 10:25:23 +0800
Subject: [RESEND PATCH v3 3/5] ARM: dts: imx25.dtsi: change the clock
 information for usb
In-Reply-To: <1443579925-1330-1-git-send-email-peter.chen@freescale.com>
References: <1443579925-1330-1-git-send-email-peter.chen@freescale.com>
Message-ID: <1443579925-1330-4-git-send-email-peter.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For imx25, it needs three clocks to let the controller work,
the old code is wrong, and usbmisc has not included clock
handling code any more.

Signed-off-by: Peter Chen <peter.chen@freescale.com>
---
 arch/arm/boot/dts/imx25.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/imx25.dtsi b/arch/arm/boot/dts/imx25.dtsi
index 677f81d..ab843bd 100644
--- a/arch/arm/boot/dts/imx25.dtsi
+++ b/arch/arm/boot/dts/imx25.dtsi
@@ -493,7 +493,8 @@
 				compatible = "fsl,imx25-usb", "fsl,imx27-usb";
 				reg = <0x53ff4000 0x0200>;
 				interrupts = <37>;
-				clocks = <&clks 70>;
+				clocks = <&clks 9>, <&clks 70>, <&clks 8>;
+				clock-names = "ipg", "ahb", "per";
 				fsl,usbmisc = <&usbmisc 0>;
 				fsl,usbphy = <&usbphy0>;
 				status = "disabled";
@@ -503,7 +504,8 @@
 				compatible = "fsl,imx25-usb", "fsl,imx27-usb";
 				reg = <0x53ff4400 0x0200>;
 				interrupts = <35>;
-				clocks = <&clks 70>;
+				clocks = <&clks 9>, <&clks 70>, <&clks 8>;
+				clock-names = "ipg", "ahb", "per";
 				fsl,usbmisc = <&usbmisc 1>;
 				fsl,usbphy = <&usbphy1>;
 				status = "disabled";
@@ -512,8 +514,6 @@
 			usbmisc: usbmisc at 53ff4600 {
 				#index-cells = <1>;
 				compatible = "fsl,imx25-usbmisc";
-				clocks = <&clks 9>, <&clks 70>, <&clks 8>;
-				clock-names = "ipg", "ahb", "per";
 				reg = <0x53ff4600 0x00f>;
 			};
 
-- 
1.9.1
