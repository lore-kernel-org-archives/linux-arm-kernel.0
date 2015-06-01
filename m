From: eddie.huang@mediatek.com (Eddie Huang)
Date: Mon, 1 Jun 2015 14:29:12 +0800
Subject: [PATCH 1/2] arm64: dts: mt8173: Add watchdog device node
In-Reply-To: <1433140153-22436-1-git-send-email-eddie.huang@mediatek.com>
References: <1433140153-22436-1-git-send-email-eddie.huang@mediatek.com>
Message-ID: <1433140153-22436-2-git-send-email-eddie.huang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add MT8173 watchdog device node.

Signed-off-by: Eddie Huang <eddie.huang@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt8173.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
index 30ac8dd..b52ec43 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
@@ -160,6 +160,12 @@
 						<GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
+		watchdog: watchdog at 10007000 {
+			compatible = "mediatek,mt8173-wdt",
+				     "mediatek,mt6589-wdt";
+			reg = <0 0x10007000 0 0x100>;
+		};
+
 		sysirq: intpol-controller at 10200620 {
 			compatible = "mediatek,mt8173-sysirq",
 					"mediatek,mt6577-sysirq";
-- 
1.8.1.1.dirty
