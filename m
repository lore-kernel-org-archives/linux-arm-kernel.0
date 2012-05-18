From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 18 May 2012 09:39:12 +0100
Subject: [PATCH 13/16] mfd: Enable Device Tree support in the ab8500-pwm driver
In-Reply-To: <1337330355-17747-1-git-send-email-lee.jones@linaro.org>
References: <1337330355-17747-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1337330355-17747-14-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch ensures probing of the ab8500-pwm driver during a DT
enabled boot, so long as the associated nodes are present in the
Device Tree binary.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/misc/ab8500-pwm.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/misc/ab8500-pwm.c b/drivers/misc/ab8500-pwm.c
index d7a9aa1..042a8fe 100644
--- a/drivers/misc/ab8500-pwm.c
+++ b/drivers/misc/ab8500-pwm.c
@@ -142,10 +142,16 @@ static int __devexit ab8500_pwm_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct of_device_id ab8500_pwm_match[] = {
+	{ .compatible = "stericsson,ab8500-pwm", },
+	{}
+};
+
 static struct platform_driver ab8500_pwm_driver = {
 	.driver = {
 		.name = "ab8500-pwm",
 		.owner = THIS_MODULE,
+		.of_match_table = ab8500_pwm_match,
 	},
 	.probe = ab8500_pwm_probe,
 	.remove = __devexit_p(ab8500_pwm_remove),
-- 
1.7.9.5
