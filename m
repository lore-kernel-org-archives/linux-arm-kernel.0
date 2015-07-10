From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Fri, 10 Jul 2015 15:19:48 +0900
Subject: [PATCH 7/7] [media] Drop owner assignment from i2c_driver
In-Reply-To: <1436509188-23320-1-git-send-email-k.kozlowski@samsung.com>
References: <1436509188-23320-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1436509188-23320-8-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

i2c_driver does not need to set an owner because i2c_register_driver()
will set it.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

---

The coccinelle script which generated the patch was sent here:
http://www.spinics.net/lists/kernel/msg2029903.html
---
 drivers/media/usb/go7007/s2250-board.c | 1 -
 drivers/media/v4l2-core/tuner-core.c   | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/media/usb/go7007/s2250-board.c b/drivers/media/usb/go7007/s2250-board.c
index 5c2a49534d2b..1466db150d82 100644
--- a/drivers/media/usb/go7007/s2250-board.c
+++ b/drivers/media/usb/go7007/s2250-board.c
@@ -629,7 +629,6 @@ MODULE_DEVICE_TABLE(i2c, s2250_id);
 
 static struct i2c_driver s2250_driver = {
 	.driver = {
-		.owner	= THIS_MODULE,
 		.name	= "s2250",
 	},
 	.probe		= s2250_probe,
diff --git a/drivers/media/v4l2-core/tuner-core.c b/drivers/media/v4l2-core/tuner-core.c
index abdcffabcb59..581e21ad6801 100644
--- a/drivers/media/v4l2-core/tuner-core.c
+++ b/drivers/media/v4l2-core/tuner-core.c
@@ -1366,7 +1366,6 @@ MODULE_DEVICE_TABLE(i2c, tuner_id);
 
 static struct i2c_driver tuner_driver = {
 	.driver = {
-		.owner	= THIS_MODULE,
 		.name	= "tuner",
 		.pm	= &tuner_pm_ops,
 	},
-- 
1.9.1
