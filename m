From: michal.simek@xilinx.com (Michal Simek)
Date: Thu, 28 Mar 2013 17:38:09 +0100
Subject: [PATCH v3 09/12] arm: zynq: Add smp_twd timer
In-Reply-To: <1364488692-18709-1-git-send-email-michal.simek@xilinx.com>
References: <1364488692-18709-1-git-send-email-michal.simek@xilinx.com>
Message-ID: <4a98ba06bb10c524b9ab951608eb955360229995.1364488495.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The zynq has a Cortex-A9 with the corresponding smp_twd timers. Use them.

Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---
v3: New patch for this series to avoid bug in hotplug
Warning log:
zynq> echo 1 > /sys/devices/system/cpu/cpu1/online
CPU1: Booted secondary processor
Clockevents: could not switch to one-shot mode: dummy_timer is not functional.
Could not switch to high resolution mode on CPU 1
---
 arch/arm/boot/dts/zynq-7000.dtsi |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/zynq-7000.dtsi b/arch/arm/boot/dts/zynq-7000.dtsi
index 748fc34..14fb2e6 100644
--- a/arch/arm/boot/dts/zynq-7000.dtsi
+++ b/arch/arm/boot/dts/zynq-7000.dtsi
@@ -136,5 +136,12 @@
 			clock-names = "cpu_1x";
 			clock-ranges;
 		};
+		scutimer: scutimer at f8f00600 {
+			interrupt-parent = <&intc>;
+			interrupts = < 1 13 0x301 >;
+			compatible = "arm,cortex-a9-twd-timer";
+			reg = < 0xf8f00600 0x20 >;
+			clocks = <&cpu_clk 1>;
+		} ;
 	};
 };
-- 
1.7.9.7
