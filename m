From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu,  7 Feb 2013 14:43:24 -0700
Subject: [PATCH 2/2] ARM: tegra: sort Kconfig selects for Tegra114
In-Reply-To: <1360273404-32397-1-git-send-email-swarren@wwwdotorg.org>
References: <1360273404-32397-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1360273404-32397-2-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

The Kconfig options selected by ARCH_TEGRA_*_SOC were recently sorted.
Update the newly added ARCH_TEGRA_114_SOC's select statements to match.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/mach-tegra/Kconfig |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-tegra/Kconfig b/arch/arm/mach-tegra/Kconfig
index 8654324..d1c4893 100644
--- a/arch/arm/mach-tegra/Kconfig
+++ b/arch/arm/mach-tegra/Kconfig
@@ -45,10 +45,10 @@ config ARCH_TEGRA_3x_SOC
 
 config ARCH_TEGRA_114_SOC
 	bool "Enable support for Tegra114 family"
+	select ARM_ARCH_TIMER
 	select ARM_GIC
-	select CPU_V7
 	select ARM_L1_CACHE_SHIFT_6
-	select ARM_ARCH_TIMER
+	select CPU_V7
 	select PINCTRL
 	select PINCTRL_TEGRA114
 	help
-- 
1.7.10.4
