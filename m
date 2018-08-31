From: yuehaibing@huawei.com (YueHaibing)
Date: Fri, 31 Aug 2018 02:09:06 +0000
Subject: [PATCH -next] pinctrl: sirf: atlas7: remove set but not used
 variables 'conf, bank'
Message-ID: <1535681346-152447-1-git-send-email-yuehaibing@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/pinctrl/sirf/pinctrl-atlas7.c: In function 'atlas7_pinmux_resume_noirq':
drivers/pinctrl/sirf/pinctrl-atlas7.c:5545:6: warning:
 variable 'bank' set but not used [-Wunused-but-set-variable]
  u32 bank;

drivers/pinctrl/sirf/pinctrl-atlas7.c:5543:28: warning:
 variable 'conf' set but not used [-Wunused-but-set-variable]
  struct atlas7_pad_config *conf;

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/pinctrl/sirf/pinctrl-atlas7.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/pinctrl/sirf/pinctrl-atlas7.c b/drivers/pinctrl/sirf/pinctrl-atlas7.c
index 1d16df1..ee1063f 100644
--- a/drivers/pinctrl/sirf/pinctrl-atlas7.c
+++ b/drivers/pinctrl/sirf/pinctrl-atlas7.c
@@ -5540,14 +5540,10 @@ static int atlas7_pinmux_resume_noirq(struct device *dev)
 {
 	struct atlas7_pmx *pmx = dev_get_drvdata(dev);
 	struct atlas7_pad_status *status;
-	struct atlas7_pad_config *conf;
 	int idx;
-	u32 bank;
 
 	for (idx = 0; idx < pmx->pctl_desc.npins; idx++) {
 		/* Get this Pad's descriptor from PINCTRL */
-		conf = &pmx->pctl_data->confs[idx];
-		bank = atlas7_pin_to_bank(idx);
 		status = &pmx->sleep_data[idx];
 
 		/* Restore Function selector */
