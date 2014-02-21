From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 21 Feb 2014 23:16:34 +0100
Subject: [PATCH v2 2/2] ARM: sun6i: a31: Add support for the High Speed Timers
In-Reply-To: <1393020994-4244-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1393020994-4244-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1393020994-4244-3-git-send-email-maxime.ripard@free-electrons.com>
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
index af6f87c..0bfcfc1 100644
--- a/arch/arm/boot/dts/sun6i-a31.dtsi
+++ b/arch/arm/boot/dts/sun6i-a31.dtsi
@@ -359,6 +359,17 @@
 			status = "disabled";
 		};
 
+		timer at 01c60000 {
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
 		spi0: spi at 01c68000 {
 			compatible = "allwinner,sun6i-a31-spi";
 			reg = <0x01c68000 0x1000>;
-- 
1.9.0
