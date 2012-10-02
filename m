From: lee.jones@linaro.org (Lee Jones)
Date: Tue,  2 Oct 2012 09:13:16 +0100
Subject: [PATCH 03/10] Input: bu21013_ts - Request a regulator that actually
 exists
In-Reply-To: <1349165603-24401-1-git-send-email-lee.jones@linaro.org>
References: <1349165603-24401-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1349165603-24401-4-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently the BU21013 Touch Screen driver requests a regulator by the
name of 'V-TOUCH', which doesn't exist anywhere in the kernel. The
correct name, as referenced in platform regulator code is 'avdd'. Here,
when we request a regulator, we use the correct name instead.

Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input at vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/input/touchscreen/bu21013_ts.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/bu21013_ts.c b/drivers/input/touchscreen/bu21013_ts.c
index 5c487d2..2fae682 100644
--- a/drivers/input/touchscreen/bu21013_ts.c
+++ b/drivers/input/touchscreen/bu21013_ts.c
@@ -461,7 +461,7 @@ static int __devinit bu21013_probe(struct i2c_client *client,
 	bu21013_data->chip = pdata;
 	bu21013_data->client = client;
 
-	bu21013_data->regulator = regulator_get(&client->dev, "V-TOUCH");
+	bu21013_data->regulator = regulator_get(&client->dev, "avdd");
 	if (IS_ERR(bu21013_data->regulator)) {
 		dev_err(&client->dev, "regulator_get failed\n");
 		error = PTR_ERR(bu21013_data->regulator);
-- 
1.7.9.5
