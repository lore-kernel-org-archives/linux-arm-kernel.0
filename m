From: shawn.guo@linaro.org (Shawn Guo)
Date: Sat, 16 Nov 2013 23:14:07 +0800
Subject: [PATCH] ARM: dts: imx6qdl: disable spdif "rxtx5" clock option
Message-ID: <1384614847-22905-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The spdif "rxtx5" clock option is being set to ipg clk (62) by mistake.
This causes an incorrect time keeping when spdif driver is running,
because ipg is ancestor clock for clocksource while spdif driver will
change the rate of this clock in certain circumstance.  Before the
correct clock for "rxtx5" option can be supplied, let's disable this
option for now by filling a dummy clock for it.

Reported-by: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/boot/dts/imx6qdl.dtsi |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index dcab03b..056b46b 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -161,7 +161,7 @@
 					clocks = <&clks 197>, <&clks 3>,
 						 <&clks 197>, <&clks 107>,
 						 <&clks 0>,   <&clks 118>,
-						 <&clks 62>,  <&clks 139>,
+						 <&clks 0>,  <&clks 139>,
 						 <&clks 0>;
 					clock-names = "core",  "rxtx0",
 						      "rxtx1", "rxtx2",
-- 
1.7.9.5
