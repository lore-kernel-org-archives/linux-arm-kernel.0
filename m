From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 20 Sep 2012 15:20:39 -0600
Subject: [PATCH] ARM: tegra: harmony: fix ldo7 regulator-name
Message-ID: <1348176039-6094-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

On Harmony, LDO7 does not feed vdd_fuse. Correct the regulator name.
This issue was probably the result of copying Ventana's regulator setup
when creating the Harmony .dts file. No other naming issues appear to
exist.

Reported-by: Thierry Reding <thierry.reding@avionic-design.de>
Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
Arnd, Olof, any chance you could roll this into arm-soc directly rather than
my sending another pull request? Or, I can re-do my today's dt2 pull request
with this added if it makes it easier. Thanks.

I don't expect any more patches to show up for Tegra for 3.7, unless they're
bug-fixes for issues I haven't noticed yet.

 arch/arm/boot/dts/tegra20-harmony.dts |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/boot/dts/tegra20-harmony.dts b/arch/arm/boot/dts/tegra20-harmony.dts
index b98a1b3..c3ef1ad 100644
--- a/arch/arm/boot/dts/tegra20-harmony.dts
+++ b/arch/arm/boot/dts/tegra20-harmony.dts
@@ -397,7 +397,7 @@
 				regulator at 11 {
 					reg = <11>;
 					regulator-compatible = "ldo7";
-					regulator-name = "vdd_ldo7,avdd_hdmi,vdd_fuse";
+					regulator-name = "vdd_ldo7,avdd_hdmi";
 					regulator-min-microvolt = <3300000>;
 					regulator-max-microvolt = <3300000>;
 				};
-- 
1.7.0.4
