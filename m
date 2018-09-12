From: zhongjiang@huawei.com (zhong jiang)
Date: Wed, 12 Sep 2018 11:41:49 +0800
Subject: [PATCH] ASoC: remove unneeded static set .owner field in
 platform_driver
Message-ID: <1536723709-51009-1-git-send-email-zhongjiang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

platform_driver_register will set the .owner field. So it is safe
to remove the redundant assignment.

The issue is detected with the help of Coccinelle.

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 sound/soc/mediatek/mt2701/mt2701-wm8960.c | 1 -
 sound/soc/mediatek/mt6797/mt6797-mt6351.c | 1 -
 sound/soc/rockchip/rk3288_hdmi_analog.c   | 1 -
 3 files changed, 3 deletions(-)

diff --git a/sound/soc/mediatek/mt2701/mt2701-wm8960.c b/sound/soc/mediatek/mt2701/mt2701-wm8960.c
index 89f34ef..e5d49e6 100644
--- a/sound/soc/mediatek/mt2701/mt2701-wm8960.c
+++ b/sound/soc/mediatek/mt2701/mt2701-wm8960.c
@@ -150,7 +150,6 @@ static int mt2701_wm8960_machine_probe(struct platform_device *pdev)
 static struct platform_driver mt2701_wm8960_machine = {
 	.driver = {
 		.name = "mt2701-wm8960",
-		.owner = THIS_MODULE,
 #ifdef CONFIG_OF
 		.of_match_table = mt2701_wm8960_machine_dt_match,
 #endif
diff --git a/sound/soc/mediatek/mt6797/mt6797-mt6351.c b/sound/soc/mediatek/mt6797/mt6797-mt6351.c
index b1558c5..6e578e8 100644
--- a/sound/soc/mediatek/mt6797/mt6797-mt6351.c
+++ b/sound/soc/mediatek/mt6797/mt6797-mt6351.c
@@ -205,7 +205,6 @@ static int mt6797_mt6351_dev_probe(struct platform_device *pdev)
 static struct platform_driver mt6797_mt6351_driver = {
 	.driver = {
 		.name = "mt6797-mt6351",
-		.owner = THIS_MODULE,
 #ifdef CONFIG_OF
 		.of_match_table = mt6797_mt6351_dt_match,
 #endif
diff --git a/sound/soc/rockchip/rk3288_hdmi_analog.c b/sound/soc/rockchip/rk3288_hdmi_analog.c
index 929b3fe..a472d5e 100644
--- a/sound/soc/rockchip/rk3288_hdmi_analog.c
+++ b/sound/soc/rockchip/rk3288_hdmi_analog.c
@@ -286,7 +286,6 @@ static int snd_rk_mc_probe(struct platform_device *pdev)
 	.probe = snd_rk_mc_probe,
 	.driver = {
 		.name = DRV_NAME,
-		.owner = THIS_MODULE,
 		.pm = &snd_soc_pm_ops,
 		.of_match_table = rockchip_sound_of_match,
 	},
-- 
1.7.12.4
