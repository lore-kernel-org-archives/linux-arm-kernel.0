From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 10 Mar 2014 17:54:42 -0300
Subject: [PATCH 4/7] ARM: dts: mx25: Let the USB PHY nodes be enabled by
 default
In-Reply-To: <1394484885-21262-1-git-send-email-festevam@gmail.com>
References: <1394484885-21262-1-git-send-email-festevam@gmail.com>
Message-ID: <1394484885-21262-4-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

As there is no physical clock needed to turn on the USB PHYs, let's keep them
always enabled.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/boot/dts/imx25.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx25.dtsi b/arch/arm/boot/dts/imx25.dtsi
index a69fd46..ab5c282 100644
--- a/arch/arm/boot/dts/imx25.dtsi
+++ b/arch/arm/boot/dts/imx25.dtsi
@@ -484,12 +484,10 @@
 
 			usbphy1: usbphy at 1 {
 				compatible = "usb-nop-xceiv";
-				status = "disabled";
 			};
 
 			usbphy2: usbphy at 2 {
 				compatible = "usb-nop-xceiv";
-				status = "disabled";
 			};
 
 			usbotg: usb at 53ff4000 {
-- 
1.8.1.2
