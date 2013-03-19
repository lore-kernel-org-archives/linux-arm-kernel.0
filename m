From: simon.guinot@sequanux.org (Simon Guinot)
Date: Tue, 19 Mar 2013 20:07:42 +0100
Subject: [PATCH] pinctrl: mvebu: fix checking for SoC specific controls
Message-ID: <1363720062-21395-1-git-send-email-simon.guinot@sequanux.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes a minor bug (probably due to a typo) while checking
the SoC specific controls in mvebu_pinctrl_probe().

Signed-off-by: Simon Guinot <simon.guinot@sequanux.org>
---
 drivers/pinctrl/mvebu/pinctrl-mvebu.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/mvebu/pinctrl-mvebu.c b/drivers/pinctrl/mvebu/pinctrl-mvebu.c
index c689c04..2d2f0a4 100644
--- a/drivers/pinctrl/mvebu/pinctrl-mvebu.c
+++ b/drivers/pinctrl/mvebu/pinctrl-mvebu.c
@@ -620,7 +620,7 @@ int mvebu_pinctrl_probe(struct platform_device *pdev)
 
 		/* special soc specific control */
 		if (ctrl->mpp_get || ctrl->mpp_set) {
-			if (!ctrl->name || !ctrl->mpp_set || !ctrl->mpp_set) {
+			if (!ctrl->name || !ctrl->mpp_get || !ctrl->mpp_set) {
 				dev_err(&pdev->dev, "wrong soc control info\n");
 				return -EINVAL;
 			}
-- 
1.7.10.4
