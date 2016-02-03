From: k@japko.eu (Krzysztof Adamski)
Date: Thu,  4 Feb 2016 00:33:49 +0100
Subject: [PATCH v3 4/5] ARM: dts: sun8i-h3: Add R_PIO controller node to the
 dtsi
In-Reply-To: <1454542430-16572-1-git-send-email-k@japko.eu>
References: <1454542430-16572-1-git-send-email-k@japko.eu>
Message-ID: <1454542430-16572-5-git-send-email-k@japko.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the corresponding device node for R_PIO on H3 to the dtsi. Support
for the controller was added in earlier commit.

Signed-off-by: Krzysztof Adamski <k@japko.eu>
---
 arch/arm/boot/dts/sun8i-h3.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi b/arch/arm/boot/dts/sun8i-h3.dtsi
index bb37f52..f618a95 100644
--- a/arch/arm/boot/dts/sun8i-h3.dtsi
+++ b/arch/arm/boot/dts/sun8i-h3.dtsi
@@ -517,5 +517,17 @@
 			compatible = "allwinner,sun6i-a31-clock-reset";
 			#reset-cells = <1>;
 		};
+
+		r_pio: pinctrl at 01f02c00 {
+			compatible = "allwinner,sun8i-h3-r-pinctrl";
+			reg = <0x01f02c00 0x400>;
+			interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&apb0_gates 0>;
+			resets = <&apb0_reset 0>;
+			gpio-controller;
+			#gpio-cells = <3>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
 	};
 };
-- 
2.1.4
