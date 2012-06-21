From: b29396@freescale.com (Dong Aisheng)
Date: Thu, 21 Jun 2012 18:10:35 +0800
Subject: [PATCH] pinctrl: pinctrl-imx: only print debug message when DEBUG is
 defined
Message-ID: <1340273435-7530-1-git-send-email-b29396@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dong Aisheng <dong.aisheng@linaro.org>

Fix regression for commit 3a86a5f8 (pinctrl: pinctrl-imx: free allocated
pinctrl_map structure only once and use kernel facilities for IMX_PMX_DUMP)
introduced in 3.5-rc3.
With above commit, the debug code will alway be excuted.
Change to excute it only when DEBUG is defined.

Signed-off-by: Dong Aisheng <dong.aisheng@linaro.org>
---
Hopefully it can catch 3.5.
---
 drivers/pinctrl/pinctrl-imx.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-imx.c b/drivers/pinctrl/pinctrl-imx.c
index dd6d93a..90c837f 100644
--- a/drivers/pinctrl/pinctrl-imx.c
+++ b/drivers/pinctrl/pinctrl-imx.c
@@ -474,7 +474,9 @@ static int __devinit imx_pinctrl_parse_groups(struct device_node *np,
 		grp->configs[j] = config & ~IMX_PAD_SION;
 	}
 
+#ifdef DEBUG
 	IMX_PMX_DUMP(info, grp->pins, grp->mux_mode, grp->configs, grp->npins);
+#endif
 
 	return 0;
 }
-- 
1.7.0.4
