From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 25 Jun 2013 15:51:49 +0200
Subject: [PATCH 05/16] ARM: dts: i.MX31: Add iim node
In-Reply-To: <1372168320-22605-1-git-send-email-s.hauer@pengutronix.de>
References: <1372168320-22605-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1372168320-22605-6-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/boot/dts/imx31.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/imx31.dtsi b/arch/arm/boot/dts/imx31.dtsi
index c544925..8116778 100644
--- a/arch/arm/boot/dts/imx31.dtsi
+++ b/arch/arm/boot/dts/imx31.dtsi
@@ -94,6 +94,13 @@
 				status = "disabled";
 			};
 
+			iim: iim at 5001c000 {
+				compatible = "fsl,imx31-iim", "fsl,imx27-iim";
+				reg = <0x5001c000 0x1000>;
+				interrupts = <19>;
+				clocks = <&clks 25>;
+			};
+
 			clks: ccm at 53f80000{
 				compatible = "fsl,imx31-ccm";
 				reg = <0x53f80000 0x4000>;
-- 
1.8.3.1
