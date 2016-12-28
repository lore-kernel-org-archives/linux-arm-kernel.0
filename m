From: jamesjj.liao@mediatek.com (James Liao)
Date: Wed, 28 Dec 2016 13:46:46 +0800
Subject: [PATCH 3/3] arm: dts: mt2701: Add power domain controller device node
In-Reply-To: <1482904006-44232-1-git-send-email-jamesjj.liao@mediatek.com>
References: <1482904006-44232-1-git-send-email-jamesjj.liao@mediatek.com>
Message-ID: <1482904006-44232-4-git-send-email-jamesjj.liao@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add power domain controller node (scpsys) for MT2701.

Signed-off-by: James Liao <jamesjj.liao@mediatek.com>
---
 arch/arm/boot/dts/mt2701.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/mt2701.dtsi b/arch/arm/boot/dts/mt2701.dtsi
index 150c48d..bdf8954 100644
--- a/arch/arm/boot/dts/mt2701.dtsi
+++ b/arch/arm/boot/dts/mt2701.dtsi
@@ -13,6 +13,7 @@
  */
 
 #include <dt-bindings/clock/mt2701-clk.h>
+#include <dt-bindings/power/mt2701-power.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/reset/mt2701-resets.h>
@@ -134,6 +135,17 @@
 		reg = <0 0x10005000 0 0x1000>;
 	};
 
+	scpsys: scpsys at 10006000 {
+		compatible = "mediatek,mt2701-scpsys", "syscon";
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
 		compatible = "mediatek,mt2701-wdt",
 			     "mediatek,mt6589-wdt";
-- 
1.9.1
