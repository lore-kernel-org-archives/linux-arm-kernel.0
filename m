From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 11 Jun 2012 16:24:58 +0100
Subject: [PATCH 05/14] mfd: Enable DT probing of the DB8500 PRCMU
In-Reply-To: <1339428307-3850-1-git-send-email-lee.jones@linaro.org>
References: <1339428307-3850-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1339428307-3850-6-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the correct compatible string for use during Device Tree
population. Without it the DB8500 PRCMU will not be probed.

Cc: Samuel Ortiz <sameo@linux.intel.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/db8500-prcmu.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/mfd/db8500-prcmu.c b/drivers/mfd/db8500-prcmu.c
index 50e83dc5..c702f18 100644
--- a/drivers/mfd/db8500-prcmu.c
+++ b/drivers/mfd/db8500-prcmu.c
@@ -3004,11 +3004,16 @@ static int __devinit db8500_prcmu_probe(struct platform_device *pdev)
 no_irq_return:
 	return err;
 }
+static const struct of_device_id db8500_prcmu_match[] = {
+	{ .compatible = "stericsson,db8500-prcmu", },
+	{ },
+};
 
 static struct platform_driver db8500_prcmu_driver = {
 	.driver = {
 		.name = "db8500-prcmu",
 		.owner = THIS_MODULE,
+		.of_match_table = db8500_prcmu_match,
 	},
 	.probe = db8500_prcmu_probe,
 };
-- 
1.7.9.5
