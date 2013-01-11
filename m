From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 11 Jan 2013 13:13:06 +0000
Subject: [PATCH 18/18] power: ab8500_fg: Remove pointless round_jiffies() call
In-Reply-To: <1357909986-9262-1-git-send-email-lee.jones@linaro.org>
References: <1357909986-9262-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1357909986-9262-19-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As HZ is a full-second, there is little point in rounding it.
Let's save a few cycles by using HZ directly.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/power/ab8500_fg.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/ab8500_fg.c b/drivers/power/ab8500_fg.c
index 4bc2c2d..a22f6ce 100644
--- a/drivers/power/ab8500_fg.c
+++ b/drivers/power/ab8500_fg.c
@@ -1854,7 +1854,7 @@ static void ab8500_fg_check_hw_failure_work(struct work_struct *work)
 		}
 		/* Not yet recovered from ovv, reschedule this test */
 		queue_delayed_work(di->fg_wq, &di->fg_check_hw_failure_work,
-				   round_jiffies(HZ));
+				   HZ);
 		} else {
 			dev_dbg(di->dev, "Battery recovered from OVV\n");
 			di->flags.bat_ovv = false;
-- 
1.7.9.5
