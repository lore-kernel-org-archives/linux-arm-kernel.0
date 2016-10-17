From: hs.liao@mediatek.com (HS Liao)
Date: Mon, 17 Oct 2016 18:11:56 +0800
Subject: [PATCH v15 3/4] arm64: dts: mt8173: Add GCE node
In-Reply-To: <1476699117-3001-1-git-send-email-hs.liao@mediatek.com>
References: <1476699117-3001-1-git-send-email-hs.liao@mediatek.com>
Message-ID: <1476699117-3001-4-git-send-email-hs.liao@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the device node of the GCE hardware for CMDQ module.

Signed-off-by: HS Liao <hs.liao@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt8173.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
index 1c71e25..d50c044 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
@@ -414,6 +414,16 @@
 			status = "disabled";
 		};
 
+		gce: gce at 10212000 {
+			compatible = "mediatek,mt8173-gce";
+			reg = <0 0x10212000 0 0x1000>;
+			interrupts = <GIC_SPI 135 IRQ_TYPE_LEVEL_LOW>;
+			clocks = <&infracfg CLK_INFRA_GCE>;
+			clock-names = "gce";
+
+			#mbox-cells = <2>;
+		};
+
 		mipi_tx0: mipi-dphy at 10215000 {
 			compatible = "mediatek,mt8173-mipi-tx";
 			reg = <0 0x10215000 0 0x1000>;
-- 
1.9.1
