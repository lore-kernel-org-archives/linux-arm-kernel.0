From: pchiu@nvidia.com (Penny Chiu)
Date: Fri, 22 Apr 2016 18:31:07 +0800
Subject: [PATCH 07/11] cpufreq: tegra124: Add Tegra210 support
In-Reply-To: <1461321071-6431-1-git-send-email-pchiu@nvidia.com>
References: <1461321071-6431-1-git-send-email-pchiu@nvidia.com>
Message-ID: <1461321071-6431-8-git-send-email-pchiu@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add tegra210 support in tegra124 cpufreq driver.

Signed-off-by: Penny Chiu <pchiu@nvidia.com>
---
 drivers/cpufreq/tegra124-cpufreq.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/tegra124-cpufreq.c b/drivers/cpufreq/tegra124-cpufreq.c
index 20bcceb..c891e6e 100644
--- a/drivers/cpufreq/tegra124-cpufreq.c
+++ b/drivers/cpufreq/tegra124-cpufreq.c
@@ -188,7 +188,8 @@ static int __init tegra_cpufreq_init(void)
 	int ret;
 	struct platform_device *pdev;
 
-	if (!of_machine_is_compatible("nvidia,tegra124"))
+	if (!of_machine_is_compatible("nvidia,tegra124") &&
+	    !of_machine_is_compatible("nvidia,tegra210"))
 		return -ENODEV;
 
 	/*
-- 
2.8.1
