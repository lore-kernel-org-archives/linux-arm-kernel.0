From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Mon, 18 Jan 2016 09:41:56 +0100
Subject: [PATCH 2/2] iio:adc:at91-sama5d2: code cleanup
In-Reply-To: <1453106516-17935-1-git-send-email-ludovic.desroches@atmel.com>
References: <1453106516-17935-1-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <1453106516-17935-2-git-send-email-ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use var type for sizeof argument instead of the struct name.

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
---
 drivers/iio/adc/at91-sama5d2_adc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
index f2d8bd5..dbee13a 100644
--- a/drivers/iio/adc/at91-sama5d2_adc.c
+++ b/drivers/iio/adc/at91-sama5d2_adc.c
@@ -353,8 +353,7 @@ static int at91_adc_probe(struct platform_device *pdev)
 	struct resource	*res;
 	int ret;
 
-	indio_dev = devm_iio_device_alloc(&pdev->dev,
-					  sizeof(struct at91_adc_state));
+	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*st));
 	if (!indio_dev)
 		return -ENOMEM;
 
-- 
2.5.0
