From: ulf.hansson@stericsson.com (Ulf Hansson)
Date: Fri, 28 Sep 2012 13:21:04 +0200
Subject: [PATCH 1/3] Revert "spi/pl022: fix spi-pl022 pm enable at probe"
In-Reply-To: <1348831266-16721-1-git-send-email-ulf.hansson@stericsson.com>
References: <1348831266-16721-1-git-send-email-ulf.hansson@stericsson.com>
Message-ID: <1348831266-16721-2-git-send-email-ulf.hansson@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ulf Hansson <ulf.hansson@linaro.org>

This reverts commit 6887237cd7da904184dab2750504040c68f3a080.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/spi/spi-pl022.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-pl022.c b/drivers/spi/spi-pl022.c
index f8568b4..3f2f36c 100644
--- a/drivers/spi/spi-pl022.c
+++ b/drivers/spi/spi-pl022.c
@@ -2188,6 +2188,7 @@ pl022_probe(struct amba_device *adev, const struct amba_id *id)
 	printk(KERN_INFO "pl022: mapped registers from 0x%08x to %p\n",
 	       adev->res.start, pl022->virtbase);
 
+	pm_runtime_enable(dev);
 	pm_runtime_resume(dev);
 
 	pl022->clk = clk_get(&adev->dev, NULL);
-- 
1.7.10
