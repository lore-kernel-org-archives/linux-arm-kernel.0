From: vishnupatekar0510@gmail.com (Vishnu Patekar)
Date: Sat,  5 Mar 2016 23:43:01 +0800
Subject: [PATCH v3 08/13] ARM: dts: sun8i-a83t: Add R_PIO controller node to
 the dtsi
In-Reply-To: <1457192586-25596-1-git-send-email-vishnupatekar0510@gmail.com>
References: <1457192586-25596-1-git-send-email-vishnupatekar0510@gmail.com>
Message-ID: <1457192586-25596-9-git-send-email-vishnupatekar0510@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we have a driver for the R_PIO controller,
add the corresponding device node to the dtsi.

Signed-off-by: Vishnu Patekar <vishnupatekar0510@gmail.com>
---
 arch/arm/boot/dts/sun8i-a83t.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a83t.dtsi b/arch/arm/boot/dts/sun8i-a83t.dtsi
index 691bbf1..5d240b9 100644
--- a/arch/arm/boot/dts/sun8i-a83t.dtsi
+++ b/arch/arm/boot/dts/sun8i-a83t.dtsi
@@ -465,5 +465,17 @@
 			compatible = "allwinner,sun6i-a31-clock-reset";
 			#reset-cells = <1>;
 		};
+
+		r_pio: pinctrl at 01f02c00 {
+			compatible = "allwinner,sun8i-a83t-r-pinctrl";
+			reg = <0x01f02c00 0x400>;
+			interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&apb0_gates 0>;
+			resets = <&apb0_reset 0>;
+			gpio-controller;
+			interrupt-controller;
+			#interrupt-cells = <3>;
+			#gpio-cells = <3>;
+		};
 	};
 };
-- 
1.9.1
