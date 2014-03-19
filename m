From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 19 Mar 2014 10:36:35 -0600
Subject: [PATCH] ARM: tegra: fix Dalmore pinctrl configuration
Message-ID: <1395246995-13972-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

Remove some entries from Dalmore's device tree that attempt to set some
options which aren't supported for the drive_gma pin group.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
This should be applied on top of wherever Tegra's for-3.15/dt branch
was merged into arm-soc.

 arch/arm/boot/dts/tegra114-dalmore.dts | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/boot/dts/tegra114-dalmore.dts b/arch/arm/boot/dts/tegra114-dalmore.dts
index 8de543777882..5eb11a3bba55 100644
--- a/arch/arm/boot/dts/tegra114-dalmore.dts
+++ b/arch/arm/boot/dts/tegra114-dalmore.dts
@@ -740,12 +740,10 @@
 				nvidia,pins = "drive_gma";
 				nvidia,high-speed-mode = <TEGRA_PIN_ENABLE>;
 				nvidia,schmitt = <TEGRA_PIN_DISABLE>;
-				nvidia,low-power-mode = <TEGRA_PIN_LP_DRIVE_DIV_1>;
 				nvidia,pull-down-strength = <2>;
 				nvidia,pull-up-strength = <1>;
 				nvidia,slew-rate-rising = <TEGRA_PIN_SLEW_RATE_FASTEST>;
 				nvidia,slew-rate-falling = <TEGRA_PIN_SLEW_RATE_FASTEST>;
-				nvidia,drive-type = <1>;
 			};
 		};
 	};
-- 
1.8.1.5
