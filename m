From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 12 Dec 2013 15:12:02 -0700
Subject: [PATCH V2] ARM: tegra: fix pinctrl misconfiguration on Venic2
Message-ID: <1386886322-2700-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

Other boards use PULL_NONE for their debug UART pins, and without this
change, the board doesn't accept any serial input.

Don't set the I2S port pins to tristate mode, or no audio signal will
be sent out.

Fixes: 605ae5804385 ("ARM: tegra: add default pinctrl nodes for Venice2")
Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
v2: Added fix for I2S port.

Laxman, can you please go through the whole pinctrl configuration for
Venice2 and make sure it's correct. Perhaps the best approach would be
to compare it against our downstream kernels for this board.
---
 arch/arm/boot/dts/tegra124-venice2.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/tegra124-venice2.dts b/arch/arm/boot/dts/tegra124-venice2.dts
index 616759c3c7e5..b31e18798be7 100644
--- a/arch/arm/boot/dts/tegra124-venice2.dts
+++ b/arch/arm/boot/dts/tegra124-venice2.dts
@@ -40,7 +40,7 @@
 				nvidia,function = "i2s1";
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
-				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 			};
 			dvfs_pwm_px0 {
 				nvidia,pins = "dvfs_pwm_px0";
@@ -250,7 +250,7 @@
 					      "pu3";
 				nvidia,function = "uarta";
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
-				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 			};
 			uart2_cts_n_pj5 {
-- 
1.8.1.5
