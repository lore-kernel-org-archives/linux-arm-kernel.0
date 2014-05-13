From: boris.brezillon@free-electrons.com (Boris BREZILLON)
Date: Tue, 13 May 2014 16:03:03 +0200
Subject: [PATCH v2] ARM: sunxi: dt: declare the r_pio pin controller for A31
 SoC
Message-ID: <1399989783-11271-1-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The A31 SoC has a different pin controller for PL and PM banks.
Define this new controller in the device tree.

Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>
---
Hello,

Sorry for the noise, I forgot I had to keep DT nodes in address order.

This patch depends on the PRCM series ([1]) which provides apb0 related
stuff (apb0 clks and apb0 gates).

Best Regards,

Boris

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2014-May/254664.html

Changes since v1:
- move r_pio node in order to keep DT nodes ordered

 arch/arm/boot/dts/sun6i-a31.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
index 81119a3..355ddb2 100644
--- a/arch/arm/boot/dts/sun6i-a31.dtsi
+++ b/arch/arm/boot/dts/sun6i-a31.dtsi
@@ -562,5 +562,19 @@
 			compatible = "allwinner,sun6i-a31-cpuconfig";
 			reg = <0x01f01c00 0x300>;
 		};
+
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
 	};
 };
-- 
1.8.3.2
