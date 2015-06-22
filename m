From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 22 Jun 2015 08:35:42 +0200
Subject: [PATCH 4/4] ARM64: MediaTek MT8173: Add SCPSYS device node
In-Reply-To: <1434954942-30179-1-git-send-email-s.hauer@pengutronix.de>
References: <1434954942-30179-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1434954942-30179-5-git-send-email-s.hauer@pengutronix.de>
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
