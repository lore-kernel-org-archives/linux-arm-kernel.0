From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon,  9 Mar 2015 09:10:03 +0100
Subject: [PATCH 4/4] ARM64: MediaTek MT8173: Add SCPSYS device node
In-Reply-To: <1425888603-25800-1-git-send-email-s.hauer@pengutronix.de>
References: <1425888603-25800-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1425888603-25800-5-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the SCPSYS device node to the MT8173 dtsi file.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm64/boot/dts/mediatek/mt8173.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
index 8554ec3..9fa64ac 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
@@ -105,6 +105,12 @@
 		compatible = "simple-bus";
 		ranges;
 
+		scpsys: scpsys at 10006000 {
+			compatible = "mediatek,mt8173-scpsys";
+			#power-domain-cells = <1>;
+			reg = <0 0x10006000 0 0x1000>;
+		};
+
 		sysirq: intpol-controller at 10200620 {
 			compatible = "mediatek,mt8173-sysirq",
 					"mediatek,mt6577-sysirq";
-- 
2.1.4
