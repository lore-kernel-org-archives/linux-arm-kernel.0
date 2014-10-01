From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Wed,  1 Oct 2014 12:05:31 +0200
Subject: [PATCH 2/2] ARM: i.MX53: dts: add sahara module
In-Reply-To: <1412157931-32752-1-git-send-email-s.trumtrar@pengutronix.de>
References: <1412157931-32752-1-git-send-email-s.trumtrar@pengutronix.de>
Message-ID: <1412157931-32752-2-git-send-email-s.trumtrar@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The i.MX53 has a SAHARA v4 core. Add it to the dtsi.

Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
---
 arch/arm/boot/dts/imx53.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
index 76948d79f707..a4890c10465a 100644
--- a/arch/arm/boot/dts/imx53.dtsi
+++ b/arch/arm/boot/dts/imx53.dtsi
@@ -765,6 +765,16 @@
 				resets = <&src 1>;
 				iram = <&ocram>;
 			};
+
+			sahara: crypto at 63ff8000 {
+				compatible = "fsl,imx53-sahara";
+				reg = <0x63ff8000 0x4000>;
+				interrupts = <19 20>;
+				clocks = <&clks IMX5_CLK_SAHARA_IPG_GATE>,
+				         <&clks IMX5_CLK_SAHARA_IPG_GATE>;
+				clock-names = "ipg", "ahb";
+				status = "disabled";
+			};
 		};
 
 		ocram: sram at f8000000 {
-- 
2.1.0
