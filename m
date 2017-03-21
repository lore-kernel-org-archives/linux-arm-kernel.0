From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 21 Mar 2017 16:42:45 +0800
Subject: [PATCH] arm64: dts: zte: remove zx296718 pll_vga clock
Message-ID: <1490085765-16428-1-git-send-email-shawnguo@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shawn Guo <shawn.guo@linaro.org>

Rather than a fixed rate clock, pll_vga is a PLL can be programmed into
different freqencies.  Let's drop it from device tree and get it
registered from clock driver.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm64/boot/dts/zte/zx296718.dtsi | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/arm64/boot/dts/zte/zx296718.dtsi b/arch/arm64/boot/dts/zte/zx296718.dtsi
index 0c24f73e6c54..8c20d295fa86 100644
--- a/arch/arm64/boot/dts/zte/zx296718.dtsi
+++ b/arch/arm64/boot/dts/zte/zx296718.dtsi
@@ -235,13 +235,6 @@
 		clock-output-names = "pll_mac";
 	};
 
-	pll_vga: clk-pll-1073m {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		clock-frequency = <1073000000>;
-		clock-output-names = "pll_vga";
-	};
-
 	pll_mm0: clk-pll-1188m {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
-- 
1.9.1
