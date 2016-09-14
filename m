From: guohanjun@huawei.com (Hanjun Guo)
Date: Wed, 14 Sep 2016 22:21:16 +0800
Subject: [RFC PATCH v2 08/11] irqchip: mbigen: drop module owner
In-Reply-To: <1473862879-7769-1-git-send-email-guohanjun@huawei.com>
References: <1473862879-7769-1-git-send-email-guohanjun@huawei.com>
Message-ID: <1473862879-7769-9-git-send-email-guohanjun@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kefeng Wang <wangkefeng.wang@huawei.com>

Module owner will be set by driver core, so drop it.

Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ma Jun <majun258@huawei.com>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 drivers/irqchip/irq-mbigen.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/irqchip/irq-mbigen.c b/drivers/irqchip/irq-mbigen.c
index 03b79b0..c01ab41 100644
--- a/drivers/irqchip/irq-mbigen.c
+++ b/drivers/irqchip/irq-mbigen.c
@@ -293,7 +293,6 @@ MODULE_DEVICE_TABLE(of, mbigen_of_match);
 static struct platform_driver mbigen_platform_driver = {
 	.driver = {
 		.name		= "Hisilicon MBIGEN-V2",
-		.owner		= THIS_MODULE,
 		.of_match_table	= mbigen_of_match,
 	},
 	.probe			= mbigen_device_probe,
-- 
1.7.12.4
