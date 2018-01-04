From: sean.wang@mediatek.com (sean.wang at mediatek.com)
Date: Thu, 4 Jan 2018 17:40:53 +0800
Subject: [PATCH 03/12] arm64: dts: mt7622: add power domain controller device
 nodes
In-Reply-To: <cover.1515057696.git.sean.wang@mediatek.com>
References: <cover.1515057696.git.sean.wang@mediatek.com>
Message-ID: <594447389e18e97727ae5e304e30a79292a3559f.1515057696.git.sean.wang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sean Wang <sean.wang@mediatek.com>

add power domain controller nodes

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>
---
 arch/arm64/boot/dts/mediatek/mt7622.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt7622.dtsi b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
index 9730f0e..6fdc449 100644
--- a/arch/arm64/boot/dts/mediatek/mt7622.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
@@ -9,6 +9,7 @@
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/clock/mt7622-clk.h>
+#include <dt-bindings/power/mt7622-power.h>
 #include <dt-bindings/reset/mt7622-reset.h>
 
 / {
@@ -109,6 +110,20 @@
 		#reset-cells = <1>;
 	};
 
+	scpsys: scpsys at 10006000 {
+		compatible = "mediatek,mt7622-scpsys",
+			     "syscon";
+		#power-domain-cells = <1>;
+		reg = <0 0x10006000 0 0x1000>;
+		interrupts = <GIC_SPI 165 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_SPI 166 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_SPI 167 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_SPI 168 IRQ_TYPE_LEVEL_LOW>;
+		infracfg = <&infracfg>;
+		clocks = <&topckgen CLK_TOP_HIF_SEL>;
+		clock-names = "hif_sel";
+	};
+
 	sysirq: interrupt-controller at 10200620 {
 		compatible = "mediatek,mt7622-sysirq",
 			     "mediatek,mt6577-sysirq";
-- 
2.7.4
