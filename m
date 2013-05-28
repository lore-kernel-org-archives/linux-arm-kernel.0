From: padma.v@samsung.com (Padmavathi Venna)
Date: Tue, 28 May 2013 15:32:58 +0530
Subject: [PATCH V3 4/4] ARM: dts: add clock provider information for i2s
 controllers in Exynos5250
In-Reply-To: <1369735378-10003-1-git-send-email-padma.v@samsung.com>
References: <1369735378-10003-1-git-send-email-padma.v@samsung.com>
Message-ID: <1369735378-10003-5-git-send-email-padma.v@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add clock lookup information for i2s controllers on exynos5250 SoC.

Signed-off-by: Padmavathi Venna <padma.v@samsung.com>
---
 arch/arm/boot/dts/exynos5250.dtsi |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
index 388983e..7154e3d 100644
--- a/arch/arm/boot/dts/exynos5250.dtsi
+++ b/arch/arm/boot/dts/exynos5250.dtsi
@@ -20,6 +20,8 @@
 #include "skeleton.dtsi"
 #include "exynos5250-pinctrl.dtsi"
 
+#include <dt-bindings/clk/samsung-audss-clk.h>
+
 / {
 	compatible = "samsung,exynos5250";
 	interrupt-parent = <&gic>;
@@ -457,6 +459,13 @@
 			&pdma0 9
 			&pdma0 8>;
 		dma-names = "tx", "rx", "tx-sec";
+		clocks = <&clock_audss SAMSUNG_I2S_BUS>,
+			<&clock_audss SAMSUNG_I2S_BUS>,
+			<&clock_audss SAMSUNG_SCLK_I2S>,
+			<&clock_audss SAMSUNG_MOUT_AUDSS>,
+			<&clock_audss SAMSUNG_MOUT_I2S>;
+		clock-names = "iis", "i2s_opclk0", "i2s_opclk1",
+				"mout_audss", "mout_i2s";
 		samsung,supports-6ch;
 		samsung,supports-rstclr;
 		samsung,supports-secdai;
@@ -471,6 +480,8 @@
 		dmas = <&pdma1 12
 			&pdma1 11>;
 		dma-names = "tx", "rx";
+		clocks = <&clock 307>;
+		clock-names = "iis";
 		pinctrl-names = "default";
 		pinctrl-0 = <&i2s1_bus>;
 	};
@@ -481,6 +492,8 @@
 		dmas = <&pdma0 12
 			&pdma0 11>;
 		dma-names = "tx", "rx";
+		clocks = <&clock 308>;
+		clock-names = "iis";
 		pinctrl-names = "default";
 		pinctrl-0 = <&i2s2_bus>;
 	};
-- 
1.7.4.4
