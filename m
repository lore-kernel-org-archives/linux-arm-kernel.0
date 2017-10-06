From: hayashibara.keiji@socionext.com (Keiji Hayashibara)
Date: Fri,  6 Oct 2017 14:03:00 +0900
Subject: [PATCH v2 3/3] arm64: dts: uniphier: add efuse node for LD20
In-Reply-To: <1507266180-11840-1-git-send-email-hayashibara.keiji@socionext.com>
References: <1507266180-11840-1-git-send-email-hayashibara.keiji@socionext.com>
Message-ID: <1507266180-11840-4-git-send-email-hayashibara.keiji@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add efuse node for UniPhier LD20 SoC.
This efuse node is included in soc-glue.

Signed-off-by: Keiji Hayashibara <hayashibara.keiji@socionext.com>
---
 arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi b/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
index a29c279..ddefde6 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
@@ -376,6 +376,24 @@
 			};
 		};
 
+		soc-glue at 5f900000 {
+			compatible = "socionext,uniphier-ld20-soc-glue-debug",
+				     "simple-mfd";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0x0 0x5f900000 0x2000>;
+
+			efuse at 100 {
+				compatible = "socionext,uniphier-efuse";
+				reg = <0x100 0x28>;
+			};
+
+			efuse at 200 {
+				compatible = "socionext,uniphier-efuse";
+				reg = <0x200 0x68>;
+			};
+		};
+
 		aidet: aidet at 5fc20000 {
 			compatible = "socionext,uniphier-ld20-aidet";
 			reg = <0x5fc20000 0x200>;
-- 
2.7.4
