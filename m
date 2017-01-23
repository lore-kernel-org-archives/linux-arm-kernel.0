From: john@phrozen.org (John Crispin)
Date: Mon, 23 Jan 2017 12:29:22 +0100
Subject: [PATCH 03/16] arm: dts: add power domain controller device node
In-Reply-To: <1485170975-51813-1-git-send-email-john@phrozen.org>
References: <1485170975-51813-1-git-send-email-john@phrozen.org>
Message-ID: <1485170975-51813-4-git-send-email-john@phrozen.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add power domain controller node (scpsys) for MT7623.

Signed-off-by: John Crispin <john@phrozen.org>
---
 arch/arm/boot/dts/mt7623.dtsi |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/mt7623.dtsi b/arch/arm/boot/dts/mt7623.dtsi
index 87a55f5..9252680 100644
--- a/arch/arm/boot/dts/mt7623.dtsi
+++ b/arch/arm/boot/dts/mt7623.dtsi
@@ -15,6 +15,7 @@
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/clock/mt2701-clk.h>
+#include <dt-bindings/power/mt2701-power.h>
 #include <dt-bindings/reset/mt2701-resets.h>
 #include "skeleton64.dtsi"
 
@@ -104,6 +105,19 @@
 		#reset-cells = <1>;
 	};
 
+	scpsys: scpsys at 10006000 {
+		compatible = "mediatek,mt7623-scpsys",
+			     "mediatek,mt2701-scpsys",
+			     "syscon";
+		#power-domain-cells = <1>;
+		reg = <0 0x10006000 0 0x1000>;
+		infracfg = <&infracfg>;
+		clocks = <&topckgen CLK_TOP_MM_SEL>,
+			 <&topckgen CLK_TOP_MFG_SEL>,
+			 <&topckgen CLK_TOP_ETHIF_SEL>;
+		clock-names = "mm", "mfg", "ethif";
+	};
+
 	watchdog: watchdog at 10007000 {
 		compatible = "mediatek,mt7623-wdt",
 			     "mediatek,mt6589-wdt";
-- 
1.7.10.4
