From: zhiyong.tao@mediatek.com (Zhiyong Tao)
Date: Thu, 21 Jul 2016 15:17:29 +0800
Subject: [PATCH v5 3/3] arm: dts: mt2701: Add auxadc node.
In-Reply-To: <1469085449-22679-1-git-send-email-zhiyong.tao@mediatek.com>
References: <1469085449-22679-1-git-send-email-zhiyong.tao@mediatek.com>
Message-ID: <1469085449-22679-4-git-send-email-zhiyong.tao@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The commit adds auxadc nodes to the Mediatek MT2701 dtsi file.

Signed-off-by: Zhiyong Tao <zhiyong.tao@mediatek.com>
---
 arch/arm/boot/dts/mt2701.dtsi |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/mt2701.dtsi b/arch/arm/boot/dts/mt2701.dtsi
index 42d5a37..c0a2644 100644
--- a/arch/arm/boot/dts/mt2701.dtsi
+++ b/arch/arm/boot/dts/mt2701.dtsi
@@ -187,6 +187,15 @@
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
1.7.9.5
