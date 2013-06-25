From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 25 Jun 2013 15:51:51 +0200
Subject: [PATCH 07/16] ARM: dts: i.MX51: Add iim node
In-Reply-To: <1372168320-22605-1-git-send-email-s.hauer@pengutronix.de>
References: <1372168320-22605-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1372168320-22605-8-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/boot/dts/imx51.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/imx51.dtsi b/arch/arm/boot/dts/imx51.dtsi
index 25764b50..cb6e09b 100644
--- a/arch/arm/boot/dts/imx51.dtsi
+++ b/arch/arm/boot/dts/imx51.dtsi
@@ -628,6 +628,13 @@
 			reg = <0x80000000 0x10000000>;
 			ranges;
 
+			iim: iim at 83f98000 {
+				compatible = "fsl,imx51-iim", "fsl,imx27-iim";
+				reg = <0x83f98000 0x4000>;
+				interrupts = <69>;
+				clocks = <&clks 107>;
+			};
+
 			ecspi2: ecspi at 83fac000 {
 				#address-cells = <1>;
 				#size-cells = <0>;
-- 
1.8.3.1
