From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Tue, 26 Nov 2013 15:29:01 +0100
Subject: [PATCH] input: ixp4xx-beeper: don't use symbols from <mach/timex.h>
Message-ID: <1385476141-29131-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

mach/timex.h is about to be dropped so don't use symbols defined in
there. For ixp4xx there is a suitable substitute for IXP4XX_TIMER_FREQ,
i.e. a global and exported variable that holds the same value.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---

Hello,

I'd like to keep that patch in a series for the arm-soc people to pull that
get's rid of <mach/timex.h>, so please don't take this patch but only ack to
keep coordinating the series as easy as possible.

I don't know who's Ack is good enough to be counted as maintainer ack, so
please point that out in your reply, too.

Thanks
Uwe

 drivers/input/misc/ixp4xx-beeper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/misc/ixp4xx-beeper.c b/drivers/input/misc/ixp4xx-beeper.c
index 17ccba8..ed8e5e8 100644
--- a/drivers/input/misc/ixp4xx-beeper.c
+++ b/drivers/input/misc/ixp4xx-beeper.c
@@ -67,7 +67,7 @@ static int ixp4xx_spkr_event(struct input_dev *dev, unsigned int type, unsigned
 	}
 
 	if (value > 20 && value < 32767)
-		count = (IXP4XX_TIMER_FREQ / (value * 4)) - 1;
+		count = (ixp4xx_timer_freq / (value * 4)) - 1;
 
 	ixp4xx_spkr_control(pin, count);
 
-- 
1.8.4.2
