From: weiyj.lk@gmail.com (Wei Yongjun)
Date: Tue, 2 Jul 2013 17:26:40 +0800
Subject: [PATCH] ASoC: ttc_dkb: add .owner to struct snd_soc_card
Message-ID: <CAPgLHd_CJUYf8Ry=J9Y8ZPSrCgqPLTj74rDr__bxoymQ8GR_1A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Add missing .owner of struct snd_soc_card. This prevents the
module from being removed from underneath its users.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 sound/soc/pxa/ttc-dkb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/pxa/ttc-dkb.c b/sound/soc/pxa/ttc-dkb.c
index f4ea4f6..13c9ee0 100644
--- a/sound/soc/pxa/ttc-dkb.c
+++ b/sound/soc/pxa/ttc-dkb.c
@@ -122,6 +122,7 @@ static struct snd_soc_dai_link ttc_pm860x_hifi_dai[] = {
 /* ttc/td audio machine driver */
 static struct snd_soc_card ttc_dkb_card = {
 	.name = "ttc-dkb-hifi",
+	.owner = THIS_MODULE,
 	.dai_link = ttc_pm860x_hifi_dai,
 	.num_links = ARRAY_SIZE(ttc_pm860x_hifi_dai),
 
