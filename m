From: hs.liao@mediatek.com (HS Liao)
Date: Thu, 30 Jun 2016 15:14:42 +0800
Subject: [PATCH v9 3/4] arm64: dts: mt8173: Add GCE node
In-Reply-To: <1467270883-1407-1-git-send-email-hs.liao@mediatek.com>
References: <1467270883-1407-1-git-send-email-hs.liao@mediatek.com>
Message-ID: <1467270883-1407-4-git-send-email-hs.liao@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the device node of the GCE hardware for CMDQ module.

Signed-off-by: HS Liao <hs.liao@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt8173.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
index 05f89c4..14a62e0 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
@@ -343,6 +343,16 @@
 			#clock-cells = <1>;
 		};
 
+		gce: gce at 10212000 {
+			compatible = "mediatek,mt8173-gce";
+			reg = <0 0x10212000 0 0x1000>;
+			interrupts = <GIC_SPI 135 IRQ_TYPE_LEVEL_LOW>;
+			clocks = <&infracfg CLK_INFRA_GCE>;
+			clock-names = "gce";
+
+			#mbox-cells = <1>;
+		};
+
 		gic: interrupt-controller at 10220000 {
 			compatible = "arm,gic-400";
 			#interrupt-cells = <3>;
-- 
1.9.1
