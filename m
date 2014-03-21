From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 20 Mar 2014 18:06:01 -0600
Subject: [PATCH] ARM: tegra: fix board DT pinmux setup
Message-ID: <1395360361-17130-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

Neither Tegra114 nor Tegra124 allow "low power mode" to be configured
on SDIO1 or SDIO3 drive groups. Remove the attempt to configure that
option from the Dalmore and Venice2 DTs.

The Venice2 DT contained duplicate configurations for most sdmmc1_*
pins. Remove the duplicate pins from one of the nodes, and fix the
configuration since the remaining clk pin is output-only.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
This is another fix for 3.15.

 arch/arm/boot/dts/tegra114-dalmore.dts |  2 --
 arch/arm/boot/dts/tegra124-venice2.dts | 11 ++---------
 2 files changed, 2 insertions(+), 11 deletions(-)

diff --git a/arch/arm/boot/dts/tegra114-dalmore.dts b/arch/arm/boot/dts/tegra114-dalmore.dts
index 5eb11a3bba55..a288a12823ed 100644
--- a/arch/arm/boot/dts/tegra114-dalmore.dts
+++ b/arch/arm/boot/dts/tegra114-dalmore.dts
@@ -720,7 +720,6 @@
 				nvidia,pins = "drive_sdio1";
 				nvidia,high-speed-mode = <TEGRA_PIN_ENABLE>;
 				nvidia,schmitt = <TEGRA_PIN_DISABLE>;
-				nvidia,low-power-mode = <TEGRA_PIN_LP_DRIVE_DIV_1>;
 				nvidia,pull-down-strength = <36>;
 				nvidia,pull-up-strength = <20>;
 				nvidia,slew-rate-rising = <TEGRA_PIN_SLEW_RATE_SLOW>;
@@ -730,7 +729,6 @@
 				nvidia,pins = "drive_sdio3";
 				nvidia,high-speed-mode = <TEGRA_PIN_ENABLE>;
 				nvidia,schmitt = <TEGRA_PIN_DISABLE>;
-				nvidia,low-power-mode = <TEGRA_PIN_LP_DRIVE_DIV_1>;
 				nvidia,pull-down-strength = <22>;
 				nvidia,pull-up-strength = <36>;
 				nvidia,slew-rate-rising = <TEGRA_PIN_SLEW_RATE_FASTEST>;
diff --git a/arch/arm/boot/dts/tegra124-venice2.dts b/arch/arm/boot/dts/tegra124-venice2.dts
index 86536d919ed2..c17283c04598 100644
--- a/arch/arm/boot/dts/tegra124-venice2.dts
+++ b/arch/arm/boot/dts/tegra124-venice2.dts
@@ -152,14 +152,9 @@
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 			};
 			sdmmc1_clk_pz0 {
-				nvidia,pins = "sdmmc1_clk_pz0",
-					      "sdmmc1_cmd_pz1",
-					      "sdmmc1_dat0_py7",
-					      "sdmmc1_dat1_py6",
-					      "sdmmc1_dat2_py5",
-					      "sdmmc1_dat3_py4";
+				nvidia,pins = "sdmmc1_clk_pz0";
 				nvidia,function = "sdmmc1";
-				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 			};
@@ -429,7 +424,6 @@
 				nvidia,pins = "drive_sdio1";
 				nvidia,high-speed-mode = <TEGRA_PIN_ENABLE>;
 				nvidia,schmitt = <TEGRA_PIN_DISABLE>;
-				nvidia,low-power-mode = <TEGRA_PIN_LP_DRIVE_DIV_1>;
 				nvidia,pull-down-strength = <32>;
 				nvidia,pull-up-strength = <42>;
 				nvidia,slew-rate-rising = <TEGRA_PIN_SLEW_RATE_FASTEST>;
@@ -439,7 +433,6 @@
 				nvidia,pins = "drive_sdio3";
 				nvidia,high-speed-mode = <TEGRA_PIN_ENABLE>;
 				nvidia,schmitt = <TEGRA_PIN_DISABLE>;
-				nvidia,low-power-mode = <TEGRA_PIN_LP_DRIVE_DIV_1>;
 				nvidia,pull-down-strength = <20>;
 				nvidia,pull-up-strength = <36>;
 				nvidia,slew-rate-rising = <TEGRA_PIN_SLEW_RATE_FASTEST>;
-- 
1.8.1.5
