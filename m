From: flora.fu@mediatek.com (Flora Fu)
Date: Fri, 26 Dec 2014 17:05:51 +0800
Subject: [PATCH v4 3/3] arm: dts: mt8135: Add Reset Controller for MediaTek SoC
In-Reply-To: <1419584751-18149-1-git-send-email-flora.fu@mediatek.com>
References: <1419584751-18149-1-git-send-email-flora.fu@mediatek.com>
Message-ID: <1419584751-18149-4-git-send-email-flora.fu@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add reset controller to MT8135.dtsi.

Acked-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Flora Fu <flora.fu@mediatek.com>
---
 arch/arm/boot/dts/mt8135.dtsi | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm/boot/dts/mt8135.dtsi b/arch/arm/boot/dts/mt8135.dtsi
index ec83e69..989e488 100644
--- a/arch/arm/boot/dts/mt8135.dtsi
+++ b/arch/arm/boot/dts/mt8135.dtsi
@@ -14,6 +14,7 @@
 
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/reset-controller/mt8135-resets.h>
 #include "skeleton64.dtsi"
 
 / {
@@ -100,6 +101,34 @@
 		compatible = "simple-bus";
 		ranges;
 
+		infracfg: syscon at 10001000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "mediatek,mt8135-infracfg", "syscon";
+			reg = <0 0x10001000 0 0x1000>;
+			#clock-cells = <1>;
+
+			infrarst: reset-controller at 30 {
+				#reset-cells = <1>;
+				compatible = "mediatek,mt8135-infracfg-reset", "mediatek,reset";
+				reg = <0x30 0x8>;
+			};
+		};
+
+		pericfg: syscon at 10003000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "mediatek,mt8135-pericfg", "syscon";
+			reg = <0 0x10003000 0 0x1000>;
+			#clock-cells = <1>;
+
+			perirst: reset-controller at 00 {
+				#reset-cells = <1>;
+				compatible = "mediatek,mt8135-pericfg-reset", "mediatek,reset";
+				reg = <0x00 0x8>;
+			};
+		};
+
 		timer: timer at 10008000 {
 			compatible = "mediatek,mt8135-timer",
 					"mediatek,mt6577-timer";
-- 
1.8.1.1.dirty
