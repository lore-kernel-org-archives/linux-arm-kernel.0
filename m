From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Wed, 19 May 2010 09:50:56 +0800
Subject: [PATCH] input: fix irq number of onkey in 88pm860x
Message-ID: <mailman.458.1274252200.2170.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Irq number of onkey is assigned twice. The second assignment is wrong.

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 drivers/input/misc/88pm860x_onkey.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/input/misc/88pm860x_onkey.c
b/drivers/input/misc/88pm860x_onkey.c
index 40dabd8..4cc8282 100644
--- a/drivers/input/misc/88pm860x_onkey.c
+++ b/drivers/input/misc/88pm860x_onkey.c
@@ -87,7 +87,6 @@ static int __devinit pm860x_onkey_probe(struct
platform_device *pdev)
 	info->idev->phys = "88pm860x_on/input0";
 	info->idev->id.bustype = BUS_I2C;
 	info->idev->dev.parent = &pdev->dev;
-	info->irq = irq;
 	info->idev->evbit[0] = BIT_MASK(EV_KEY);
 	info->idev->keybit[BIT_WORD(KEY_POWER)] = BIT_MASK(KEY_POWER);

-- 
1.5.6.5
