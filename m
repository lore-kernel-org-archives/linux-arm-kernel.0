From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 18 May 2012 09:39:10 +0100
Subject: [PATCH 11/16] mfd: Enable Device Tree support in the ab8500-sysctrl
 driver
In-Reply-To: <1337330355-17747-1-git-send-email-lee.jones@linaro.org>
References: <1337330355-17747-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1337330355-17747-12-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch ensures probing of the ab8500-sysctrl driver during a DT
enabled boot, so long as the associated nodes are present in the
Device Tree binary.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/ab8500-sysctrl.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/mfd/ab8500-sysctrl.c b/drivers/mfd/ab8500-sysctrl.c
index c28d4eb..5a3e51c 100644
--- a/drivers/mfd/ab8500-sysctrl.c
+++ b/drivers/mfd/ab8500-sysctrl.c
@@ -61,10 +61,16 @@ static int __devexit ab8500_sysctrl_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct of_device_id ab8500_sysctrl_match[] = {
+	{ .compatible = "stericsson,ab8500-sysctrl", },
+	{}
+};
+
 static struct platform_driver ab8500_sysctrl_driver = {
 	.driver = {
 		.name = "ab8500-sysctrl",
 		.owner = THIS_MODULE,
+		.of_match_table = ab8500_sysctrl_match,
 	},
 	.probe = ab8500_sysctrl_probe,
 	.remove = __devexit_p(ab8500_sysctrl_remove),
-- 
1.7.9.5
