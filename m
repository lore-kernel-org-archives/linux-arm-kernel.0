From: hs.liao@mediatek.com (HS Liao)
Date: Tue, 27 Dec 2016 11:39:20 +0800
Subject: [PATCH v18 3/4] arm64: dts: mt8173: Add GCE node
In-Reply-To: <1482809961-31930-1-git-send-email-hs.liao@mediatek.com>
References: <1482809961-31930-1-git-send-email-hs.liao@mediatek.com>
Message-ID: <1482809961-31930-4-git-send-email-hs.liao@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the device node of the GCE hardware for CMDQ module.

Signed-off-by: HS Liao <hs.liao@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt8173.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
index 12e7027..9f93447 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
@@ -422,6 +422,16 @@
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
