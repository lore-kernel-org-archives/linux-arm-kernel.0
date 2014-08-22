From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Fri, 22 Aug 2014 14:02:27 +0200
Subject: [PATCH] ARM: dts: i.MX53: add pmu node
Message-ID: <1408708947-16071-1-git-send-email-s.trumtrar@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The i.MX53 has a Cortex-A8 Performance Monitor Unit.

Add it to the dtsi.

Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
---
 arch/arm/boot/dts/imx53.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
index 64fa27b..79fec00 100644
--- a/arch/arm/boot/dts/imx53.dtsi
+++ b/arch/arm/boot/dts/imx53.dtsi
@@ -744,5 +744,10 @@
 			reg = <0xf8000000 0x20000>;
 			clocks = <&clks IMX5_CLK_OCRAM>;
 		};
+
+		pmu {
+			compatible = "arm,cortex-a8-pmu";
+			interrupts = <77>;
+		};
 	};
 };
-- 
2.1.0.rc1
