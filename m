From: houlong.wei@mediatek.com (Houlong Wei)
Date: Wed, 27 Jun 2018 19:16:11 +0800
Subject: [PATCH v22 3/4] arm64: dts: mt8173: Add GCE node
In-Reply-To: <1530098172-31385-1-git-send-email-houlong.wei@mediatek.com>
References: <1530098172-31385-1-git-send-email-houlong.wei@mediatek.com>
Message-ID: <1530098172-31385-4-git-send-email-houlong.wei@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the device node of the GCE hardware for CMDQ module.

Signed-off-by: Houlong Wei <houlong.wei@mediatek.com>
Signed-off-by: HS Liao <hs.liao@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt8173.dtsi |   11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
index 94597e3..d180a6d 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
@@ -18,6 +18,7 @@
 #include <dt-bindings/phy/phy.h>
 #include <dt-bindings/power/mt8173-power.h>
 #include <dt-bindings/reset/mt8173-resets.h>
+#include <dt-bindings/gce/mt8173-gce.h>
 #include "mt8173-pinfunc.h"
 
 / {
@@ -519,6 +520,16 @@
 			status = "disabled";
 		};
 
+		gce: gce at 10212000 {
+			compatible = "mediatek,mt8173-gce";
+			reg = <0 0x10212000 0 0x1000>;
+			interrupts = <GIC_SPI 135 IRQ_TYPE_LEVEL_LOW>;
+			clocks = <&infracfg CLK_INFRA_GCE>;
+			clock-names = "gce";
+			thread-num = <CMDQ_THR_MAX_COUNT>;
+			#mbox-cells = <4>;
+		};
+
 		mipi_tx0: mipi-dphy at 10215000 {
 			compatible = "mediatek,mt8173-mipi-tx";
 			reg = <0 0x10215000 0 0x1000>;
-- 
1.7.9.5
