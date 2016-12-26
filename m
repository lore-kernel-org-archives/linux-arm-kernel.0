From: bhumirks@gmail.com (Bhumika Goyal)
Date: Mon, 26 Dec 2016 17:01:02 +0530
Subject: [PATCH] rtc: armada38x: add __ro_after_init to armada38x_rtc_ops
Message-ID: <1482751862-18699-1-git-send-email-bhumirks@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The object armada38x_rtc_ops of type rtc_class_ops structure is not
modified after getting initialized by armada38x_rtc_probe. Apart from
getting referenced in init it is also passed as an argument to the function
devm_rtc_device_register but this argument is of type const struct
rtc_class_ops *. Therefore add __ro_after_init to its declaration.

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 drivers/rtc/rtc-armada38x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-armada38x.c b/drivers/rtc/rtc-armada38x.c
index 9a3f2a6..7883c7f 100644
--- a/drivers/rtc/rtc-armada38x.c
+++ b/drivers/rtc/rtc-armada38x.c
@@ -202,7 +202,7 @@ static irqreturn_t armada38x_rtc_alarm_irq(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-static struct rtc_class_ops armada38x_rtc_ops = {
+static struct rtc_class_ops armada38x_rtc_ops __ro_after_init = {
 	.read_time = armada38x_rtc_read_time,
 	.set_time = armada38x_rtc_set_time,
 	.read_alarm = armada38x_rtc_read_alarm,
-- 
1.9.1
