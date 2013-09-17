From: dinguyen@altera.com (dinguyen at altera.com)
Date: Tue, 17 Sep 2013 11:32:20 -0500
Subject: [PATCH 1/2] arm: socfpga: Add clock for smp_twd timer
Message-ID: <1379435541-26338-1-git-send-email-dinguyen@altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dinh Nguyen <dinguyen@altera.com>

Assign a clock for the twd-timer.

Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>
Cc: Ian Campbell <ian.campbell@citrix.com>
CC: linux-arm-kernel at lists.infradead.org
---
 arch/arm/boot/dts/socfpga.dtsi |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
index acd6c3a..e28df94 100644
--- a/arch/arm/boot/dts/socfpga.dtsi
+++ b/arch/arm/boot/dts/socfpga.dtsi
@@ -480,11 +480,11 @@
 			clock-names = "biu", "ciu";
 		};
 
-		/* Local timer */
-		timer at fffec600 {
+		local-timer at fffec600 {
 			compatible = "arm,cortex-a9-twd-timer";
 			reg = <0xfffec600 0x100>;
 			interrupts = <1 13 0xf04>;
+			clocks = <&mpu_periph_clk>;
 		};
 
 		timer0: timer0 at ffc08000 {
-- 
1.7.9.5
