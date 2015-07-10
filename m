From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Fri, 10 Jul 2015 15:19:46 +0900
Subject: [PATCH 5/7] [media] radio: Drop owner assignment from i2c_driver
In-Reply-To: <1436509188-23320-1-git-send-email-k.kozlowski@samsung.com>
References: <1436509188-23320-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1436509188-23320-6-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

i2c_driver does not need to set an owner because i2c_register_driver()
will set it.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

---

The coccinelle script which generated the patch was sent here:
http://www.spinics.net/lists/kernel/msg2029903.html
---
 drivers/media/radio/radio-tea5764.c | 1 -
 drivers/media/radio/saa7706h.c      | 1 -
 drivers/media/radio/tef6862.c       | 1 -
 3 files changed, 3 deletions(-)

diff --git a/drivers/media/radio/radio-tea5764.c b/drivers/media/radio/radio-tea5764.c
index cc3990111411..a1930b300c06 100644
--- a/drivers/media/radio/radio-tea5764.c
+++ b/drivers/media/radio/radio-tea5764.c
@@ -526,7 +526,6 @@ MODULE_DEVICE_TABLE(i2c, tea5764_id);
 static struct i2c_driver tea5764_i2c_driver = {
 	.driver = {
 		.name = "radio-tea5764",
-		.owner = THIS_MODULE,
 	},
 	.probe = tea5764_i2c_probe,
 	.remove = tea5764_i2c_remove,
diff --git a/drivers/media/radio/saa7706h.c b/drivers/media/radio/saa7706h.c
index ec805b09c608..53a5de1af9b4 100644
--- a/drivers/media/radio/saa7706h.c
+++ b/drivers/media/radio/saa7706h.c
@@ -429,7 +429,6 @@ MODULE_DEVICE_TABLE(i2c, saa7706h_id);
 
 static struct i2c_driver saa7706h_driver = {
 	.driver = {
-		.owner	= THIS_MODULE,
 		.name	= DRIVER_NAME,
 	},
 	.probe		= saa7706h_probe,
diff --git a/drivers/media/radio/tef6862.c b/drivers/media/radio/tef6862.c
index a9319a24c7ef..9f879f0ec0ef 100644
--- a/drivers/media/radio/tef6862.c
+++ b/drivers/media/radio/tef6862.c
@@ -195,7 +195,6 @@ MODULE_DEVICE_TABLE(i2c, tef6862_id);
 
 static struct i2c_driver tef6862_driver = {
 	.driver = {
-		.owner	= THIS_MODULE,
 		.name	= DRIVER_NAME,
 	},
 	.probe		= tef6862_probe,
-- 
1.9.1
