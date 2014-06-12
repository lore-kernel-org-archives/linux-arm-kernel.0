From: boris.brezillon@free-electrons.com (Boris BREZILLON)
Date: Thu, 12 Jun 2014 09:32:01 +0200
Subject: [PATCH] i2c: sun6-p2wi: fix erroneous error message
In-Reply-To: <53994cdd.dj2lZ0lrPyPuIr9Z%fengguang.wu@intel.com>
References: <53994cdd.dj2lZ0lrPyPuIr9Z%fengguang.wu@intel.com>
Message-ID: <1402558321-18981-1-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The variable containing the return value of platform_get_irq is irq not
ret, this means the error code printed in the error message will be false.

Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>
Reported-by: Fengguang Wu <fengguang.wu@intel.com>
---

Hello Wolfram,

This patch fixes a bug reported by Fengguang's build robot.

I know you've already applied my series to your for-next tree, but let me
know if you want me to squash this patch into the P2WI series and send a v8.

Best Regards,

Boris

 drivers/i2c/busses/i2c-sun6i-p2wi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-sun6i-p2wi.c b/drivers/i2c/busses/i2c-sun6i-p2wi.c
index f1d3e6f..5d2d678 100644
--- a/drivers/i2c/busses/i2c-sun6i-p2wi.c
+++ b/drivers/i2c/busses/i2c-sun6i-p2wi.c
@@ -240,7 +240,7 @@ static int p2wi_probe(struct platform_device *pdev)
 	snprintf(p2wi->adapter.name, sizeof(p2wi->adapter.name), pdev->name);
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(dev, "failed to retrieve irq: %d\n", ret);
+		dev_err(dev, "failed to retrieve irq: %d\n", irq);
 		return irq;
 	}
 
-- 
1.8.3.2
