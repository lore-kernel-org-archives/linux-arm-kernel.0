From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue,  1 Apr 2014 14:13:15 -0600
Subject: [PATCH 1/3] ARM: tegra: remove UART5/UARTE from tegra124.dtsi
Message-ID: <1396383197-5979-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

Tegra124 only has 4 UARTs. Parts of the documentation hint at a fifth
UART, but this appears to be left-over from earlier SoC documentation.
Remove the non-existent DT node for UART5.

Cc: <stable@vger.kernel.org>
Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/boot/dts/tegra124.dtsi | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/arch/arm/boot/dts/tegra124.dtsi b/arch/arm/boot/dts/tegra124.dtsi
index cf45a1a39483..6d540a025148 100644
--- a/arch/arm/boot/dts/tegra124.dtsi
+++ b/arch/arm/boot/dts/tegra124.dtsi
@@ -233,19 +233,6 @@
 		status = "disabled";
 	};
 
-	serial at 0,70006400 {
-		compatible = "nvidia,tegra124-uart", "nvidia,tegra20-uart";
-		reg = <0x0 0x70006400 0x0 0x40>;
-		reg-shift = <2>;
-		interrupts = <GIC_SPI 91 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&tegra_car TEGRA124_CLK_UARTE>;
-		resets = <&tegra_car 66>;
-		reset-names = "serial";
-		dmas = <&apbdma 20>, <&apbdma 20>;
-		dma-names = "rx", "tx";
-		status = "disabled";
-	};
-
 	pwm at 0,7000a000 {
 		compatible = "nvidia,tegra124-pwm", "nvidia,tegra20-pwm";
 		reg = <0x0 0x7000a000 0x0 0x100>;
-- 
1.8.1.5
