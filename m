From: guohanjun@huawei.com (Hanjun Guo)
Date: Tue, 7 Mar 2017 20:40:08 +0800
Subject: [PATCH v9 13/15] irqchip: mbigen: drop module owner
In-Reply-To: <1488890410-15503-1-git-send-email-guohanjun@huawei.com>
References: <1488890410-15503-1-git-send-email-guohanjun@huawei.com>
Message-ID: <1488890410-15503-14-git-send-email-guohanjun@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kefeng Wang <wangkefeng.wang@huawei.com>

Module owner will be set by driver core, so drop it.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
Reviewed-by: Ma Jun <majun258@huawei.com>
Tested-by: Ming Lei <ming.lei@canonical.com>
Tested-by: Wei Xu <xuwei5@hisilicon.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/irqchip/irq-mbigen.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/irqchip/irq-mbigen.c b/drivers/irqchip/irq-mbigen.c
index 03b79b0..c01ab41 100644
--- a/drivers/irqchip/irq-mbigen.c
+++ b/drivers/irqchip/irq-mbigen.c
@@ -293,7 +293,6 @@ static int mbigen_device_probe(struct platform_device *pdev)
 static struct platform_driver mbigen_platform_driver = {
 	.driver = {
 		.name		= "Hisilicon MBIGEN-V2",
-		.owner		= THIS_MODULE,
 		.of_match_table	= mbigen_of_match,
 	},
 	.probe			= mbigen_device_probe,
-- 
1.7.12.4
