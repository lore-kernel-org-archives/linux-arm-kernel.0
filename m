From: josephl@nvidia.com (Joseph Lo)
Date: Wed, 3 Jul 2013 17:50:43 +0800
Subject: [PATCH V2 07/11] ARM: tegra114: flowctrl: add support for
 cpu_suspend_enter/exit
In-Reply-To: <1372845047-25147-1-git-send-email-josephl@nvidia.com>
References: <1372845047-25147-1-git-send-email-josephl@nvidia.com>
Message-ID: <1372845047-25147-8-git-send-email-josephl@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The flow controller can help CPU to go into suspend mode (powered-down
state). When CPU goes into powered-down state, it needs some careful
settings before getting into and after leaving. The enter and exit
functions do that by configuring appropriate mode for flow controller.

For Tegra114, the setting is compatible with Tegra30.

Signed-off-by: Joseph Lo <josephl@nvidia.com>
---
V2:
* no change
---
 arch/arm/mach-tegra/flowctrl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-tegra/flowctrl.c b/arch/arm/mach-tegra/flowctrl.c
index b477ef3..5348543 100644
--- a/arch/arm/mach-tegra/flowctrl.c
+++ b/arch/arm/mach-tegra/flowctrl.c
@@ -86,6 +86,7 @@ void flowctrl_cpu_suspend_enter(unsigned int cpuid)
 		reg |= TEGRA20_FLOW_CTRL_CSR_WFE_CPU0 << cpuid;
 		break;
 	case TEGRA30:
+	case TEGRA114:
 		/* clear wfe bitmap */
 		reg &= ~TEGRA30_FLOW_CTRL_CSR_WFE_BITMAP;
 		/* clear wfi bitmap */
@@ -123,6 +124,7 @@ void flowctrl_cpu_suspend_exit(unsigned int cpuid)
 		reg &= ~TEGRA20_FLOW_CTRL_CSR_WFI_BITMAP;
 		break;
 	case TEGRA30:
+	case TEGRA114:
 		/* clear wfe bitmap */
 		reg &= ~TEGRA30_FLOW_CTRL_CSR_WFE_BITMAP;
 		/* clear wfi bitmap */
-- 
1.8.3.2
