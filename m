From: eric@anholt.net (Eric Anholt)
Date: Mon, 29 Feb 2016 17:30:08 -0800
Subject: [PATCH] pinctrl-bcm2835: Fix cut-and-paste error in "pull" parsing
Message-ID: <1456795808-1449-1-git-send-email-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Phil Elwell <phil@raspberrypi.org>

The DT bindings for pinctrl-bcm2835 allow both the function and pull
to contain either one entry or one per pin. However, an error in the
DT parsing can cause failures if the number of pulls differs from the
number of functions.

Signed-off-by: Eric Anholt <eric@anholt.net>
Cc: stable at vger.kernel.org
---

Yes, the s-o-b differs from the author of the commit, but this falls
under part b) of the process.

Phil, any chance you could start putting Signed-off-by lines on your
kernel commits?

 drivers/pinctrl/bcm/pinctrl-bcm2835.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/bcm/pinctrl-bcm2835.c b/drivers/pinctrl/bcm/pinctrl-bcm2835.c
index 0f5997c..08b1d93 100644
--- a/drivers/pinctrl/bcm/pinctrl-bcm2835.c
+++ b/drivers/pinctrl/bcm/pinctrl-bcm2835.c
@@ -779,7 +779,7 @@ static int bcm2835_pctl_dt_node_to_map(struct pinctrl_dev *pctldev,
 		}
 		if (num_pulls) {
 			err = of_property_read_u32_index(np, "brcm,pull",
-					(num_funcs > 1) ? i : 0, &pull);
+					(num_pulls > 1) ? i : 0, &pull);
 			if (err)
 				goto out;
 			err = bcm2835_pctl_dt_node_to_map_pull(pc, np, pin,
-- 
2.7.0
