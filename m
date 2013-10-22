From: sre@debian.org (Sebastian Reichel)
Date: Tue, 22 Oct 2013 14:55:02 +0200
Subject: [PATCH 2/4] Input: twl4030-pwrbutton: use dev_err for errors
In-Reply-To: <1382446504-27837-1-git-send-email-sre@debian.org>
References: <1382446504-27837-1-git-send-email-sre@debian.org>
Message-ID: <1382446504-27837-3-git-send-email-sre@debian.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use dev_err() to output errors instead of dev_dbg().

Signed-off-by: Sebastian Reichel <sre@debian.org>
---
 drivers/input/misc/twl4030-pwrbutton.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/input/misc/twl4030-pwrbutton.c b/drivers/input/misc/twl4030-pwrbutton.c
index e450947..4e7a810 100644
--- a/drivers/input/misc/twl4030-pwrbutton.c
+++ b/drivers/input/misc/twl4030-pwrbutton.c
@@ -60,7 +60,7 @@ static int twl4030_pwrbutton_probe(struct platform_device *pdev)
 
 	pwr = input_allocate_device();
 	if (!pwr) {
-		dev_dbg(&pdev->dev, "Can't allocate power button\n");
+		dev_err(&pdev->dev, "Can't allocate power button\n");
 		return -ENOMEM;
 	}
 
@@ -74,13 +74,13 @@ static int twl4030_pwrbutton_probe(struct platform_device *pdev)
 			IRQF_TRIGGER_FALLING | IRQF_TRIGGER_RISING,
 			"twl4030_pwrbutton", pwr);
 	if (err < 0) {
-		dev_dbg(&pdev->dev, "Can't get IRQ for pwrbutton: %d\n", err);
+		dev_err(&pdev->dev, "Can't get IRQ for pwrbutton: %d\n", err);
 		goto free_input_dev;
 	}
 
 	err = input_register_device(pwr);
 	if (err) {
-		dev_dbg(&pdev->dev, "Can't register power button: %d\n", err);
+		dev_err(&pdev->dev, "Can't register power button: %d\n", err);
 		goto free_irq;
 	}
 
-- 
1.8.4.rc3
