From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 17 May 2012 14:45:22 +0100
Subject: [PATCH 17/18] mfd: Enable ab8500-gpadc driver for Device Tree
In-Reply-To: <1337262323-27692-1-git-send-email-lee.jones@linaro.org>
References: <1337262323-27692-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1337262323-27692-18-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch will allow the ab8500-gpadc driver to be probed during
Device Tree enabled boot.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/ab8500-gpadc.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/mfd/ab8500-gpadc.c b/drivers/mfd/ab8500-gpadc.c
index c1656ab..b86fd8e 100644
--- a/drivers/mfd/ab8500-gpadc.c
+++ b/drivers/mfd/ab8500-gpadc.c
@@ -648,12 +648,18 @@ static int __devexit ab8500_gpadc_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct of_device_id ab8500_gpadc_match[] = {
+	{ .compatible = "stericsson,ab8500-gpadc", },
+	{}
+};
+
 static struct platform_driver ab8500_gpadc_driver = {
 	.probe = ab8500_gpadc_probe,
 	.remove = __devexit_p(ab8500_gpadc_remove),
 	.driver = {
 		.name = "ab8500-gpadc",
 		.owner = THIS_MODULE,
+		.of_match_table = ab8500_gpadc_match,
 	},
 };
 
-- 
1.7.9.5
