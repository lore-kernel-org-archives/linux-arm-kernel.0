From: eric@eukrea.com (=?UTF-8?q?Eric=20B=C3=A9nard?=)
Date: Sun, 29 Apr 2012 21:02:29 +0200
Subject: [PATCH 2/3] pwm-core: fix error handling in pwmchip_add
In-Reply-To: <1335726150-22600-1-git-send-email-eric@eukrea.com>
References: <1335726150-22600-1-git-send-email-eric@eukrea.com>
Message-ID: <1335726150-22600-2-git-send-email-eric@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* this patch fix error handling in pwmchip_add

Signed-off-by: Eric B?nard <eric@eukrea.com>
---
 drivers/pwm/core.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 47e6262..b3a99a6 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -216,8 +216,10 @@ int pwmchip_add(struct pwm_chip *chip)
 		goto out;
 
 	chip->pwms = kzalloc(chip->npwm * sizeof(*pwm), GFP_KERNEL);
-	if (!chip->pwms)
-		return -ENOMEM;
+	if (!chip->pwms) {
+		ret = -ENOMEM;
+		goto out;
+	}
 
 	chip->base = ret;
 
-- 
1.7.7.6
