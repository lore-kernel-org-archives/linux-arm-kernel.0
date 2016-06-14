From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Tue, 14 Jun 2016 12:01:41 +0900
Subject: [PATCH 1/3] arm64: dts: uniphier: add SoC-Glue node to UniPhier 64bit
 SoCs
In-Reply-To: <1465873303-30754-1-git-send-email-yamada.masahiro@socionext.com>
References: <1465873303-30754-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1465873303-30754-2-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This node consists of various system-level configuration registers.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm64/boot/dts/socionext/uniphier-ph1-ld20.dtsi | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/socionext/uniphier-ph1-ld20.dtsi b/arch/arm64/boot/dts/socionext/uniphier-ph1-ld20.dtsi
index 9532880..31dc51b 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ph1-ld20.dtsi
+++ b/arch/arm64/boot/dts/socionext/uniphier-ph1-ld20.dtsi
@@ -264,9 +264,13 @@
 			reg = <0x59801000 0x400>;
 		};
 
-		pinctrl: pinctrl at 5f801000 {
-			compatible = "socionext,ph1-ld20-pinctrl", "syscon";
-			reg = <0x5f801000 0xe00>;
+		soc-glue at 5f800000 {
+			compatible = "simple-mfd", "syscon";
+			reg = <0x5f800000 0x2000>;
+
+			pinctrl: pinctrl {
+				 compatible = "socionext,uniphier-ld20-pinctrl";
+			};
 		};
 
 		gic: interrupt-controller at 5fe00000 {
-- 
1.9.1
