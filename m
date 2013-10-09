From: josephl@nvidia.com (Joseph Lo)
Date: Wed, 9 Oct 2013 17:20:06 +0800
Subject: [PATCH 2/7] ARM: tegra: add flow controller to support suspend for
 Tegra124
In-Reply-To: <1381310411-11391-1-git-send-email-josephl@nvidia.com>
References: <1381310411-11391-1-git-send-email-josephl@nvidia.com>
Message-ID: <1381310411-11391-3-git-send-email-josephl@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the configuration of flow controller to support the last CPU
(CPU0) suspend function with cluster power down.

Signed-off-by: Joseph Lo <josephl@nvidia.com>
---
 arch/arm/mach-tegra/flowctrl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-tegra/flowctrl.c b/arch/arm/mach-tegra/flowctrl.c
index 5348543..ce8ab8a 100644
--- a/arch/arm/mach-tegra/flowctrl.c
+++ b/arch/arm/mach-tegra/flowctrl.c
@@ -87,6 +87,7 @@ void flowctrl_cpu_suspend_enter(unsigned int cpuid)
 		break;
 	case TEGRA30:
 	case TEGRA114:
+	case TEGRA124:
 		/* clear wfe bitmap */
 		reg &= ~TEGRA30_FLOW_CTRL_CSR_WFE_BITMAP;
 		/* clear wfi bitmap */
@@ -125,6 +126,7 @@ void flowctrl_cpu_suspend_exit(unsigned int cpuid)
 		break;
 	case TEGRA30:
 	case TEGRA114:
+	case TEGRA124:
 		/* clear wfe bitmap */
 		reg &= ~TEGRA30_FLOW_CTRL_CSR_WFE_BITMAP;
 		/* clear wfi bitmap */
-- 
1.8.4
