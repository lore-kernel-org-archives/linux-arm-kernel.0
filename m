From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 17 May 2012 14:45:19 +0100
Subject: [PATCH 14/18] mfd: Enable ab8500-debug when Device Tree is enabled
In-Reply-To: <1337262323-27692-1-git-send-email-lee.jones@linaro.org>
References: <1337262323-27692-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1337262323-27692-15-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allow the ab8500-debugfs driver to be probed during DT start-up.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/ab8500-debugfs.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/mfd/ab8500-debugfs.c b/drivers/mfd/ab8500-debugfs.c
index 9a0211a..50c4c89 100644
--- a/drivers/mfd/ab8500-debugfs.c
+++ b/drivers/mfd/ab8500-debugfs.c
@@ -608,10 +608,16 @@ static int __devexit ab8500_debug_remove(struct platform_device *plf)
 	return 0;
 }
 
+static const struct of_device_id ab8500_debug_match[] = {
+        { .compatible = "stericsson,ab8500-debug", },
+        {}
+};
+
 static struct platform_driver ab8500_debug_driver = {
 	.driver = {
 		.name = "ab8500-debug",
 		.owner = THIS_MODULE,
+		.of_match_table = ab8500_debug_match,
 	},
 	.probe  = ab8500_debug_probe,
 	.remove = __devexit_p(ab8500_debug_remove)
-- 
1.7.9.5
