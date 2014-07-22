From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 22 Jul 2014 12:11:14 +0100
Subject: [PATCH 08/19] mfd: twl6040: Fix 'insert space after ','', error
In-Reply-To: <1406027485-15657-1-git-send-email-lee.jones@linaro.org>
References: <1406027485-15657-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1406027485-15657-9-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is part of an effort to clean-up the MFD subsystem.

ERROR: space required after that ',' (ctx:VxO)
+                                 0, &twl6040_irq_chip,&twl6040->irq_data);
                                                      ^

ERROR: space required before that '&' (ctx:OxV)
+                                 0, &twl6040_irq_chip,&twl6040->irq_data);
                                                       ^

total: 2 errors, 0 warnings, 816 lines checked

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/twl6040.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/twl6040.c b/drivers/mfd/twl6040.c
index ae26d84..f9c06c5 100644
--- a/drivers/mfd/twl6040.c
+++ b/drivers/mfd/twl6040.c
@@ -700,7 +700,7 @@ static int twl6040_probe(struct i2c_client *client,
 	}
 
 	ret = regmap_add_irq_chip(twl6040->regmap, twl6040->irq, IRQF_ONESHOT,
-				  0, &twl6040_irq_chip,&twl6040->irq_data);
+				  0, &twl6040_irq_chip, &twl6040->irq_data);
 	if (ret < 0)
 		goto gpio_err;
 
-- 
1.8.3.2
