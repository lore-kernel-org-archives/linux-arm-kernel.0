From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 23 Jan 2014 15:05:55 +0000
Subject: [PATCH 3/4] mfd: wm8994-core: Naturalise cross-architecture
 discrepancies
In-Reply-To: <1390489556-9434-1-git-send-email-lee.jones@linaro.org>
References: <1390489556-9434-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1390489556-9434-3-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If we compile the WM8994 for a 64bit architecture we receive the following
warnings:

drivers/mfd/wm8994-core.c: In function ?wm8994_i2c_probe?:
drivers/mfd/wm8994-core.c:639:19:
  warning: cast from pointer to integer of different size
    wm8994->type = (int)of_id->data;
                   ^

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/wm8994-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/wm8994-core.c b/drivers/mfd/wm8994-core.c
index ba04f1b..e6fab94 100644
--- a/drivers/mfd/wm8994-core.c
+++ b/drivers/mfd/wm8994-core.c
@@ -636,7 +636,7 @@ static int wm8994_i2c_probe(struct i2c_client *i2c,
 	if (i2c->dev.of_node) {
 		of_id = of_match_device(wm8994_of_match, &i2c->dev);
 		if (of_id)
-			wm8994->type = (int)of_id->data;
+			wm8994->type = (enum wm8994_type)of_id->data;
 	} else {
 		wm8994->type = id->driver_data;
 	}
-- 
1.8.3.2
