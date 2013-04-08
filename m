From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Mon,  8 Apr 2013 18:16:34 +0200
Subject: [PATCH 1/2] ARM i.MX53: Add TVE entry to i.MX53 dtsi
In-Reply-To: <1365437795-30074-1-git-send-email-p.zabel@pengutronix.de>
References: <1365437795-30074-1-git-send-email-p.zabel@pengutronix.de>
Message-ID: <1365437795-30074-2-git-send-email-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the Television Encoder (TVEv2) device tree node
to the i.MX53 dtsi.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 arch/arm/boot/dts/imx53.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
index 845982e..d847502 100644
--- a/arch/arm/boot/dts/imx53.dtsi
+++ b/arch/arm/boot/dts/imx53.dtsi
@@ -781,6 +781,16 @@
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
