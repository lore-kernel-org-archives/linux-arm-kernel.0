From: embed3d@gmail.com (Philipp Rossak)
Date: Sat, 16 Dec 2017 03:49:13 +0100
Subject: [RFC 4/5] ARM: dts: sun8i: a83t: Add support for the ir interface
In-Reply-To: <20171216024914.7550-1-embed3d@gmail.com>
References: <20171216024914.7550-1-embed3d@gmail.com>
Message-ID: <20171216024914.7550-5-embed3d@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ir interface is like the H3 at 0x01f02000 located and is exactly
the same. This patch adds support for the ir interface on the A83T.

Signed-off-by: Philipp Rossak <embed3d@gmail.com>
---
 arch/arm/boot/dts/sun8i-a83t.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a83t.dtsi b/arch/arm/boot/dts/sun8i-a83t.dtsi
index 5edb645b506f..5dbf2f0891c1 100644
--- a/arch/arm/boot/dts/sun8i-a83t.dtsi
+++ b/arch/arm/boot/dts/sun8i-a83t.dtsi
@@ -470,6 +470,16 @@
 			#reset-cells = <1>;
 		};
 
+		ir: ir at 01f02000 {
+			compatible = "allwinner,sun5i-a13-ir";
+			clocks = <&r_ccu CLK_APB0_IR>, <&r_ccu CLK_IR>;
+			clock-names = "apb", "ir";
+			resets = <&r_ccu RST_APB0_IR>;
+			interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
+			reg = <0x01f02000 0x40>;
+			status = "disabled";
+		};
+
 		r_pio: pinctrl at 1f02c00 {
 			compatible = "allwinner,sun8i-a83t-r-pinctrl";
 			reg = <0x01f02c00 0x400>;
-- 
2.11.0
