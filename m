From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 10 Mar 2014 17:54:43 -0300
Subject: [PATCH 5/7] ARM: dts: mx25: USB block requires only one clock
In-Reply-To: <1394484885-21262-1-git-send-email-festevam@gmail.com>
References: <1394484885-21262-1-git-send-email-festevam@gmail.com>
Message-ID: <1394484885-21262-5-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Like other imx SoCs only one USB clock is needed on mx25.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/boot/dts/imx25.dtsi | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/imx25.dtsi b/arch/arm/boot/dts/imx25.dtsi
index ab5c282..ebe80bf 100644
--- a/arch/arm/boot/dts/imx25.dtsi
+++ b/arch/arm/boot/dts/imx25.dtsi
@@ -494,8 +494,7 @@
 				compatible = "fsl,imx25-usb", "fsl,imx27-usb";
 				reg = <0x53ff4000 0x0200>;
 				interrupts = <37>;
-				clocks = <&clks 9>, <&clks 70>, <&clks 8>;
-				clock-names = "ipg", "ahb", "per";
+				clocks = <&clks 70>;
 				fsl,usbmisc = <&usbmisc 0>;
 				fsl,usbphy = <&usbphy1>;
 				status = "disabled";
@@ -505,8 +504,7 @@
 				compatible = "fsl,imx25-usb", "fsl,imx27-usb";
 				reg = <0x53ff4400 0x0200>;
 				interrupts = <35>;
-				clocks = <&clks 9>, <&clks 70>, <&clks 8>;
-				clock-names = "ipg", "ahb", "per";
+				clocks = <&clks 70>;
 				fsl,usbmisc = <&usbmisc 1>;
 				fsl,usbphy = <&usbphy2>;
 				status = "disabled";
-- 
1.8.1.2
