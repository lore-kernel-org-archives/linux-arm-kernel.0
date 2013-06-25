From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 25 Jun 2013 15:51:48 +0200
Subject: [PATCH 04/16] ARM: dts: i.MX27: Add iim node
In-Reply-To: <1372168320-22605-1-git-send-email-s.hauer@pengutronix.de>
References: <1372168320-22605-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1372168320-22605-5-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/boot/dts/imx27.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/imx27.dtsi b/arch/arm/boot/dts/imx27.dtsi
index df425a7..db139bf 100644
--- a/arch/arm/boot/dts/imx27.dtsi
+++ b/arch/arm/boot/dts/imx27.dtsi
@@ -348,6 +348,13 @@
 				clocks = <&clks 41>, <&clks 61>;
 				clock-names = "ipg", "per";
 			};
+
+			iim: iim at 10028000 {
+				compatible = "fsl,imx27-iim";
+				reg = <0x10028000 0x1000>;
+				interrupts = <62>;
+				clocks = <&clks 38>;
+			};
 		};
 
 		aipi at 10020000 { /* AIPI2 */
-- 
1.8.3.1
