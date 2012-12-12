From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Wed, 12 Dec 2012 16:17:52 +0100
Subject: [PATCH 1/1] iio: at91: fix dev var name in at91_adc_trigger_handler
Message-ID: <1355325472-31836-1-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

/opt/work/linux-2.6/drivers/iio/adc/at91_adc.c: In function 'at91_adc_trigger_handler':
/opt/work/linux-2.6/drivers/iio/adc/at91_adc.c:83:22: error: 'indio_dev' undeclared (first use in this function)
/opt/work/linux-2.6/drivers/iio/adc/at91_adc.c:83:22: note: each undeclared identifier is reported only once for each function it appears in

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: linux-iio at vger.kernel.org
---
 drivers/iio/adc/at91_adc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
index 03b8594..315bed1 100644
--- a/drivers/iio/adc/at91_adc.c
+++ b/drivers/iio/adc/at91_adc.c
@@ -80,7 +80,7 @@ static irqreturn_t at91_adc_trigger_handler(int irq, void *p)
 		*timestamp = pf->timestamp;
 	}
 
-	iio_push_to_buffers(indio_dev, (u8 *)st->buffer);
+	iio_push_to_buffers(idev, (u8 *)st->buffer);
 
 	iio_trigger_notify_done(idev->trig);
 
-- 
1.7.10.4
