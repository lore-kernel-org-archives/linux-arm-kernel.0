From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Thu, 18 Feb 2010 18:32:30 +0200
Subject: [PATCH 4/4] s3c24xx_ts: re-enable IRQ on resume
In-Reply-To: <1266510750-9846-1-git-send-email-anarsoul@gmail.com>
References: <1266510750-9846-1-git-send-email-anarsoul@gmail.com>
Message-ID: <1266510750-9846-5-git-send-email-anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

IRQ should be enabled on resume, otherwise driver doesn't
report events.

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 drivers/input/touchscreen/s3c2410_ts.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/input/touchscreen/s3c2410_ts.c b/drivers/input/touchscreen/s3c2410_ts.c
index e2fe2ed..6738c26 100644
--- a/drivers/input/touchscreen/s3c2410_ts.c
+++ b/drivers/input/touchscreen/s3c2410_ts.c
@@ -401,6 +401,7 @@ static int s3c2410ts_resume(struct device *dev)
 	struct s3c2410_ts_mach_info *info = pdev->dev.platform_data;
 
 	clk_enable(ts.clock);
+	enable_irq(ts.irq_tc);
 
 	/* Initialise registers */
 	if ((info->delay & 0xffff) > 0)
-- 
1.7.0
