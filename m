From: flora.fu@mediatek.com (flora.fu at mediatek.com)
Date: Thu, 30 Oct 2014 11:12:13 +0800
Subject: [PATCH 3/3] ARM: dts: mt8135: Add Reset Controller for MediaTek SoC
In-Reply-To: <1414638733-10080-1-git-send-email-flora.fu@mediatek.com>
References: <1414638733-10080-1-git-send-email-flora.fu@mediatek.com>
Message-ID: <1414638733-10080-4-git-send-email-flora.fu@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Flora Fu <flora.fu@mediatek.com>

Add reset controller to MT8135 board dts.

Signed-off-by: Flora Fu <flora.fu@mediatek.com>
---
 arch/arm/boot/dts/mt8135.dtsi | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm/boot/dts/mt8135.dtsi b/arch/arm/boot/dts/mt8135.dtsi
index 90a56ad..0b1ddc9 100644
--- a/arch/arm/boot/dts/mt8135.dtsi
+++ b/arch/arm/boot/dts/mt8135.dtsi
@@ -102,6 +102,28 @@
 			clock-names = "system-clk", "rtc-clk";
 		};
 
+		infracfg: syscon at 10001000 {
+			compatible = "mediatek,mt8135-infracfg", "syscon";
+			reg = <0 0x10001000 0 0x1000>;
+		};
+
+		pericfg: syscon at 10003000 {
+			compatible = "mediatek,mt8135-pericfg", "syscon";
+			reg = <0 0x10003000 0 0x1000>;
+		};
+
+		infrarst: reset-controller at 10001030 {
+			#reset-cells = <1>;
+			compatible = "mediatek,mt8135-infracfg-reset", "mediatek,reset";
+			mediatek,syscon-reset = <&infracfg 0x30 0x8>;
+		};
+
+		perirst: reset-controller at 10003000 {
+			#reset-cells = <1>;
+			compatible = "mediatek,mt8135-pericfg-reset", "mediatek,reset";
+			mediatek,syscon-reset = <&pericfg 0x00 0x8>;
+		};
+
 		gic: interrupt-controller at 10211000 {
 			compatible = "arm,cortex-a15-gic";
 			interrupt-controller;
-- 
1.8.1.1.dirty
