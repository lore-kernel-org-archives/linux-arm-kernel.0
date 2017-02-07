From: weiyj.lk@gmail.com (Wei Yongjun)
Date: Tue,  7 Feb 2017 15:56:45 +0000
Subject: [PATCH -next] cpufreq: brcmstb-avs-cpufreq: remove unnecessary
 platform_set_drvdata()
Message-ID: <20170207155645.5455-1-weiyj.lk@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wei Yongjun <weiyongjun1@huawei.com>

The driver core clears the driver data to NULL after device_release
or on probe failure. Thus, it is not needed to manually clear the
device driver data to NULL.

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/cpufreq/brcmstb-avs-cpufreq.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/cpufreq/brcmstb-avs-cpufreq.c b/drivers/cpufreq/brcmstb-avs-cpufreq.c
index c943606..7281a2c 100644
--- a/drivers/cpufreq/brcmstb-avs-cpufreq.c
+++ b/drivers/cpufreq/brcmstb-avs-cpufreq.c
@@ -878,7 +878,6 @@ static int brcm_avs_prepare_init(struct platform_device *pdev)
 	iounmap(priv->avs_intr_base);
 unmap_base:
 	iounmap(priv->base);
-	platform_set_drvdata(pdev, NULL);
 
 	return ret;
 }
@@ -1042,7 +1041,6 @@ static int brcm_avs_cpufreq_remove(struct platform_device *pdev)
 	priv = platform_get_drvdata(pdev);
 	iounmap(priv->base);
 	iounmap(priv->avs_intr_base);
-	platform_set_drvdata(pdev, NULL);
 
 	return 0;
 }
