From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Mon, 18 Jun 2012 15:41:47 +0200
Subject: [PATCH] pinctrl: pinctrl-mxs: mxs_dt_node_to_map: fix typo free ->
 kfree
Message-ID: <1340026907-13606-1-git-send-email-mkl@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In commit:
0bf7481 pinctrl: pinctrl-mxs: Take care of frees if the kzalloc fails
the memory allocated with kzalloc is tried to free with "free", which
is not defined in the kernel, use "kfree" instead.

Cc: Devendra Naga <devendra.aaru@gmail.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
This problem exists with current linus/master (v3.5-rc3-81-gd2a1a6b).
I haven't chekced if it has been fixed somewhere upstream.

regards, Marc

 drivers/pinctrl/pinctrl-mxs.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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
1.7.10
