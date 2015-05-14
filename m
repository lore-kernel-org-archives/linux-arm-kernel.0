From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 14 May 2015 14:10:07 +0800
Subject: [RFC 3/7] ARM: dts: sun9i: Add CPUCFG device node for A80 dtsi
In-Reply-To: <1431583811-25780-1-git-send-email-wens@csie.org>
References: <1431583811-25780-1-git-send-email-wens@csie.org>
Message-ID: <1431583811-25780-4-git-send-email-wens@csie.org>
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
index 200e712fbf0e..c45735398f6a 100644
--- a/arch/arm/boot/dts/sun9i-a80.dtsi
+++ b/arch/arm/boot/dts/sun9i-a80.dtsi
@@ -458,6 +458,11 @@
 			#phy-cells = <0>;
 		};
 
+		cpucfg at 01700000 {
+			compatible = "allwinner,sun9i-a80-cpucfg";
+			reg = <0x01700000 0x100>;
+		};
+
 		mmc0: mmc at 01c0f000 {
 			compatible = "allwinner,sun5i-a13-mmc";
 			reg = <0x01c0f000 0x1000>;
-- 
2.1.4
