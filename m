From: darshanapadmadas@gmail.com (Darshana Padmadas)
Date: Tue,  7 Oct 2014 20:49:28 +0530
Subject: [PATCH v4 3/4] Staging: iio: light: Added correct vendor-prefix for
 device isl29028
In-Reply-To: <1412695169-22815-1-git-send-email-darshanapadmadas@gmail.com>
References: <1412695169-22815-1-git-send-email-darshanapadmadas@gmail.com>
Message-ID: <1412695169-22815-4-git-send-email-darshanapadmadas@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the correct vendor-prefix for device isl29028 and
maintains deprecated vendor-prefix found by checkpatch warning
for older kernel releases.

Signed-off-by: Darshana Padmadas <darshanapadmadas@gmail.com>
---
 drivers/staging/iio/light/isl29028.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/iio/light/isl29028.c b/drivers/staging/iio/light/isl29028.c
index 6014625..e969107 100644
--- a/drivers/staging/iio/light/isl29028.c
+++ b/drivers/staging/iio/light/isl29028.c
@@ -537,7 +537,8 @@ static const struct i2c_device_id isl29028_id[] = {
 MODULE_DEVICE_TABLE(i2c, isl29028_id);
 
 static const struct of_device_id isl29028_of_match[] = {
-	{ .compatible = "isil,isl29028", },
+	{ .compatible = "isl,isl29028", },
+	{ .compatible = "isil,isl29028", },/* deprecated, don't use */
 	{ },
 };
 MODULE_DEVICE_TABLE(of, isl29028_of_match);
-- 
1.9.1
