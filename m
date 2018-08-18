From: ryder.lee@mediatek.com (Ryder Lee)
Date: Sun, 19 Aug 2018 00:02:25 +0800
Subject: [PATCH v1 2/5] arm64: dts: mt7622: add a bluetooth 5 device node
In-Reply-To: <7d3ce6a89ffeb221dc3197b763521582bf300577.1534607107.git.ryder.lee@mediatek.com>
References: <7d3ce6a89ffeb221dc3197b763521582bf300577.1534607107.git.ryder.lee@mediatek.com>
Message-ID: <347fb990f33680a71b6ac825606333af79e7dfab.1534607107.git.ryder.lee@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a built-in bluetooth 5 support for MT7622.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
Acked-by: Sean Wang <sean.wang@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt7622.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt7622.dtsi b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
index d297100..b4d7934 100644
--- a/arch/arm64/boot/dts/mediatek/mt7622.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
@@ -530,6 +530,13 @@
 		reg-shift = <2>;
 		reg-io-width = <4>;
 		status = "disabled";
+
+		bluetooth {
+			compatible = "mediatek,mt7622-bluetooth";
+			power-domains = <&scpsys MT7622_POWER_DOMAIN_WB>;
+			clocks = <&clk25m>;
+			clock-names = "ref";
+		};
 	};
 
 	nandc: nfi at 1100d000 {
-- 
1.9.1
