From: peter.chen@freescale.com (Peter Chen)
Date: Mon, 28 Oct 2013 14:01:16 +0800
Subject: [PATCH 1/1] pinctrl: imx: fix using pin->input_val wrongly
Message-ID: <1382940076-11898-1-git-send-email-peter.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The commit: "pinctrl: imx: Use struct type for pins" relaced
pin->input_reg by pin->input_val wrongly, fix it at this commit.

Signed-off-by: Peter Chen <peter.chen@freescale.com>
---
 drivers/pinctrl/pinctrl-imx.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-imx.c b/drivers/pinctrl/pinctrl-imx.c
index d78dd81..4779b8e 100644
--- a/drivers/pinctrl/pinctrl-imx.c
+++ b/drivers/pinctrl/pinctrl-imx.c
@@ -245,11 +245,11 @@ static int imx_pmx_enable(struct pinctrl_dev *pctldev, unsigned selector,
 			 * The input_reg[i] here is actually some IOMUXC general
 			 * purpose register, not regular select input register.
 			 */
-			val = readl(ipctl->base + pin->input_val);
+			val = readl(ipctl->base + pin->input_reg);
 			val &= ~mask;
 			val |= select << shift;
-			writel(val, ipctl->base + pin->input_val);
-		} else if (pin->input_val) {
+			writel(val, ipctl->base + pin->input_reg);
+		} else if (pin->input_reg) {
 			/*
 			 * Regular select input register can never be at offset
 			 * 0, and we only print register value for regular case.
-- 
1.7.1
