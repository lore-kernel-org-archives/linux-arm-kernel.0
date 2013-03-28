From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 28 Mar 2013 13:22:30 -0600
Subject: [PATCH] ARM: tegra: keep power on to SD slot on Dalmore
Message-ID: <1364498550-15972-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

Set "regulator-always-on" for the SD slot on Dalmore, so that SD cards
work. This used to work, since this regulator is on by default, but was
broken by commit "ARM: tegra: dalmore: add TPS65090 node", since that
didn't specify always-on for this regulator.

In the long run, the regulators should all be hooked up to the SDHCI
device nodes. However, we haven't done that for any of the Tegra boards
yet, so to be consistent, this patch simply forces the regulator on,
rather than hooking it up and making it work differently to other boards.

Cc: Laxman Dewangan <ldewangan@nvidia.com>
Reported-by: Rhyland Klein <rklein@nvidia.com>
Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/boot/dts/tegra114-dalmore.dts |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/tegra114-dalmore.dts b/arch/arm/boot/dts/tegra114-dalmore.dts
index 2ef9f0e..0d8ceda 100644
--- a/arch/arm/boot/dts/tegra114-dalmore.dts
+++ b/arch/arm/boot/dts/tegra114-dalmore.dts
@@ -807,6 +807,7 @@
 
 				fet6 {
 					regulator-name = "vdd-sd-slot";
+					regulator-always-on;
 					regulator-boot-on;
 				};
 
-- 
1.7.10.4
