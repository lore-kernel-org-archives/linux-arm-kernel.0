From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 25 Jun 2013 15:51:50 +0200
Subject: [PATCH 06/16] ARM: dts: i.MX25: Add iim node
In-Reply-To: <1372168320-22605-1-git-send-email-s.hauer@pengutronix.de>
References: <1372168320-22605-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1372168320-22605-7-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/boot/dts/imx25.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/imx25.dtsi b/arch/arm/boot/dts/imx25.dtsi
index 7011539..a918b23 100644
--- a/arch/arm/boot/dts/imx25.dtsi
+++ b/arch/arm/boot/dts/imx25.dtsi
@@ -444,6 +444,13 @@
 				interrupts = <26>;
 			};
 
+			iim: iim at 53ff0000 {
+				compatible = "fsl,imx25-iim", "fsl,imx27-iim";
+				reg = <0x53ff0000 0x4000>;
+				interrupts = <19>;
+				clocks = <&clks 99>;
+			};
+
 			usbphy1: usbphy at 1 {
 				compatible = "nop-usbphy";
 				status = "disabled";
-- 
1.8.3.1
