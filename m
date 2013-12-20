From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 20 Dec 2013 22:41:09 +0100
Subject: [PATCH 3/3] ARM: sun6i: a31: Add support for the High Speed Timers
In-Reply-To: <1387575669-21253-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1387575669-21253-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1387575669-21253-4-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Allwinner A31 has support for four high speed timers. Apart for the
number of timers (4 vs 2), it's basically the same logic than the high
speed timers found in the sun5i chips.

Now that we have a driver to support it, we can enable them in the
device tree.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun6i-a31.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
index 5256ad9..9145c6d 100644
--- a/arch/arm/boot/dts/sun6i-a31.dtsi
+++ b/arch/arm/boot/dts/sun6i-a31.dtsi
@@ -312,6 +312,17 @@
 			status = "disabled";
 		};
 
+		hstimer at 01c60000 {
+			compatible = "allwinner,sun7i-a20-hstimer";
+			reg = <0x01c60000 0x1000>;
+			interrupts = <0 51 4>,
+				     <0 52 4>,
+				     <0 53 4>,
+				     <0 54 4>;
+			clocks = <&ahb1_gates 19>;
+			resets = <&ahb1_rst 19>;
+		};
+
 		gic: interrupt-controller at 01c81000 {
 			compatible = "arm,cortex-a7-gic", "arm,cortex-a15-gic";
 			reg = <0x01c81000 0x1000>,
-- 
1.8.4.2
