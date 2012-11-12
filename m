From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 12 Nov 2012 16:23:28 +0100
Subject: [PATCH 6/7] ARM i.MX6: Add IPU support
In-Reply-To: <1352733809-27230-1-git-send-email-s.hauer@pengutronix.de>
References: <1352733809-27230-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1352733809-27230-7-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the IPU devices to the devicetree.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/boot/dts/imx6q.dtsi |   18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
index f3990b0..39d3433 100644
--- a/arch/arm/boot/dts/imx6q.dtsi
+++ b/arch/arm/boot/dts/imx6q.dtsi
@@ -1001,5 +1001,23 @@
 				status = "disabled";
 			};
 		};
+
+		ipu1: ipu at 02400000 {
+			#crtc-cells = <1>;
+			compatible = "fsl,imx6q-ipu";
+			reg = <0x02400000 0x400000>;
+			interrupts = <0 6 0x4 0 5 0x4>;
+			clocks = <&clks 130>, <&clks 131>, <&clks 132>;
+			clock-names = "bus", "di0", "di1";
+		};
+
+		ipu2: ipu at 02800000 {
+			#crtc-cells = <1>;
+			compatible = "fsl,imx6q-ipu";
+			reg = <0x02800000 0x400000>;
+			interrupts = <0 8 0x4 0 7 0x4>;
+			clocks = <&clks 133>, <&clks 134>, <&clks 137>;
+			clock-names = "bus", "di0", "di1";
+		};
 	};
 };
-- 
1.7.10.4
