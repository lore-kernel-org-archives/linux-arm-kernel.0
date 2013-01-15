From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 15 Jan 2013 14:09:13 +0000
Subject: [PATCH 04/18] power: ab8500_fg: Replace msleep() with
 usleep_range() for greater accuracy
In-Reply-To: <1357909986-9262-5-git-send-email-lee.jones@linaro.org>
References: <1357909986-9262-1-git-send-email-lee.jones@linaro.org>
 <1357909986-9262-5-git-send-email-lee.jones@linaro.org>
Message-ID: <20130115140913.GC9379@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jonas Aaberg <jonas.aberg@stericsson.com>

Doing so provides a greater degree of accuracy when dealing with
time-frames between 1us and 20ms. msleep() is only accurate for
wake-ups greater than 20ms.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Jonas ABERG <jonas.aberg@stericsson.com>
Reviewed-by: Johan BJORNSTEDT <johan.bjornstedt@stericsson.com>
---
 drivers/power/ab8500_fg.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/ab8500_fg.c b/drivers/power/ab8500_fg.c
index 828529e..78124587 100644
--- a/drivers/power/ab8500_fg.c
+++ b/drivers/power/ab8500_fg.c
@@ -956,7 +956,7 @@ static int ab8500_fg_load_comp_volt_to_capacity(struct ab8500_fg *di)
 	do {
 		vbat += ab8500_fg_bat_voltage(di);
 		i++;
-		msleep(5);
+		usleep_range(5000, 6000);
 	} while (!ab8500_fg_inst_curr_done(di));
 
 	ab8500_fg_inst_curr_finalize(di, &di->inst_curr);
-- 
1.7.9.5
