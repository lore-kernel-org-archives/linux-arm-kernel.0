From: soren.brinkmann@xilinx.com (Soren Brinkmann)
Date: Fri,  4 Apr 2014 16:14:12 -0700
Subject: [PATCH v2 1/5] ARM: zynq: DT: Add 'clock-latency' property
In-Reply-To: <1396653256-28397-1-git-send-email-soren.brinkmann@xilinx.com>
References: <1396653256-28397-1-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <1396653256-28397-2-git-send-email-soren.brinkmann@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Specify the 'clock-latency' property to avoid certain cpufreq governors
from refusing to work with the following error:
  ondemand governor failed, too long transition latency of HW, fallback to performance governor

Reported-by: Mike Looijmans <mike.looijmans@topic.nl>
Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
Tested-by: Mike Looijmans <mike.looijmans@topic.nl>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---
This is a fix from our vendor tree

Changes in v2:
 - This patch has been added

---
 arch/arm/boot/dts/zynq-7000.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/zynq-7000.dtsi b/arch/arm/boot/dts/zynq-7000.dtsi
index 789d0bacc110..20a13cba65a3 100644
--- a/arch/arm/boot/dts/zynq-7000.dtsi
+++ b/arch/arm/boot/dts/zynq-7000.dtsi
@@ -24,6 +24,7 @@
 			device_type = "cpu";
 			reg = <0>;
 			clocks = <&clkc 3>;
+			clock-latency = <1000>;
 			operating-points = <
 				/* kHz    uV */
 				666667  1000000
-- 
1.9.1.1.gbb9f595
