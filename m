From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Tue,  4 Jun 2013 12:12:22 +0200
Subject: [PATCH] ARM i.MX53: Add TVE entry to i.MX53 dtsi
Message-ID: <1370340742-25172-1-git-send-email-s.trumtrar@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Philipp Zabel <p.zabel@pengutronix.de>

This adds the Television Encoder (TVEv2) device tree node
to the i.MX53 dtsi.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
---
 arch/arm/boot/dts/imx53.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
index e448b33..3895fbb 100644
--- a/arch/arm/boot/dts/imx53.dtsi
+++ b/arch/arm/boot/dts/imx53.dtsi
@@ -1066,6 +1066,16 @@
 				clock-names = "ipg", "ahb", "ptp";
 				status = "disabled";
 			};
+
+			tve: tve at 63ff0000 {
+				compatible = "fsl,imx53-tve";
+				reg = <0x63ff0000 0x1000>;
+				interrupts = <92>;
+				clocks = <&clks 69>, <&clks 116>;
+				clock-names = "tve", "di_sel";
+				crtcs = <&ipu 1>;
+				status = "disabled";
+			};
 		};
 	};
 };
-- 
1.8.2.rc2
