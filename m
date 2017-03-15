From: jonathanh@nvidia.com (Jon Hunter)
Date: Wed, 15 Mar 2017 13:31:55 +0000
Subject: [PATCH 5/5] soc/tegra: Add initial flowctrl support for Tegra210
In-Reply-To: <1489584715-23138-1-git-send-email-jonathanh@nvidia.com>
References: <1489584715-23138-1-git-send-email-jonathanh@nvidia.com>
Message-ID: <1489584715-23138-6-git-send-email-jonathanh@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tegra210 supports the flowctrl module and so add initial support for
this device.

Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
 drivers/soc/tegra/flowctrl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/tegra/flowctrl.c b/drivers/soc/tegra/flowctrl.c
index b94d9161e448..1a993104e7ff 100644
--- a/drivers/soc/tegra/flowctrl.c
+++ b/drivers/soc/tegra/flowctrl.c
@@ -147,6 +147,7 @@ void flowctrl_cpu_suspend_exit(unsigned int cpuid)
 }
 
 static const struct of_device_id matches[] __initconst = {
+	{ .compatible = "nvidia,tegra210-flowctrl" },
 	{ .compatible = "nvidia,tegra124-flowctrl" },
 	{ .compatible = "nvidia,tegra114-flowctrl" },
 	{ .compatible = "nvidia,tegra30-flowctrl" },
-- 
2.7.4
