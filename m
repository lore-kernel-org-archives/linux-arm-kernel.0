From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 15 Nov 2013 13:54:23 -0700
Subject: [PATCH 28/31] ARM: tegra: remove legacy clock entries from DT
In-Reply-To: <1384548866-13141-1-git-send-email-swarren@wwwdotorg.org>
References: <1384548866-13141-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1384548866-13141-29-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

Now that all Tegra drivers have been converted to use the common reset
framework, we can remove all the legacy DT clocks/clock-names entries for
"clocks" that were only used with the old custom Tegra module reset API.

Cc: treding at nvidia.com
Cc: pdeschrijver at nvidia.com
Cc: linux-tegra at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
Cc: devicetree at vger.kernel.org
Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/boot/dts/tegra20.dtsi |  3 +--
 arch/arm/boot/dts/tegra30.dtsi | 18 +++---------------
 2 files changed, 4 insertions(+), 17 deletions(-)

diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsi
index c53e02e08310..61d2f3868f4f 100644
--- a/arch/arm/boot/dts/tegra20.dtsi
+++ b/arch/arm/boot/dts/tegra20.dtsi
@@ -576,9 +576,8 @@
 
 		clocks = <&tegra_car TEGRA20_CLK_PEX>,
 			 <&tegra_car TEGRA20_CLK_AFI>,
-			 <&tegra_car TEGRA20_CLK_PCIE_XCLK>,
 			 <&tegra_car TEGRA20_CLK_PLL_E>;
-		clock-names = "pex", "afi", "pcie_xclk", "pll_e";
+		clock-names = "pex", "afi", "pll_e";
 		resets = <&tegra_car 70>,
 		         <&tegra_car 72>,
 		         <&tegra_car 74>;
diff --git a/arch/arm/boot/dts/tegra30.dtsi b/arch/arm/boot/dts/tegra30.dtsi
index 0e69dd9f33e6..348b0f07f675 100644
--- a/arch/arm/boot/dts/tegra30.dtsi
+++ b/arch/arm/boot/dts/tegra30.dtsi
@@ -40,10 +40,9 @@
 
 		clocks = <&tegra_car TEGRA30_CLK_PCIE>,
 			 <&tegra_car TEGRA30_CLK_AFI>,
-			 <&tegra_car TEGRA30_CLK_PCIEX>,
 			 <&tegra_car TEGRA30_CLK_PLL_E>,
 			 <&tegra_car TEGRA30_CLK_CML0>;
-		clock-names = "pex", "afi", "pcie_xclk", "pll_e", "cml";
+		clock-names = "pex", "afi", "pll_e", "cml";
 		resets = <&tegra_car 70>,
 		         <&tegra_car 72>,
 		         <&tegra_car 74>;
@@ -641,19 +640,8 @@
 		interrupts = <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>;
 		nvidia,dma-request-selector = <&apbdma 1>;
 		clocks = <&tegra_car TEGRA30_CLK_D_AUDIO>,
-			 <&tegra_car TEGRA30_CLK_APBIF>,
-			 <&tegra_car TEGRA30_CLK_I2S0>,
-			 <&tegra_car TEGRA30_CLK_I2S1>,
-			 <&tegra_car TEGRA30_CLK_I2S2>,
-			 <&tegra_car TEGRA30_CLK_I2S3>,
-			 <&tegra_car TEGRA30_CLK_I2S4>,
-			 <&tegra_car TEGRA30_CLK_DAM0>,
-			 <&tegra_car TEGRA30_CLK_DAM1>,
-			 <&tegra_car TEGRA30_CLK_DAM2>,
-			 <&tegra_car TEGRA30_CLK_SPDIF_IN>;
-		clock-names = "d_audio", "apbif", "i2s0", "i2s1", "i2s2",
-			      "i2s3", "i2s4", "dam0", "dam1", "dam2",
-			      "spdif_in";
+			 <&tegra_car TEGRA30_CLK_APBIF>;
+		clock-names = "d_audio", "apbif";
 		resets = <&tegra_car 106>, /* d_audio */
 			 <&tegra_car 107>, /* apbif */
 			 <&tegra_car 30>,  /* i2s0 */
-- 
1.8.1.5
