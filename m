From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Wed, 13 Feb 2013 18:34:28 +0100
Subject: [PATCH v2 4/8] ARM i.MX6q: Link system reset controller (SRC) to IPU
 in DT
In-Reply-To: <1360776872-18584-1-git-send-email-p.zabel@pengutronix.de>
References: <1360776872-18584-1-git-send-email-p.zabel@pengutronix.de>
Message-ID: <1360776872-18584-5-git-send-email-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Reviewed-by: Stephen Warren <swarren@nvidia.com>
---
Changes since v1:
 - Fixed resets property in ipu2 device node.
---
 arch/arm/boot/dts/imx6q.dtsi |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
index ff1205e..03ad5d5 100644
--- a/arch/arm/boot/dts/imx6q.dtsi
+++ b/arch/arm/boot/dts/imx6q.dtsi
@@ -555,6 +555,7 @@
 				compatible = "fsl,imx6q-src";
 				reg = <0x020d8000 0x4000>;
 				interrupts = <0 91 0x04 0 96 0x04>;
+				#reset-cells = <1>;
 			};
 
 			gpc: gpc at 020dc000 {
@@ -1046,6 +1047,7 @@
 			interrupts = <0 6 0x4 0 5 0x4>;
 			clocks = <&clks 130>, <&clks 131>, <&clks 132>;
 			clock-names = "bus", "di0", "di1";
+			resets = <&src 2>;
 		};
 
 		ipu2: ipu at 02800000 {
@@ -1055,6 +1057,7 @@
 			interrupts = <0 8 0x4 0 7 0x4>;
 			clocks = <&clks 133>, <&clks 134>, <&clks 137>;
 			clock-names = "bus", "di0", "di1";
+			resets = <&src 4>;
 		};
 	};
 };
-- 
1.7.10.4
