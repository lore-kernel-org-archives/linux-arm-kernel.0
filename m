From: ryder.lee@mediatek.com (Ryder Lee)
Date: Fri, 20 Oct 2017 17:46:47 +0800
Subject: [PATCH 3/3] arm: dts: mt7623: remove unused compatible string for pio
 node
In-Reply-To: <4cabb9ad6f59b42cc10ba25a9eb0ce68f77d0a43.1508492662.git.ryder.lee@mediatek.com>
References: <4cabb9ad6f59b42cc10ba25a9eb0ce68f77d0a43.1508492662.git.ryder.lee@mediatek.com>
Message-ID: <7e691d4807a8b281f5c015fb132412f0e03b89d1.1508492662.git.ryder.lee@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

MT7623 has its own compatible in pinctrl driver so we don't need the
backward compatible for it.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 arch/arm/boot/dts/mt7623.dtsi | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/mt7623.dtsi b/arch/arm/boot/dts/mt7623.dtsi
index 84a3f27..f663bc2 100644
--- a/arch/arm/boot/dts/mt7623.dtsi
+++ b/arch/arm/boot/dts/mt7623.dtsi
@@ -227,8 +227,7 @@
 	};
 
 	pio: pinctrl at 10005000 {
-		compatible = "mediatek,mt7623-pinctrl",
-			     "mediatek,mt2701-pinctrl";
+		compatible = "mediatek,mt7623-pinctrl";
 		reg = <0 0x1000b000 0 0x1000>;
 		mediatek,pctl-regmap = <&syscfg_pctl_a>;
 		pins-are-numbered;
-- 
1.9.1
