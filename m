From: b29396@freescale.com (Dong Aisheng)
Date: Wed, 20 Jun 2012 12:48:37 +0800
Subject: [PATCH 1/1] pinctrl: pinctrl-mxs: fix a compiling error
Message-ID: <1340167717-13082-1-git-send-email-b29396@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dong Aisheng <dong.aisheng@linaro.org>

The compiling error is:
drivers/pinctrl/pinctrl-mxs.c: In function 'mxs_dt_node_to_map':
drivers/pinctrl/pinctrl-mxs.c:140: error: implicit declaration of function 'free'
drivers/pinctrl/pinctrl-mxs.c:140: warning: incompatible implicit declaration of built-in function 'free'
It should be kfree.

Signed-off-by: Dong Aisheng <dong.aisheng@linaro.org>
---
 drivers/pinctrl/pinctrl-mxs.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-mxs.c b/drivers/pinctrl/pinctrl-mxs.c
index afb50ee..4ba4636 100644
--- a/drivers/pinctrl/pinctrl-mxs.c
+++ b/drivers/pinctrl/pinctrl-mxs.c
@@ -137,7 +137,7 @@ static int mxs_dt_node_to_map(struct pinctrl_dev *pctldev,
 
 free_group:
 	if (!purecfg)
-		free(group);
+		kfree(group);
 free:
 	kfree(new_map);
 	return ret;
-- 
1.7.0.4
