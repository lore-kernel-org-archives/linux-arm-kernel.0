From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Sat, 12 Aug 2017 12:19:44 +0200
Subject: [PATCH V2 2/2] pwm: bcm2835: Support for polarity setting via DT
In-Reply-To: <1502533184-15765-1-git-send-email-stefan.wahren@i2se.com>
References: <1502533184-15765-1-git-send-email-stefan.wahren@i2se.com>
Message-ID: <1502533184-15765-3-git-send-email-stefan.wahren@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds support for the third (optional) pwm cell to specify the
polarity, which is needed by display backlights for example.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
Reviewed-by: Eric Anholt <eric@anholt.net>
---
 drivers/pwm/pwm-bcm2835.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pwm/pwm-bcm2835.c b/drivers/pwm/pwm-bcm2835.c
index c5dbf16..db001cb 100644
--- a/drivers/pwm/pwm-bcm2835.c
+++ b/drivers/pwm/pwm-bcm2835.c
@@ -167,6 +167,8 @@ static int bcm2835_pwm_probe(struct platform_device *pdev)
 	pc->chip.dev = &pdev->dev;
 	pc->chip.ops = &bcm2835_pwm_ops;
 	pc->chip.npwm = 2;
+	pc->chip.of_xlate = of_pwm_xlate_with_flags;
+	pc->chip.of_pwm_n_cells = 3;
 
 	platform_set_drvdata(pdev, pc);
 
-- 
2.7.4
