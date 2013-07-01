From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Mon,  1 Jul 2013 11:06:09 +0200
Subject: [PATCH v2] ARM: dts: add sram for imx53 and imx6q
Message-ID: <1372669569-12446-1-git-send-email-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch enables the On-Chip SRAM (OCRAM) on i.MX53 and i.MX6 SoCs.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Reviewed-by: Shawn Guo <shawn.guo@linaro.org>
---
Changes since v1:
 - Fixed compatible property to only include "mmio-sram"
 - Renamed device nodes to "sram"
---
 arch/arm/boot/dts/imx53.dtsi   | 5 +++++
 arch/arm/boot/dts/imx6qdl.dtsi | 6 ++++++
 2 files changed, 11 insertions(+)
diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
index d437bfb..cec6cdd 100644
--- a/arch/arm/boot/dts/imx53.dtsi
+++ b/arch/arm/boot/dts/imx53.dtsi
@@ -1087,5 +1087,10 @@
 				status = "disabled";
 			};
 		};
+
+		ocram: sram at f8000000 {
+			compatible = "mmio-sram";
+			reg = <0xf8000000 0x20000>;
+		};
 	};
 };
diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index 2d73f83..4033ad4 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -100,6 +100,12 @@
 			status = "disabled";
 		};
 
+		ocram: sram at 00900000 {
+			compatible = "mmio-sram";
+			reg = <0x00900000 0x3f000>;
+			clocks = <&clks 142>;
+		};
+
 		timer at 00a00600 {
 			compatible = "arm,cortex-a9-twd-timer";
 			reg = <0x00a00600 0x20>;
-- 
1.8.3.1
