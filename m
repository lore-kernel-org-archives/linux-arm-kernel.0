From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 17 Apr 2014 11:06:46 +0200
Subject: [PATCH v3 2/2] ARM: sun6i: a31: Add support for the High Speed Timers
In-Reply-To: <1397725606-18000-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1397725606-18000-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1397725606-18000-3-git-send-email-maxime.ripard@free-electrons.com>
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
index bc46814d2ff0..2af6ca205cc2 100644
--- a/arch/arm/boot/dts/sun6i-a31.dtsi
+++ b/arch/arm/boot/dts/sun6i-a31.dtsi
@@ -428,6 +428,17 @@
 			status = "disabled";
 		};
 
+		timer at 01c60000 {
+			compatible = "allwinner,sun6i-a31-hstimer", "allwinner,sun7i-a20-hstimer";
+			reg = <0x01c60000 0x1000>;
+			interrupts = <0 51 4>,
+				     <0 52 4>,
+				     <0 53 4>,
+				     <0 54 4>;
+			clocks = <&ahb1_gates 19>;
+			resets = <&ahb1_rst 19>;
+		};
+
 		spi0: spi at 01c68000 {
 			compatible = "allwinner,sun6i-a31-spi";
 			reg = <0x01c68000 0x1000>;
-- 
1.9.1
