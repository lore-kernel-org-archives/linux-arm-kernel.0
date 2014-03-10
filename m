From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 10 Mar 2014 17:54:44 -0300
Subject: [PATCH 6/7] ARM: dts: mx35: USB block requires only one clock
In-Reply-To: <1394484885-21262-1-git-send-email-festevam@gmail.com>
References: <1394484885-21262-1-git-send-email-festevam@gmail.com>
Message-ID: <1394484885-21262-6-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Like other imx SoCs only one USB clock is needed on mx35.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/boot/dts/imx35.dtsi | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/imx35.dtsi b/arch/arm/boot/dts/imx35.dtsi
index e59ccb4..474a73d 100644
--- a/arch/arm/boot/dts/imx35.dtsi
+++ b/arch/arm/boot/dts/imx35.dtsi
@@ -296,8 +296,7 @@
 				compatible = "fsl,imx35-usb", "fsl,imx27-usb";
 				reg = <0x53ff4000 0x0200>;
 				interrupts = <37>;
-				clocks = <&clks 9>, <&clks 73>, <&clks 28>;
-				clock-names = "ipg", "ahb", "per";
+				clocks = <&clks 73>;
 				fsl,usbmisc = <&usbmisc 0>;
 				status = "disabled";
 			};
@@ -306,8 +305,7 @@
 				compatible = "fsl,imx35-usb", "fsl,imx27-usb";
 				reg = <0x53ff4400 0x0200>;
 				interrupts = <35>;
-				clocks = <&clks 9>, <&clks 73>, <&clks 28>;
-				clock-names = "ipg", "ahb", "per";
+				clocks = <&clks 73>;
 				fsl,usbmisc = <&usbmisc 1>;
 				status = "disabled";
 			};
-- 
1.8.1.2
