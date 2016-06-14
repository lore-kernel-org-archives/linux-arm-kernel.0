From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 14 Jun 2016 10:17:54 +0800
Subject: [PATCH 06/10] ARM: dts: sun9i: a80-optimus: Add device node for AC100
In-Reply-To: <1465870678-30128-1-git-send-email-wens@csie.org>
References: <1465870678-30128-1-git-send-email-wens@csie.org>
Message-ID: <1465870678-30128-8-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun9i-a80-optimus.dts | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm/boot/dts/sun9i-a80-optimus.dts b/arch/arm/boot/dts/sun9i-a80-optimus.dts
index 78fddd9152a5..24ef8e65a975 100644
--- a/arch/arm/boot/dts/sun9i-a80-optimus.dts
+++ b/arch/arm/boot/dts/sun9i-a80-optimus.dts
@@ -322,6 +322,27 @@
 			};
 		};
 	};
+
+	ac100: codec at e89 {
+		compatible = "x-powers,ac100";
+		reg = <0xe89>;
+
+		ac100_codec: codec {
+			compatible = "x-powers,ac100-codec";
+			interrupt-parent = <&r_pio>;
+			interrupts = <0 9 IRQ_TYPE_LEVEL_LOW>; /* PL9 */
+		};
+
+		ac100_rtc: rtc {
+			compatible = "x-powers,ac100-rtc";
+			interrupt-parent = <&nmi_intc>;
+			interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+			#clock-cells = <1>;
+			clock-output-names = "cko1_rtc",
+					     "cko2_rtc",
+					     "cko3_rtc";
+		};
+	};
 };
 
 #include "axp809.dtsi"
-- 
2.8.1
