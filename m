From: boris.brezillon@free-electrons.com (Boris BREZILLON)
Date: Tue, 13 May 2014 15:50:34 +0200
Subject: [PATCH] ARM: sunxi: dt: declare the r_pio pin controller for A31 SoC
Message-ID: <1399989034-11010-1-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The A31 SoC has a different pin controller for PL and PM banks.
Define this new controller in the device tree.

Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>
---
Hello,

This patch depends on the PRCM series ([1]) which provides apb0 related
stuff (apb0 clks and apb0 gates).

Best Regards,

Boris

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2014-May/254664.html

 arch/arm/boot/dts/sun6i-a31.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
index 81119a3..c46e3d7 100644
--- a/arch/arm/boot/dts/sun6i-a31.dtsi
+++ b/arch/arm/boot/dts/sun6i-a31.dtsi
@@ -297,6 +297,20 @@
 			};
 		};
 
+		r_pio: pinctrl at 01f02c00 {
+			compatible = "allwinner,sun6i-a31-r-pinctrl";
+			reg = <0x01f02c00 0x400>;
+			interrupts = <0 45 4>,
+				     <0 46 4>;
+			clocks = <&apb0_gates 0>;
+			resets = <&apb0_rst 0>;
+			gpio-controller;
+			interrupt-controller;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			#gpio-cells = <3>;
+		};
+
 		ahb1_rst: reset at 01c202c0 {
 			#reset-cells = <1>;
 			compatible = "allwinner,sun6i-a31-ahb1-reset";
-- 
1.8.3.2
