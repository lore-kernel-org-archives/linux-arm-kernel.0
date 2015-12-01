From: wens@csie.org (Chen-Yu Tsai)
Date: Tue,  1 Dec 2015 13:47:20 +0800
Subject: [PATCH 2/7] ARM: dts: sun9i: Add A80 R_PIO pin controller device node
In-Reply-To: <1448948845-28347-1-git-send-email-wens@csie.org>
References: <1448948845-28347-1-git-send-email-wens@csie.org>
Message-ID: <1448948845-28347-3-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The A80 has a secondary pin controller. Add a device node for it.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun9i-a80.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/sun9i-a80.dtsi b/arch/arm/boot/dts/sun9i-a80.dtsi
index eb69a62f6bc4..d02ee5d520e2 100644
--- a/arch/arm/boot/dts/sun9i-a80.dtsi
+++ b/arch/arm/boot/dts/sun9i-a80.dtsi
@@ -868,5 +868,19 @@
 			resets = <&apbs_rst 4>;
 			status = "disabled";
 		};
+
+		r_pio: pinctrl at 08002c00 {
+			compatible = "allwinner,sun9i-a80-r-pinctrl";
+			reg = <0x08002c00 0x400>;
+			interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 46 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&apbs_gates 0>;
+			resets = <&apbs_rst 0>;
+			gpio-controller;
+			interrupt-controller;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			#gpio-cells = <3>;
+		};
 	};
 };
-- 
2.6.2
