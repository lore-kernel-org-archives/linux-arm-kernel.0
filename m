From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 15 Jan 2013 12:56:04 +0000
Subject: [PATCH 24/26] mfd: ab8500-debugfs: sizeof() mismatch bugfix
In-Reply-To: <1358254566-12419-1-git-send-email-lee.jones@linaro.org>
References: <1358254566-12419-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1358254566-12419-25-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ashok G <ashok.g@stericsson.com>

Simple pointer error fix to obtain the expected sizeof() result.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Ashok G <ashok.g@stericsson.com>
Reviewed-by: Mattias WALLIN <mattias.wallin@stericsson.com>
---
 drivers/mfd/ab8500-debugfs.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/ab8500-debugfs.c b/drivers/mfd/ab8500-debugfs.c
index 8e405af..4147984 100644
--- a/drivers/mfd/ab8500-debugfs.c
+++ b/drivers/mfd/ab8500-debugfs.c
@@ -1565,7 +1565,7 @@ static int __devinit ab8500_debug_probe(struct platform_device *plf)
 	ab8500 = dev_get_drvdata(plf->dev.parent);
 	num_irqs = ab8500->mask_size;
 
-	irq_count = kzalloc(sizeof(irq_count)*num_irqs, GFP_KERNEL);
+	irq_count = kzalloc(sizeof(*irq_count)*num_irqs, GFP_KERNEL);
 	if (!irq_count)
 		return -ENOMEM;
 
-- 
1.7.9.5
