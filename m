From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 13 Sep 2013 22:09:52 +0200
Subject: [PATCH] ARM: Kirkwood: Add missing DT reg property to cpu@0
Message-ID: <1379102992-23662-1-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The kirkwood.dtsi cpu at 0 node is missing the mandatory reg property.
This causes of_get_cpu_node() to fail to find the node and as a result
the cpufreq driver fails in its probe function.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---

Hi Jason

With the patch "cpufreq: kirkwood-cpufreq: remove device tree parsing
for cpu nodes", e768f350c8c3d4253011282db771f35af37ee59a, we need this
fix, or cpufreq will not work. Please queue this up for -rc2.

 arch/arm/boot/dts/kirkwood.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/kirkwood.dtsi b/arch/arm/boot/dts/kirkwood.dtsi
index 9809fc1..dc65c5a 100644
--- a/arch/arm/boot/dts/kirkwood.dtsi
+++ b/arch/arm/boot/dts/kirkwood.dtsi
@@ -11,6 +11,7 @@
 		cpu at 0 {
 			device_type = "cpu";
 			compatible = "marvell,feroceon";
+			reg = <0>;
 			clocks = <&core_clk 1>, <&core_clk 3>, <&gate_clk 11>;
 			clock-names = "cpu_clk", "ddrclk", "powersave";
 		};
-- 
1.8.4.rc3
