From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 20 Jun 2016 10:52:16 +0800
Subject: [PATCH v3 6/8] ARM: dts: sun9i: a80-optimus: Add device node for AC100
In-Reply-To: <1466391138-12862-1-git-send-email-wens@csie.org>
References: <1466391138-12862-1-git-send-email-wens@csie.org>
Message-ID: <1466391138-12862-7-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
Changes since v2: none
Changes since v1: none
---
 arch/arm/boot/dts/sun9i-a80-optimus.dts | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm/boot/dts/sun9i-a80-optimus.dts b/arch/arm/boot/dts/sun9i-a80-optimus.dts
index 7fd22e888602..3b013dc5fef1 100644
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
