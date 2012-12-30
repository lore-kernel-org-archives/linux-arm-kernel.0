From: robherring2@gmail.com (Rob Herring)
Date: Sun, 30 Dec 2012 16:07:48 -0600
Subject: [PATCH] rtc: pl031: add wake-up support
Message-ID: <1356905268-29587-1-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

Mark the pl031 as wake-up capable so that rtcwake and suspend test can work.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
Cc: Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Alessandro Zummo <a.zummo@towertech.it>
Cc: linux-arm-kernel at lists.infradead.org
Cc: rtc-linux at googlegroups.com
Cc: linux-kernel at vger.kernel.org
---
 drivers/rtc/rtc-pl031.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/rtc/rtc-pl031.c b/drivers/rtc/rtc-pl031.c
index 08378e3..9e20958 100644
--- a/drivers/rtc/rtc-pl031.c
+++ b/drivers/rtc/rtc-pl031.c
@@ -380,6 +380,8 @@ static int pl031_probe(struct amba_device *adev, const struct amba_id *id)
 		goto out_no_irq;
 	}
 
+	device_init_wakeup(&adev->dev, 1);
+
 	return 0;
 
 out_no_irq:
-- 
1.7.10.4
