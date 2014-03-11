From: denis@eukrea.com (Denis Carikli)
Date: Tue, 11 Mar 2014 11:54:57 +0100
Subject: [PATCH v2][ 1/8] ARM: dts: mx25: USB block requires only one clock
Message-ID: <1394535304-10240-1-git-send-email-denis@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Like other imx SoCs only one USB clock is needed on mx25.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/boot/dts/imx25.dtsi |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/imx25.dtsi b/arch/arm/boot/dts/imx25.dtsi
index 77bb743..829791e 100644
--- a/arch/arm/boot/dts/imx25.dtsi
+++ b/arch/arm/boot/dts/imx25.dtsi
@@ -496,8 +496,7 @@
 				compatible = "fsl,imx25-usb", "fsl,imx27-usb";
 				reg = <0x53ff4000 0x0200>;
 				interrupts = <37>;
-				clocks = <&clks 9>, <&clks 70>, <&clks 8>;
-				clock-names = "ipg", "ahb", "per";
+				clocks = <&clks 70>;
 				fsl,usbmisc = <&usbmisc 0>;
 				status = "disabled";
 			};
@@ -506,8 +505,7 @@
 				compatible = "fsl,imx25-usb", "fsl,imx27-usb";
 				reg = <0x53ff4400 0x0200>;
 				interrupts = <35>;
-				clocks = <&clks 9>, <&clks 70>, <&clks 8>;
-				clock-names = "ipg", "ahb", "per";
+				clocks = <&clks 70>;
 				fsl,usbmisc = <&usbmisc 1>;
 				status = "disabled";
 			};
-- 
1.7.9.5
