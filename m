From: ludovic.desroches@atmel.com (ludovic.desroches at atmel.com)
Date: Fri, 23 Nov 2012 10:09:02 +0100
Subject: [PATCH 1/3] i2c: at91: fix compilation warning
In-Reply-To: <1353661744-5703-1-git-send-email-ludovic.desroches@atmel.com>
References: <1353661744-5703-1-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <1353661744-5703-2-git-send-email-ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ludovic Desroches <ludovic.desroches@atmel.com>

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
---
 drivers/i2c/busses/i2c-at91.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-at91.c b/drivers/i2c/busses/i2c-at91.c
index aa59a25..f222600 100644
--- a/drivers/i2c/busses/i2c-at91.c
+++ b/drivers/i2c/busses/i2c-at91.c
@@ -408,7 +408,7 @@ static struct at91_twi_pdata * __devinit at91_twi_get_driver_data(
 		match = of_match_node(atmel_twi_dt_ids, pdev->dev.of_node);
 		if (!match)
 			return NULL;
-		return match->data;
+		return (struct at91_twi_pdata *)match->data;
 	}
 	return (struct at91_twi_pdata *) platform_get_device_id(pdev)->driver_data;
 }
-- 
1.7.11.3
