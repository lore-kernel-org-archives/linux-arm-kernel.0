From: wens@csie.org (Chen-Yu Tsai)
Date: Thu,  4 Jan 2018 22:37:49 +0800
Subject: [PATCH v2 3/8] ARM: dts: sun9i: Add CPUCFG device node for A80 dtsi
In-Reply-To: <20180104143754.2425-1-wens@csie.org>
References: <20180104143754.2425-1-wens@csie.org>
Message-ID: <20180104143754.2425-4-wens@csie.org>
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
index 85fb800af8ab..85ecb4d64cfd 100644
--- a/arch/arm/boot/dts/sun9i-a80.dtsi
+++ b/arch/arm/boot/dts/sun9i-a80.dtsi
@@ -363,6 +363,11 @@
 			#reset-cells = <1>;
 		};
 
+		cpucfg at 1700000 {
+			compatible = "allwinner,sun9i-a80-cpucfg";
+			reg = <0x01700000 0x100>;
+		};
+
 		mmc0: mmc at 1c0f000 {
 			compatible = "allwinner,sun9i-a80-mmc";
 			reg = <0x01c0f000 0x1000>;
-- 
2.15.1
