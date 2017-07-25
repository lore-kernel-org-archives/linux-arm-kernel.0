From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 25 Jul 2017 13:09:18 +0800
Subject: [PATCH 3/4] ARM: dts: sun9i: Add CPUCFG device node for A80 dtsi
In-Reply-To: <20170725050919.16036-1-wens@csie.org>
References: <20170725050919.16036-1-wens@csie.org>
Message-ID: <20170725050919.16036-4-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CPUCFG is a collection of registers that are mapped to the SoC's signals
from each individual processor core and associated peripherals, such as
resets for processors, L1/L2 cache and other things.

These registers are used for SMP bringup and CPU hotplugging.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun9i-a80.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/sun9i-a80.dtsi b/arch/arm/boot/dts/sun9i-a80.dtsi
index fc179b8ab038..cc5db467f616 100644
--- a/arch/arm/boot/dts/sun9i-a80.dtsi
+++ b/arch/arm/boot/dts/sun9i-a80.dtsi
@@ -368,6 +368,11 @@
 			#reset-cells = <1>;
 		};
 
+		cpucfg at 01700000 {
+			compatible = "allwinner,sun9i-a80-cpucfg";
+			reg = <0x01700000 0x100>;
+		};
+
 		mmc0: mmc at 01c0f000 {
 			compatible = "allwinner,sun9i-a80-mmc";
 			reg = <0x01c0f000 0x1000>;
-- 
2.13.3
