From: dinguyen@opensource.altera.com (dinguyen at opensource.altera.com)
Date: Thu, 16 Jul 2015 16:14:28 -0500
Subject: [PATCH] ARM: dts: socfpga: enable the data and instruction prefetch
 for the l2 cache
Message-ID: <1437081268-19225-1-git-send-email-dinguyen@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dinh Nguyen <dinguyen@opensource.altera.com>

Just in case the firmware did not enable data and instruction prefetch in
the L2 cache controller, we enable it in the kernel.

Signed-off-by: Dinh Nguyen <dinguyen@opensource.altera.com>
---
 arch/arm/boot/dts/socfpga.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
index 80f924d..1e3c833 100644
--- a/arch/arm/boot/dts/socfpga.dtsi
+++ b/arch/arm/boot/dts/socfpga.dtsi
@@ -639,6 +639,8 @@
 			cache-level = <2>;
 			arm,tag-latency = <1 1 1>;
 			arm,data-latency = <2 1 1>;
+			prefetch-data = <1>;
+			prefetch-instr = <1>;
 		};
 
 		mmc: dwmmc0 at ff704000 {
-- 
2.4.5
