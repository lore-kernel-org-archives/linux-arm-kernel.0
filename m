From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 22 Jul 2014 12:11:22 +0100
Subject: [PATCH 16/19] mfd: si476x-cmd: Remedy checkpatch style complains
In-Reply-To: <1406027485-15657-1-git-send-email-lee.jones@linaro.org>
References: <1406027485-15657-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1406027485-15657-17-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is part of an effort to clean-up the MFD subsystem.

WARNING: line over 80 characters
+                        struct si476x_rsq_status_args *rsqargs,

WARNING: line over 80 characters
+                        struct si476x_rsq_status_report *report)

WARNING: Unnecessary space before function pointer arguments
+       int (*power_up) (struct si476x_core *,

WARNING: Unnecessary space before function pointer arguments
+       int (*power_down) (struct si476x_core *,

total: 0 errors, 4 warnings, 1555 lines checked

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/si476x-cmd.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/mfd/si476x-cmd.c b/drivers/mfd/si476x-cmd.c
index 6f1ef63..2086b46 100644
--- a/drivers/mfd/si476x-cmd.c
+++ b/drivers/mfd/si476x-cmd.c
@@ -1228,8 +1228,8 @@ static int si476x_core_cmd_fm_rsq_status_a10(struct si476x_core *core,
 }
 
 static int si476x_core_cmd_fm_rsq_status_a20(struct si476x_core *core,
-					     struct si476x_rsq_status_args *rsqargs,
-					     struct si476x_rsq_status_report *report)
+				     struct si476x_rsq_status_args *rsqargs,
+				     struct si476x_rsq_status_report *report)
 {
 	int err;
 	u8       resp[CMD_FM_RSQ_STATUS_A10_NRESP];
@@ -1434,10 +1434,10 @@ typedef int (*tune_freq_func_t) (struct si476x_core *core,
 				 struct si476x_tune_freq_args *tuneargs);
 
 static struct {
-	int (*power_up) (struct si476x_core *,
-			 struct si476x_power_up_args *);
-	int (*power_down) (struct si476x_core *,
-			   struct si476x_power_down_args *);
+	int (*power_up)(struct si476x_core *,
+			struct si476x_power_up_args *);
+	int (*power_down)(struct si476x_core *,
+			  struct si476x_power_down_args *);
 
 	tune_freq_func_t fm_tune_freq;
 	tune_freq_func_t am_tune_freq;
-- 
1.8.3.2
