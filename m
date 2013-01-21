From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 21 Jan 2013 12:03:46 +0000
Subject: [PATCH 10/24] ab8500-chargalg: Only root should have write permission
 on sysfs file
In-Reply-To: <1358769840-4763-1-git-send-email-lee.jones@linaro.org>
References: <1358769840-4763-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1358769840-4763-11-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Only root should have write permission on sysfs file ab8500_chargalg/chargalg.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/power/abx500_chargalg.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/abx500_chargalg.c b/drivers/power/abx500_chargalg.c
index 2463fa0..f59bc02 100644
--- a/drivers/power/abx500_chargalg.c
+++ b/drivers/power/abx500_chargalg.c
@@ -1711,7 +1711,7 @@ static ssize_t abx500_chargalg_sysfs_charger(struct kobject *kobj,
 static struct attribute abx500_chargalg_en_charger = \
 {
 	.name = "chargalg",
-	.mode = S_IWUGO,
+	.mode = S_IWUSR,
 };
 
 static struct attribute *abx500_chargalg_chg[] = {
-- 
1.7.9.5
