From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 15 Apr 2014 16:29:44 -0600
Subject: [PATCH] ARM: tegra: make Venice's +3.3V_RUN regulator always on
Message-ID: <1397600984-25198-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

This regulator supplies power to pretty much everything on the board, so
it doesn't make sense to allow it to turn off. Mark it boot-on and
always-on so it doesn't get turned off. Without this, I see issues with
the eMMC device; it can't be correctly detected during boot.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/boot/dts/tegra124-venice2.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/tegra124-venice2.dts b/arch/arm/boot/dts/tegra124-venice2.dts
index c17283c04598..87537f499875 100644
--- a/arch/arm/boot/dts/tegra124-venice2.dts
+++ b/arch/arm/boot/dts/tegra124-venice2.dts
@@ -1060,6 +1060,8 @@
 			regulator-name = "+3.3V_RUN";
 			regulator-min-microvolt = <3300000>;
 			regulator-max-microvolt = <3300000>;
+			regulator-always-on;
+			regulator-boot-on;
 			gpio = <&pmic 1 GPIO_ACTIVE_HIGH>;
 			enable-active-high;
 			vin-supply = <&vdd_3v3_sys>;
-- 
1.8.1.5
