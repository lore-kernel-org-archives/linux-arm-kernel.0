From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 22 May 2014 10:18:31 +0100
Subject: [PATCH] mfd: max14577: Cast to architecture agnostic data type
In-Reply-To: <1400750311-15323-1-git-send-email-lee.jones@linaro.org>
References: <1400750311-15323-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1400750311-15323-3-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

drivers/mfd/max14577.c:334:25:
  warning: cast from pointer to integer of different size
    max14577->dev_type = (unsigned int)of_id->data;
                         ^
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/max14577.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/max14577.c b/drivers/mfd/max14577.c
index 36de88d..4a5e885 100644
--- a/drivers/mfd/max14577.c
+++ b/drivers/mfd/max14577.c
@@ -331,7 +331,8 @@ static int max14577_i2c_probe(struct i2c_client *i2c,
 
 		of_id = of_match_device(max14577_dt_match, &i2c->dev);
 		if (of_id)
-			max14577->dev_type = (unsigned int)of_id->data;
+			max14577->dev_type =
+				(enum maxim_device_type)of_id->data;
 	} else {
 		max14577->dev_type = id->driver_data;
 	}
-- 
1.8.3.2
