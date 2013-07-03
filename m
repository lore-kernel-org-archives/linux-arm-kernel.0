From: josephl@nvidia.com (Joseph Lo)
Date: Wed, 3 Jul 2013 17:50:42 +0800
Subject: [PATCH V2 06/11] ARM: tegra114: hook tegra_tear_down_cpu function
In-Reply-To: <1372845047-25147-1-git-send-email-josephl@nvidia.com>
References: <1372845047-25147-1-git-send-email-josephl@nvidia.com>
Message-ID: <1372845047-25147-7-git-send-email-josephl@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hooking tegra_tear_down_cpu for Tegra114 for supporting cluster power
down when CPU cluster suspneded in LP2.

Signed-off-by: Joseph Lo <josephl@nvidia.com>
---
V2:
* take care the combination of the selection of the config ARCH_TEGRA_3x_SOC
  and TEGRA_114_SOC
---
 arch/arm/mach-tegra/pm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-tegra/pm.c b/arch/arm/mach-tegra/pm.c
index 261fec1..3d07cd5 100644
--- a/arch/arm/mach-tegra/pm.c
+++ b/arch/arm/mach-tegra/pm.c
@@ -52,7 +52,9 @@ static void tegra_tear_down_cpu_init(void)
 			tegra_tear_down_cpu = tegra20_tear_down_cpu;
 		break;
 	case TEGRA30:
-		if (IS_ENABLED(CONFIG_ARCH_TEGRA_3x_SOC))
+	case TEGRA114:
+		if (IS_ENABLED(CONFIG_ARCH_TEGRA_3x_SOC) ||
+		    IS_ENABLED(CONFIG_ARCH_TEGRA_114_SOC))
 			tegra_tear_down_cpu = tegra30_tear_down_cpu;
 		break;
 	}
-- 
1.8.3.2
