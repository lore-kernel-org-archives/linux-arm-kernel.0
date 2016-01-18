From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Mon, 18 Jan 2016 09:41:55 +0100
Subject: [PATCH 1/2] iio:adc:at91-sama5d2: fix vref_uv type
Message-ID: <1453106516-17935-1-git-send-email-ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

vref_uv has to be an int.

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
---
 drivers/iio/adc/at91-sama5d2_adc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
index ecb2d90..f2d8bd5 100644
--- a/drivers/iio/adc/at91-sama5d2_adc.c
+++ b/drivers/iio/adc/at91-sama5d2_adc.c
@@ -171,7 +171,7 @@ struct at91_adc_state {
 	struct clk			*per_clk;
 	struct regulator		*reg;
 	struct regulator		*vref;
-	u32				vref_uv;
+	int				vref_uv;
 	const struct iio_chan_spec	*chan;
 	bool				conversion_done;
 	u32				conversion_value;
-- 
2.5.0
