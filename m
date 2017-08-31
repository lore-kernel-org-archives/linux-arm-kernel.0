From: hayashibara.keiji@socionext.com (Keiji Hayashibara)
Date: Fri,  1 Sep 2017 08:20:20 +0900
Subject: [PATCH v1 3/3] arm64: dts: uniphier: add efuse node for LD20
In-Reply-To: <1504221620-358-1-git-send-email-hayashibara.keiji@socionext.com>
References: <1504221620-358-1-git-send-email-hayashibara.keiji@socionext.com>
Message-ID: <1504221620-358-4-git-send-email-hayashibara.keiji@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add efuse node for UniPhier LD20 SoC.
This efuse node is included in soc-glue.

Signed-off-by: Keiji Hayashibara <hayashibara.keiji@socionext.com>
---
 arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi b/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
index de1e753..8a1f5af 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
@@ -365,6 +365,20 @@
 			};
 		};
 
+		soc-glue at 5f900000 {
+			compatible = "socionext,uniphier-ld20-soc-glue-debug",
+				     "simple-mfd";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0x0 0x5f900000 0x2000>;
+
+			efuse {
+				compatible = "socionext,uniphier-efuse",
+					     "syscon";
+				reg = <0x100 0xf00>;
+			};
+		};
+
 		gic: interrupt-controller at 5fe00000 {
 			compatible = "arm,gic-v3";
 			reg = <0x5fe00000 0x10000>,	/* GICD */
-- 
2.7.4
