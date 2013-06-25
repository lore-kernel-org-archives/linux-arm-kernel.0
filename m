From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 25 Jun 2013 15:51:52 +0200
Subject: [PATCH 08/16] ARM: dts: i.MX53: Add iim node
In-Reply-To: <1372168320-22605-1-git-send-email-s.hauer@pengutronix.de>
References: <1372168320-22605-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1372168320-22605-9-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/boot/dts/imx53.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
index 569aa9f..42f4456 100644
--- a/arch/arm/boot/dts/imx53.dtsi
+++ b/arch/arm/boot/dts/imx53.dtsi
@@ -957,6 +957,13 @@
 			reg = <0x60000000 0x10000000>;
 			ranges;
 
+			iim: iim at 63f98000 {
+				compatible = "fsl,imx53-iim", "fsl,imx27-iim";
+				reg = <0x63f98000 0x4000>;
+				interrupts = <69>;
+				clocks = <&clks 107>;
+			};
+
 			uart5: serial at 63f90000 {
 				compatible = "fsl,imx53-uart", "fsl,imx21-uart";
 				reg = <0x63f90000 0x4000>;
-- 
1.8.3.1
