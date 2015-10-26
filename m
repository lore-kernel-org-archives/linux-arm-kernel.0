From: o.schinagl@ultimaker.com (Olliver Schinagl)
Date: Mon, 26 Oct 2015 22:32:36 +0100
Subject: [PATCH 05/10] pwm: sysfs: do not unnecessarily store result in var
In-Reply-To: <1445895161-2317-1-git-send-email-o.schinagl@ultimaker.com>
References: <1445895161-2317-1-git-send-email-o.schinagl@ultimaker.com>
Message-ID: <1445895161-2317-6-git-send-email-o.schinagl@ultimaker.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Olliver Schinagl <oliver@schinagl.nl>

Use the result of pwm_is_enabled directly instead of storing it first.

Signed-off-by: Olliver Schinagl <oliver@schinagl.nl>
---
 drivers/pwm/sysfs.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pwm/sysfs.c b/drivers/pwm/sysfs.c
index c472772..ba67845 100644
--- a/drivers/pwm/sysfs.c
+++ b/drivers/pwm/sysfs.c
@@ -97,9 +97,8 @@ static ssize_t pwm_enable_show(struct device *child,
 			       char *buf)
 {
 	const struct pwm_device *pwm = child_to_pwm_device(child);
-	int enabled = pwm_is_enabled(pwm);
 
-	return sprintf(buf, "%d\n", enabled);
+	return sprintf(buf, "%d\n", pwm_is_enabled(pwm));
 }
 
 static ssize_t pwm_enable_store(struct device *child,
-- 
2.6.1
