From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Tue, 25 Oct 2011 00:11:56 +0800
Subject: [PATCH 1/1] pinctrl/sirf: fix sirfsoc_get_group_pins prototype
	introduce in 7e570f97
Message-ID: <1319472717-20159-1-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Stephen Warren <swarren@nvidia.com>
---
 drivers/pinctrl/pinmux-sirf.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/pinctrl/pinmux-sirf.c b/drivers/pinctrl/pinmux-sirf.c
index ba73523..d76cae6 100644
--- a/drivers/pinctrl/pinmux-sirf.c
+++ b/drivers/pinctrl/pinmux-sirf.c
@@ -870,7 +870,7 @@ static const char *sirfsoc_get_group_name(struct pinctrl_dev *pctldev,
 
 static int sirfsoc_get_group_pins(struct pinctrl_dev *pctldev, unsigned selector,
 			       const unsigned **pins,
-			       const unsigned *num_pins)
+			       unsigned *num_pins)
 {
 	if (selector >= ARRAY_SIZE(sirfsoc_pin_groups))
 		return -EINVAL;
-- 
1.7.7
