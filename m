From: plaes@plaes.org (Priit Laes)
Date: Sun, 27 Aug 2017 15:55:23 +0300
Subject: [PATCH] Revert "pinctrl: sunxi: Don't enforce bias disable (for now)"
Message-ID: <20170827125523.29208-1-plaes@plaes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This reverts commit 2154d94b40ea2a5de05245521371d0461bb0d669.

The original patch was intented to avoid some issues with the sunxi
gpio rework and was supposed to be reverted after all the required
DT bits had been merged around v4.10.

Signed-off-by: Priit Laes <plaes@plaes.org>
---
 drivers/pinctrl/sunxi/pinctrl-sunxi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.c b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
index 0dfd7fa66c48..52edf3b5988d 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sunxi.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
@@ -564,7 +564,8 @@ static int sunxi_pconf_group_set(struct pinctrl_dev *pctldev,
 			val = arg / 10 - 1;
 			break;
 		case PIN_CONFIG_BIAS_DISABLE:
-			continue;
+			val = 0;
+			break;
 		case PIN_CONFIG_BIAS_PULL_UP:
 			if (arg == 0)
 				return -EINVAL;
-- 
2.13.5
