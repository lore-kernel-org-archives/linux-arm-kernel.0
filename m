From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 14 Dec 2017 16:00:06 +0100
Subject: [PATCH v4 4/4] arm64: dts: marvell: armada-37xx: add nodes allowing
 cpufreq support
In-Reply-To: <20171214150006.25438-1-gregory.clement@free-electrons.com>
References: <20171214150006.25438-1-gregory.clement@free-electrons.com>
Message-ID: <20171214150006.25438-5-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to be able to use cpu freq, we need to associate a clock to each
CPU and to expose the power management registers.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm64/boot/dts/marvell/armada-372x.dtsi | 1 +
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-372x.dtsi b/arch/arm64/boot/dts/marvell/armada-372x.dtsi
index 59d7557d3b1b..2554e0baea6b 100644
--- a/arch/arm64/boot/dts/marvell/armada-372x.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-372x.dtsi
@@ -56,6 +56,7 @@
 			device_type = "cpu";
 			compatible = "arm,cortex-a53","arm,armv8";
 			reg = <0x1>;
+			clocks = <&nb_periph_clk 16>;
 			enable-method = "psci";
 		};
 	};
diff --git a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
index 90c26d616a54..3056d7168e0b 100644
--- a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
@@ -65,6 +65,7 @@
 			device_type = "cpu";
 			compatible = "arm,cortex-a53", "arm,armv8";
 			reg = <0>;
+			clocks = <&nb_periph_clk 16>;
 			enable-method = "psci";
 		};
 	};
@@ -234,6 +235,12 @@
 				};
 			};
 
+			nb_pm: syscon at 14000 {
+				compatible = "marvell,armada-3700-nb-pm",
+					     "syscon";
+				reg = <0x14000 0x60>;
+			};
+
 			pinctrl_sb: pinctrl at 18800 {
 				compatible = "marvell,armada3710-sb-pinctrl",
 					     "syscon", "simple-mfd";
-- 
2.15.1
