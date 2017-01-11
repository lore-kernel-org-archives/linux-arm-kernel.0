From: erin.lo@mediatek.com (Erin Lo)
Date: Wed, 11 Jan 2017 16:38:44 +0800
Subject: [PATCH 4/4] arm: dts: mt2701: Add auxadc device node.
In-Reply-To: <1484123924-8946-1-git-send-email-erin.lo@mediatek.com>
References: <1484123924-8946-1-git-send-email-erin.lo@mediatek.com>
Message-ID: <1484123924-8946-5-git-send-email-erin.lo@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Zhiyong Tao <zhiyong.tao@mediatek.com>

Add auxadc device node for MT2701.

Signed-off-by: Zhiyong Tao <zhiyong.tao@mediatek.com>
Signed-off-by: Erin Lo <erin.lo@mediatek.com>
---
 arch/arm/boot/dts/mt2701.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/mt2701.dtsi b/arch/arm/boot/dts/mt2701.dtsi
index 1182c43..4f52019 100644
--- a/arch/arm/boot/dts/mt2701.dtsi
+++ b/arch/arm/boot/dts/mt2701.dtsi
@@ -208,6 +208,15 @@
 		      <0 0x10216000 0 0x2000>;
 	};
 
+	auxadc: adc at 11001000 {
+		compatible = "mediatek,mt2701-auxadc";
+		reg = <0 0x11001000 0 0x1000>;
+		clocks = <&pericfg CLK_PERI_AUXADC>;
+		clock-names = "main";
+		#io-channel-cells = <1>;
+		status = "disabled";
+	};
+
 	uart0: serial at 11002000 {
 		compatible = "mediatek,mt2701-uart",
 			     "mediatek,mt6577-uart";
-- 
1.9.1
