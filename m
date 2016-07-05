From: zhiyong.tao@mediatek.com (Zhiyong Tao)
Date: Tue, 5 Jul 2016 11:50:10 +0800
Subject: [PATCH v2 3/3] arm: dts: auxadc: Add auxadc node.
In-Reply-To: <1467690610-20550-1-git-send-email-zhiyong.tao@mediatek.com>
References: <1467690610-20550-1-git-send-email-zhiyong.tao@mediatek.com>
Message-ID: <1467690610-20550-4-git-send-email-zhiyong.tao@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The commit adds auxadc nodes to the Mediatek MT2701 dtsi file.

Signed-off-by: Zhiyong Tao <zhiyong.tao@mediatek.com>
---
 arch/arm/boot/dts/mt2701.dtsi |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/mt2701.dtsi b/arch/arm/boot/dts/mt2701.dtsi
index 42d5a37..464c86a 100644
--- a/arch/arm/boot/dts/mt2701.dtsi
+++ b/arch/arm/boot/dts/mt2701.dtsi
@@ -187,6 +187,15 @@
 		      <0 0x10216000 0 0x2000>;
 	};
 
+	auxadc: auxadc at 11001000 {
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
