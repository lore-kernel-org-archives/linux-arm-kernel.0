From: jg1.han@samsung.com (Jingoo Han)
Date: Mon, 21 Oct 2013 10:52:15 +0900
Subject: [PATCH 1/2] ARM: EXYNOS: Use dev_err() instead of printk() for cpuidle
 driver
Message-ID: <003601cece00$2affeba0$80ffc2e0$%han@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Change raw printk() call to dev_err() to provide a better message
to userspace so it can properly identify the device.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
- Based against pm-cpuidle branch
- Tested on Exynos5440

 arch/arm/mach-exynos/cpuidle.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-exynos/cpuidle.c b/arch/arm/mach-exynos/cpuidle.c
index 1bde6ad..6616e0f 100644
--- a/arch/arm/mach-exynos/cpuidle.c
+++ b/arch/arm/mach-exynos/cpuidle.c
@@ -206,7 +206,7 @@ static int __init exynos_cpuidle_probe(struct platform_device *pdev)
 
 	ret = cpuidle_register_driver(&exynos4_idle_driver);
 	if (ret) {
-		printk(KERN_ERR "CPUidle failed to register driver\n");
+		dev_err(&pdev->dev, "failed to register cpuidle driver\n");
 		return ret;
 	}
 
@@ -220,7 +220,7 @@ static int __init exynos_cpuidle_probe(struct platform_device *pdev)
 
 		ret = cpuidle_register_device(device);
 		if (ret) {
-			printk(KERN_ERR "CPUidle register device failed\n");
+			dev_err(&pdev->dev, "failed to register cpuidle device\n");
 			return ret;
 		}
 	}
-- 
1.7.10.4
