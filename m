From: weiyj.lk@gmail.com (Wei Yongjun)
Date: Tue, 2 Jul 2013 17:26:21 +0800
Subject: [PATCH] ASoC: brownstone: add .owner to struct snd_soc_card
Message-ID: <CAPgLHd-VN4BiM=cEkFF4EgbL7iqR1XrhEzBiKyoJBVnzKspHJg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Add missing .owner of struct snd_soc_card. This prevents the
module from being removed from underneath its users.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 sound/soc/pxa/brownstone.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/pxa/brownstone.c b/sound/soc/pxa/brownstone.c
index 4ad7609..e582c05 100644
--- a/sound/soc/pxa/brownstone.c
+++ b/sound/soc/pxa/brownstone.c
@@ -129,6 +129,7 @@ static struct snd_soc_dai_link brownstone_wm8994_dai[] = {
 /* audio machine driver */
 static struct snd_soc_card brownstone = {
 	.name         = "brownstone",
+	.owner        = THIS_MODULE,
 	.dai_link     = brownstone_wm8994_dai,
 	.num_links    = ARRAY_SIZE(brownstone_wm8994_dai),
 
