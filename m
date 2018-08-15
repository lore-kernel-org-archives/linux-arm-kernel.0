From: ryder.lee@mediatek.com (Ryder Lee)
Date: Wed, 15 Aug 2018 13:18:14 +0800
Subject: [PATCH 2/5] arm64: dts: mt7622: add a bluetooth 5 device node
In-Reply-To: <68c4ca0158518d6bf50f2f7becfcb87ff3ce158a.1534130854.git.ryder.lee@mediatek.com>
References: <68c4ca0158518d6bf50f2f7becfcb87ff3ce158a.1534130854.git.ryder.lee@mediatek.com>
Message-ID: <aba82b5c68c840a36b902e7cb7eab4ed4516f003.1534130854.git.ryder.lee@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a built-in bluetooth 5 support for MT7622.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt7622.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt7622.dtsi b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
index b235df7..f8c3495 100644
--- a/arch/arm64/boot/dts/mediatek/mt7622.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
@@ -515,6 +515,13 @@
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
