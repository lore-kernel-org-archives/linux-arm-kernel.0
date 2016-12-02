From: jamesjj.liao@mediatek.com (James Liao)
Date: Fri, 2 Dec 2016 10:06:39 +0800
Subject: [PATCH] arm: dts: mt2701: Sort DT nodes by register address
Message-ID: <1480644399-14865-1-git-send-email-jamesjj.liao@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch rearrange MT2701 DT nodes to keep them in ascending order.

Signed-off-by: James Liao <jamesjj.liao@mediatek.com>
---
This patch is based on latest v4.9-next/dts branch of [1], to fix MT2701
DT nodes ordering.

[1] https://github.com/mbgg/linux-mediatek/tree/v4.9-next/dts

 arch/arm/boot/dts/mt2701.dtsi | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/arch/arm/boot/dts/mt2701.dtsi b/arch/arm/boot/dts/mt2701.dtsi
index 7eab6f4..73f4b7c 100644
--- a/arch/arm/boot/dts/mt2701.dtsi
+++ b/arch/arm/boot/dts/mt2701.dtsi
@@ -96,24 +96,6 @@
 			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
 	};
 
-	pio: pinctrl at 10005000 {
-		compatible = "mediatek,mt2701-pinctrl";
-		reg = <0 0x1000b000 0 0x1000>;
-		mediatek,pctl-regmap = <&syscfg_pctl_a>;
-		pins-are-numbered;
-		gpio-controller;
-		#gpio-cells = <2>;
-		interrupt-controller;
-		#interrupt-cells = <2>;
-		interrupts = <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>;
-	};
-
-	syscfg_pctl_a: syscfg at 10005000 {
-		compatible = "mediatek,mt2701-pctl-a-syscfg", "syscon";
-		reg = <0 0x10005000 0 0x1000>;
-	};
-
 	topckgen: syscon at 10000000 {
 		compatible = "mediatek,mt2701-topckgen", "syscon";
 		reg = <0 0x10000000 0 0x1000>;
@@ -134,6 +116,24 @@
 		#reset-cells = <1>;
 	};
 
+	pio: pinctrl at 10005000 {
+		compatible = "mediatek,mt2701-pinctrl";
+		reg = <0 0x1000b000 0 0x1000>;
+		mediatek,pctl-regmap = <&syscfg_pctl_a>;
+		pins-are-numbered;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		interrupts = <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>;
+	};
+
+	syscfg_pctl_a: syscfg at 10005000 {
+		compatible = "mediatek,mt2701-pctl-a-syscfg", "syscon";
+		reg = <0 0x10005000 0 0x1000>;
+	};
+
 	watchdog: watchdog at 10007000 {
 		compatible = "mediatek,mt2701-wdt",
 			     "mediatek,mt6589-wdt";
-- 
1.9.1
