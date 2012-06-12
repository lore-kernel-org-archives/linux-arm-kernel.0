From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 12 Jun 2012 09:57:37 +0100
Subject: [PATCH 01/14] rtc: ab8500-rtc: IRQF_ONESHOT when requesting a threaded
 IRQ
In-Reply-To: <201206111531.20468.arnd@arndb.de>
References: <1339428307-3850-1-git-send-email-lee.jones@linaro.org>
 <1339428307-3850-2-git-send-email-lee.jones@linaro.org>
 <201206111531.20468.arnd@arndb.de>
Message-ID: <4FD70481.6020207@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Lee Jones <lee.jones@linaro.org>
Date: Tue, 22 May 2012 15:25:09 +0100
Subject: [PATCH 01/14] rtc: ab8500-rtc: IRQF_ONESHOT when requesting a
 threaded IRQ

The kernel now forces IRQs to be ONESHOT if no IRQ handler is passed.

Cc: Alessandro Zummo <a.zummo@towertech.it>
Cc: rtc-linux at googlegroups.com
Cc: stable at vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/rtc/rtc-ab8500.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-ab8500.c b/drivers/rtc/rtc-ab8500.c
index 4bcf9ca..b11a2ec 100644
--- a/drivers/rtc/rtc-ab8500.c
+++ b/drivers/rtc/rtc-ab8500.c
@@ -422,7 +422,7 @@ static int __devinit ab8500_rtc_probe(struct platform_device *pdev)
 	}
 
 	err = request_threaded_irq(irq, NULL, rtc_alarm_handler,
-		IRQF_NO_SUSPEND, "ab8500-rtc", rtc);
+		IRQF_NO_SUSPEND | IRQF_ONESHOT, "ab8500-rtc", rtc);
 	if (err < 0) {
 		rtc_device_unregister(rtc);
 		return err;
-- 
1.7.9.5
