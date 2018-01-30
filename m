From: embed3d@gmail.com (Philipp Rossak)
Date: Tue, 30 Jan 2018 18:46:54 +0100
Subject: [PATCH v5 4/6] arm: dts: sun8i: a83t: Add support for the cir
 interface
In-Reply-To: <20180130174656.10657-1-embed3d@gmail.com>
References: <20180130174656.10657-1-embed3d@gmail.com>
Message-ID: <20180130174656.10657-5-embed3d@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The cir interface is like on the H3 located at 0x01f02000 and is exactly
the same. This patch adds support for the ir interface on the A83T.

Signed-off-by: Philipp Rossak <embed3d@gmail.com>
---
 arch/arm/boot/dts/sun8i-a83t.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a83t.dtsi b/arch/arm/boot/dts/sun8i-a83t.dtsi
index f7f78a27e21d..1e04a5cfd32d 100644
--- a/arch/arm/boot/dts/sun8i-a83t.dtsi
+++ b/arch/arm/boot/dts/sun8i-a83t.dtsi
@@ -704,6 +704,19 @@
 			#reset-cells = <1>;
 		};
 
+		r_cir: ir at 1f02000 {
+			compatible = "allwinner,sun8i-a83t-ir",
+				     "allwinner,sun5i-a13-ir";
+			clocks = <&r_ccu CLK_APB0_IR>, <&r_ccu CLK_IR>;
+			clock-names = "apb", "ir";
+			resets = <&r_ccu RST_APB0_IR>;
+			interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
+			reg = <0x01f02000 0x400>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&r_cir_pin>;
+			status = "disabled";
+		};
+
 		r_pio: pinctrl at 1f02c00 {
 			compatible = "allwinner,sun8i-a83t-r-pinctrl";
 			reg = <0x01f02c00 0x400>;
-- 
2.11.0
