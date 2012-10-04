From: ulf.hansson@stericsson.com (Ulf Hansson)
Date: Thu, 4 Oct 2012 10:04:39 +0200
Subject: [PATCH V2 1/3] Revert "spi/pl022: fix spi-pl022 pm enable at probe"
In-Reply-To: <1349337881-15917-1-git-send-email-ulf.hansson@stericsson.com>
References: <1349337881-15917-1-git-send-email-ulf.hansson@stericsson.com>
Message-ID: <1349337881-15917-2-git-send-email-ulf.hansson@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ulf Hansson <ulf.hansson@linaro.org>

This reverts commit 6887237cd7da904184dab2750504040c68f3a080.

This reverts is done due to earlier wrong commit, which is
also reverted. "Revert "spi/pl022: enable runtime PM""

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/spi/spi-pl022.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-pl022.c b/drivers/spi/spi-pl022.c
index 9194641..5cf0643 100644
--- a/drivers/spi/spi-pl022.c
+++ b/drivers/spi/spi-pl022.c
@@ -2186,6 +2186,7 @@ pl022_probe(struct amba_device *adev, const struct amba_id *id)
 	printk(KERN_INFO "pl022: mapped registers from 0x%08x to %p\n",
 	       adev->res.start, pl022->virtbase);
 
+	pm_runtime_enable(dev);
 	pm_runtime_resume(dev);
 
 	pl022->clk = devm_clk_get(&adev->dev, NULL);
-- 
1.7.10
