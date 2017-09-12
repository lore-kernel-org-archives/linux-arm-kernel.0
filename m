From: weiyi.lu@mediatek.com (Weiyi Lu)
Date: Tue, 12 Sep 2017 15:21:49 +0800
Subject: [PATCH v3 9/9] arm: dts: Add power controller device node of MT2712
In-Reply-To: <1505200909-23552-1-git-send-email-weiyi.lu@mediatek.com>
References: <1505200909-23552-1-git-send-email-weiyi.lu@mediatek.com>
Message-ID: <1505200909-23552-10-git-send-email-weiyi.lu@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

add power controller node for MT2712

Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt2712e.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt2712e.dtsi b/arch/arm64/boot/dts/mediatek/mt2712e.dtsi
index 53547d9..3232e4e 100644
--- a/arch/arm64/boot/dts/mediatek/mt2712e.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt2712e.dtsi
@@ -8,6 +8,7 @@
 #include <dt-bindings/clock/mt2712-clk.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/power/mt2712-power.h>
 #include "mt2712-pinfunc.h"
 
 / {
@@ -165,6 +166,21 @@
 		interrupts = <GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>;
 	};
 
+	scpsys: scpsys at 10006000 {
+		compatible = "mediatek,mt2712-scpsys", "syscon";
+		#power-domain-cells = <1>;
+		reg = <0 0x10006000 0 0x1000>;
+		clocks = <&topckgen CLK_TOP_MM_SEL>,
+			 <&topckgen CLK_TOP_MFG_SEL>,
+			 <&topckgen CLK_TOP_VENC_SEL>,
+			 <&topckgen CLK_TOP_JPGDEC_SEL>,
+			 <&topckgen CLK_TOP_A1SYS_HP_SEL>,
+			 <&topckgen CLK_TOP_VDEC_SEL>;
+		clock-names = "mm", "mfg", "venc",
+			"jpgdec", "audio", "vdec";
+		infracfg = <&infracfg>;
+	};
+
 	uart5: serial at 1000f000 {
 		compatible = "mediatek,mt2712-uart",
 			     "mediatek,mt6577-uart";
-- 
1.9.1
