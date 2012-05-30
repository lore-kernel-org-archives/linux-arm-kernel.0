From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 30 May 2012 12:47:40 +0800
Subject: [PATCH 22/22] mfd: Enable DT probing of the DB8500 PRCMU
In-Reply-To: <1338353260-10097-1-git-send-email-lee.jones@linaro.org>
References: <1338353260-10097-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1338353260-10097-23-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the correct compatible string for use during Device Tree
population. Without it the DB8500 PRCMU will not be probed.

Cc: Samuel Ortiz <sameo@linux.intel.com>
Cc: linux-kernel at vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/db8500-prcmu.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/mfd/db8500-prcmu.c b/drivers/mfd/db8500-prcmu.c
index 74595e1..01f01f3 100644
--- a/drivers/mfd/db8500-prcmu.c
+++ b/drivers/mfd/db8500-prcmu.c
@@ -2994,11 +2994,16 @@ static int __init db8500_prcmu_probe(struct platform_device *pdev)
 no_irq_return:
 	return err;
 }
+static const struct of_device_id db8500_prcmu_match[] = {
+	{ .compatible = "stericsson,db8500-prcmu"},
+	{ },
+};
 
 static struct platform_driver db8500_prcmu_driver = {
 	.driver = {
 		.name = "db8500-prcmu",
 		.owner = THIS_MODULE,
+		.of_match_table = db8500_prcmu_match,
 	},
 };
 
-- 
1.7.9.5
