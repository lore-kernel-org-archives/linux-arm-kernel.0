From: fabio.baltieri@linaro.org (Fabio Baltieri)
Date: Fri, 26 Apr 2013 14:17:17 +0200
Subject: [PATCH 4/5] mfd: ab8500-sysctrl: set sysctrl_dev during probe
In-Reply-To: <1366978638-967-1-git-send-email-fabio.baltieri@linaro.org>
References: <1366978638-967-1-git-send-email-fabio.baltieri@linaro.org>
Message-ID: <1366978638-967-5-git-send-email-fabio.baltieri@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The driver requires sysctrl_dev to be set at probe, as it's used by
other driver functions.  This was dropped by mistake in:

2377e52 mfd: ab8500-sysctrl: Error check clean up

making all driver functions fail.

Signed-off-by: Fabio Baltieri <fabio.baltieri@linaro.org>
---
 drivers/mfd/ab8500-sysctrl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mfd/ab8500-sysctrl.c b/drivers/mfd/ab8500-sysctrl.c
index 640495e..b851692 100644
--- a/drivers/mfd/ab8500-sysctrl.c
+++ b/drivers/mfd/ab8500-sysctrl.c
@@ -191,6 +191,8 @@ static int ab8500_sysctrl_probe(struct platform_device *pdev)
 	if (!(plat && plat->sysctrl))
 		return -EINVAL;
 
+	sysctrl_dev = &pdev->dev;
+
 	if (plat->pm_power_off)
 		pm_power_off = ab8500_power_off;
 
-- 
1.8.1.3
