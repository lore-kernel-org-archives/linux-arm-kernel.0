From: minghsiu.tsai@mediatek.com (Minghsiu Tsai)
Date: Mon, 19 Sep 2016 14:34:43 +0800
Subject: [PATCH 2/2] media: mtk-mdp: fix build error
In-Reply-To: <1474266883-51155-1-git-send-email-minghsiu.tsai@mediatek.com>
References: <1474266883-51155-1-git-send-email-minghsiu.tsai@mediatek.com>
Message-ID: <1474266883-51155-3-git-send-email-minghsiu.tsai@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fix build error without CONFIG_PM_RUNTIME
and CONFIG_PM_SLEEP

Signed-off-by: Minghsiu Tsai <minghsiu.tsai@mediatek.com>
---
 drivers/media/platform/mtk-mdp/mtk_mdp_core.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/mtk-mdp/mtk_mdp_core.c b/drivers/media/platform/mtk-mdp/mtk_mdp_core.c
index b0c421e..f4424064 100644
--- a/drivers/media/platform/mtk-mdp/mtk_mdp_core.c
+++ b/drivers/media/platform/mtk-mdp/mtk_mdp_core.c
@@ -233,7 +233,7 @@ static int mtk_mdp_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#if defined(CONFIG_PM_RUNTIME) || defined(CONFIG_PM_SLEEP)
+#ifdef CONFIG_PM
 static int mtk_mdp_pm_suspend(struct device *dev)
 {
 	struct mtk_mdp_dev *mdp = dev_get_drvdata(dev);
@@ -251,7 +251,7 @@ static int mtk_mdp_pm_resume(struct device *dev)
 
 	return 0;
 }
-#endif /* CONFIG_PM_RUNTIME || CONFIG_PM_SLEEP */
+#endif /* CONFIG_PM */
 
 #ifdef CONFIG_PM_SLEEP
 static int mtk_mdp_suspend(struct device *dev)
-- 
1.7.9.5
