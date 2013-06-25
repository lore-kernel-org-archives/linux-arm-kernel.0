From: josephl@nvidia.com (Joseph Lo)
Date: Tue, 25 Jun 2013 17:27:50 +0800
Subject: [PATCH 06/11] ARM: tegra114: hook tegra_tear_down_cpu function
In-Reply-To: <1372152475-18617-1-git-send-email-josephl@nvidia.com>
References: <1372152475-18617-1-git-send-email-josephl@nvidia.com>
Message-ID: <1372152475-18617-7-git-send-email-josephl@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hooking tegra_tear_down_cpu for Tegra114 for supporting cluster power
down when CPU cluster suspneded in LP2.

Signed-off-by: Joseph Lo <josephl@nvidia.com>
---
 arch/arm/mach-tegra/pm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-tegra/pm.c b/arch/arm/mach-tegra/pm.c
index 94e69be..a0668a2 100644
--- a/arch/arm/mach-tegra/pm.c
+++ b/arch/arm/mach-tegra/pm.c
@@ -52,6 +52,7 @@ static void tegra_tear_down_cpu_init(void)
 			tegra_tear_down_cpu = tegra20_tear_down_cpu;
 		break;
 	case TEGRA30:
+	case TEGRA114:
 		if (IS_ENABLED(CONFIG_ARCH_TEGRA_3x_SOC))
 			tegra_tear_down_cpu = tegra30_tear_down_cpu;
 		break;
-- 
1.8.3.1
