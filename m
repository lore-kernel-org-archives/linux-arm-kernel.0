From: weiyongjun1@huawei.com (Wei Yongjun)
Date: Sat, 27 Oct 2018 02:19:59 +0000
Subject: [PATCH] ASoC: stm32: sai: fix invalid use of sizeof in
 stm32_sai_add_mclk_provider()
Message-ID: <1540606799-164510-1-git-send-email-weiyongjun1@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

sizeof() when applied to a pointer typed expression gives the
size of the pointer, not that of the pointed data.

Fixes: 8307b2afd386 ("ASoC: stm32: sai: set sai as mclk clock provider")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 sound/soc/stm/stm32_sai_sub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/stm/stm32_sai_sub.c b/sound/soc/stm/stm32_sai_sub.c
index ea05cc9..211589b 100644
--- a/sound/soc/stm/stm32_sai_sub.c
+++ b/sound/soc/stm/stm32_sai_sub.c
@@ -390,7 +390,7 @@ static int stm32_sai_add_mclk_provider(struct stm32_sai_sub_data *sai)
 	char *mclk_name, *p, *s = (char *)pname;
 	int ret, i = 0;
 
-	mclk = devm_kzalloc(dev, sizeof(mclk), GFP_KERNEL);
+	mclk = devm_kzalloc(dev, sizeof(*mclk), GFP_KERNEL);
 	if (!mclk)
 		return -ENOMEM;
