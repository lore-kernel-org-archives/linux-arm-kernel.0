From: sean.wang@mediatek.com (sean.wang at mediatek.com)
Date: Fri, 22 Jun 2018 11:49:04 +0800
Subject: [PATCH 1/7] pinctrl: mt7622: fix error path on failing at groups
 building
Message-ID: <f222c9f488490bd86d35346e725491e1de306ace.1529639050.git.sean.wang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sean Wang <sean.wang@mediatek.com>

It should be to return an error code when failing at groups building.

Cc: stable at vger.kernel.org
Fixes: d6ed93551320 ("pinctrl: mediatek: add pinctrl driver for MT7622 SoC")
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/pinctrl/mediatek/pinctrl-mt7622.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/mediatek/pinctrl-mt7622.c b/drivers/pinctrl/mediatek/pinctrl-mt7622.c
index e3f1ab2..9ad8cb77 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt7622.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt7622.c
@@ -1703,7 +1703,7 @@ static int mtk_pinctrl_probe(struct platform_device *pdev)
 	err = mtk_build_groups(hw);
 	if (err) {
 		dev_err(&pdev->dev, "Failed to build groups\n");
-		return 0;
+		return err;
 	}
 
 	/* Setup functions descriptions per SoC types */
-- 
2.7.4
