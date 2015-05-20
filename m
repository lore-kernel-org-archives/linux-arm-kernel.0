From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 20 May 2015 16:19:00 +0200
Subject: [PATCH 5/5] ARM64: MediaTek MT8173: Add SCPSYS device node
In-Reply-To: <1432131540-2523-1-git-send-email-s.hauer@pengutronix.de>
References: <1432131540-2523-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1432131540-2523-6-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the SCPSYS device node to the MT8173 dtsi file.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm64/boot/dts/mediatek/mt8173.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
index 924fdb6..12430f0 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
@@ -125,6 +125,16 @@
 						<GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
+		scpsys: scpsys at 10006000 {
+			compatible = "mediatek,mt8173-scpsys";
+			#power-domain-cells = <1>;
+			reg = <0 0x10006000 0 0x1000>;
+			clocks = <&clk26m>,
+				 <&topckgen CLK_TOP_MM_SEL>;
+			clock-names = "mfg", "mm";
+			infracfg = <&infracfg>;
+		};
+
 		sysirq: intpol-controller at 10200620 {
 			compatible = "mediatek,mt8173-sysirq",
 					"mediatek,mt6577-sysirq";
-- 
2.1.4
