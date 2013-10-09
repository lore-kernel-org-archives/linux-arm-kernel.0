From: josephl@nvidia.com (Joseph Lo)
Date: Wed, 9 Oct 2013 17:20:07 +0800
Subject: [PATCH 3/7] ARM: tegra: hook tegra_cpu_tear_down for Tegra124
In-Reply-To: <1381310411-11391-1-git-send-email-josephl@nvidia.com>
References: <1381310411-11391-1-git-send-email-josephl@nvidia.com>
Message-ID: <1381310411-11391-4-git-send-email-josephl@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hook the tegra_cpu_tear_down function for Tegra124 to support platform
suspend.

Signed-off-by: Joseph Lo <josephl@nvidia.com>
---
 arch/arm/mach-tegra/pm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-tegra/pm.c b/arch/arm/mach-tegra/pm.c
index 36ed88a..14e75b7 100644
--- a/arch/arm/mach-tegra/pm.c
+++ b/arch/arm/mach-tegra/pm.c
@@ -59,8 +59,10 @@ static void tegra_tear_down_cpu_init(void)
 		break;
 	case TEGRA30:
 	case TEGRA114:
+	case TEGRA124:
 		if (IS_ENABLED(CONFIG_ARCH_TEGRA_3x_SOC) ||
-		    IS_ENABLED(CONFIG_ARCH_TEGRA_114_SOC))
+		    IS_ENABLED(CONFIG_ARCH_TEGRA_114_SOC) ||
+		    IS_ENABLED(CONFIG_ARCH_TEGRA_124_SOC))
 			tegra_tear_down_cpu = tegra30_tear_down_cpu;
 		break;
 	}
-- 
1.8.4
