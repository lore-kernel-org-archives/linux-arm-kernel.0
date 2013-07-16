From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 16 Jul 2013 16:36:21 -0600
Subject: [PATCH 2/2] ARM: tegra: don't select all pinctrl drivers
In-Reply-To: <1374014181-22605-1-git-send-email-swarren@wwwdotorg.org>
References: <1374014181-22605-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1374014181-22605-2-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

The Tegra pinctrl drivers now have their own user-visible config options.
Don't select all of these when ARCH_TEGRA is enabled; that prevents the
user from selectively disabling pinctrl drivers for SoCs that they don't
care about.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/mach-tegra/Kconfig | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm/mach-tegra/Kconfig b/arch/arm/mach-tegra/Kconfig
index b1fabe6..6715621 100644
--- a/arch/arm/mach-tegra/Kconfig
+++ b/arch/arm/mach-tegra/Kconfig
@@ -23,9 +23,6 @@ config ARCH_TEGRA
 	select HAVE_SMP
 	select MIGHT_HAVE_CACHE_L2X0
 	select PINCTRL
-	select PINCTRL_TEGRA114
-	select PINCTRL_TEGRA20
-	select PINCTRL_TEGRA30
 	select PL310_ERRATA_727915 if CACHE_L2X0
 	select PL310_ERRATA_769419 if CACHE_L2X0
 	select SOC_BUS
-- 
1.8.1.5
