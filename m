From: hs.liao@mediatek.com (HS Liao)
Date: Mon, 23 May 2016 20:23:09 +0800
Subject: [PATCH v7 3/4] arm64: dts: mt8173: Add GCE node
In-Reply-To: <1464006190-344-1-git-send-email-hs.liao@mediatek.com>
References: <1464006190-344-1-git-send-email-hs.liao@mediatek.com>
Message-ID: <1464006190-344-4-git-send-email-hs.liao@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the device node of the GCE hardware for CMDQ module.

Signed-off-by: HS Liao <hs.liao@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt8173.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
index eab7efc..63d1718 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
@@ -300,6 +300,14 @@
 			#clock-cells = <1>;
 		};
 
+		gce: gce at 10212000 {
+			compatible = "mediatek,mt8173-gce";
+			reg = <0 0x10212000 0 0x1000>;
+			interrupts = <GIC_SPI 135 IRQ_TYPE_LEVEL_LOW>;
+			clocks = <&infracfg CLK_INFRA_GCE>;
+			clock-names = "gce";
+		};
+
 		gic: interrupt-controller at 10220000 {
 			compatible = "arm,gic-400";
 			#interrupt-cells = <3>;
-- 
1.9.1
