From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Fri, 10 Jul 2015 19:37:32 +0900
Subject: [PATCH v2 1/2] drm/bridge: Drop owner assignment from i2c_driver
In-Reply-To: <1436524653-29132-1-git-send-email-k.kozlowski@samsung.com>
References: <1436524653-29132-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1436524653-29132-2-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

i2c_driver does not need to set an owner because i2c_register_driver()
will set it.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

---

The coccinelle script which generated the patch was sent here:
http://www.spinics.net/lists/kernel/msg2029903.html

Changes since v1:
1. Split owner removal from rockchip to separate patch (spotted by Mark
   Yao).
---
 drivers/gpu/drm/bridge/ps8622.c  | 1 -
 drivers/gpu/drm/bridge/ptn3460.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ps8622.c b/drivers/gpu/drm/bridge/ps8622.c
index 1a6607beb29f..be881e9fef8f 100644
--- a/drivers/gpu/drm/bridge/ps8622.c
+++ b/drivers/gpu/drm/bridge/ps8622.c
@@ -668,7 +668,6 @@ static struct i2c_driver ps8622_driver = {
 	.remove		= ps8622_remove,
 	.driver		= {
 		.name	= "ps8622",
-		.owner	= THIS_MODULE,
 		.of_match_table = ps8622_devices,
 	},
 };
diff --git a/drivers/gpu/drm/bridge/ptn3460.c b/drivers/gpu/drm/bridge/ptn3460.c
index 1b1bf2384815..0ffa3a6a206a 100644
--- a/drivers/gpu/drm/bridge/ptn3460.c
+++ b/drivers/gpu/drm/bridge/ptn3460.c
@@ -400,7 +400,6 @@ static struct i2c_driver ptn3460_driver = {
 	.remove		= ptn3460_remove,
 	.driver		= {
 		.name	= "nxp,ptn3460",
-		.owner	= THIS_MODULE,
 		.of_match_table = ptn3460_match,
 	},
 };
-- 
1.9.1
