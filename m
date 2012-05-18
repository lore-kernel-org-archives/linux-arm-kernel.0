From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 18 May 2012 09:39:00 +0100
Subject: [PATCH 01/16] Input: Add Device Tree support to the ab8500-ponkey
 driver
In-Reply-To: <1337330355-17747-1-git-send-email-lee.jones@linaro.org>
References: <1337330355-17747-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1337330355-17747-2-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch will allow the ab8500-ponkey driver to be probed during
boot when Device Tree is enabled.

Cc: linux-input at vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/input/misc/ab8500-ponkey.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/input/misc/ab8500-ponkey.c b/drivers/input/misc/ab8500-ponkey.c
index 350fd0c..394aa1f 100644
--- a/drivers/input/misc/ab8500-ponkey.c
+++ b/drivers/input/misc/ab8500-ponkey.c
@@ -131,10 +131,16 @@ static int __devexit ab8500_ponkey_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct of_device_id ab8500_ponkey_match[] = {
+	{ .compatible = "stericsson,ab8500-ponkey", },
+	{}
+};
+
 static struct platform_driver ab8500_ponkey_driver = {
 	.driver		= {
 		.name	= "ab8500-poweron-key",
 		.owner	= THIS_MODULE,
+		.of_match_table = ab8500_ponkey_match,
 	},
 	.probe		= ab8500_ponkey_probe,
 	.remove		= __devexit_p(ab8500_ponkey_remove),
-- 
1.7.9.5
