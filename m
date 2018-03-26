From: sean.wang@mediatek.com (sean.wang at mediatek.com)
Date: Mon, 26 Mar 2018 18:09:38 +0800
Subject: [PATCH 2/2] ASoC: mediatek: fix module autoloading for OF platform
 drivers
In-Reply-To: <da30b7c1ac29e1d3668a5713cd096a73a8c8dd7d.1522055433.git.sean.wang@mediatek.com>
References: <da30b7c1ac29e1d3668a5713cd096a73a8c8dd7d.1522055433.git.sean.wang@mediatek.com>
Message-ID: <7b8f10225cef6aef8c623c2c5ddc0a95bce247aa.1522055433.git.sean.wang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sean Wang <sean.wang@mediatek.com>

It's required to create a modules.alias via MODULE_DEVICE_TABLE helper
for the OF platform driver. Otherwise, module autoloading cannot work.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 sound/soc/mediatek/mt2701/mt2701-cs42448.c | 1 +
 sound/soc/mediatek/mt2701/mt2701-wm8960.c  | 1 +
 2 files changed, 2 insertions(+)

diff --git a/sound/soc/mediatek/mt2701/mt2701-cs42448.c b/sound/soc/mediatek/mt2701/mt2701-cs42448.c
index f664b9d..d37a6e1a 100644
--- a/sound/soc/mediatek/mt2701/mt2701-cs42448.c
+++ b/sound/soc/mediatek/mt2701/mt2701-cs42448.c
@@ -391,6 +391,7 @@ static const struct of_device_id mt2701_cs42448_machine_dt_match[] = {
 	{.compatible = "mediatek,mt2701-cs42448-machine",},
 	{}
 };
+MODULE_DEVICE_TABLE(of, mt2701_cs42448_machine_dt_match);
 #endif
 
 static struct platform_driver mt2701_cs42448_machine = {
diff --git a/sound/soc/mediatek/mt2701/mt2701-wm8960.c b/sound/soc/mediatek/mt2701/mt2701-wm8960.c
index a137057..cbee02e 100644
--- a/sound/soc/mediatek/mt2701/mt2701-wm8960.c
+++ b/sound/soc/mediatek/mt2701/mt2701-wm8960.c
@@ -153,6 +153,7 @@ static const struct of_device_id mt2701_wm8960_machine_dt_match[] = {
 	{.compatible = "mediatek,mt2701-wm8960-machine",},
 	{}
 };
+MODULE_DEVICE_TABLE(of, mt2701_wm8960_machine_dt_match);
 #endif
 
 static struct platform_driver mt2701_wm8960_machine = {
-- 
2.7.4
