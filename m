From: weiyj.lk@gmail.com (Wei Yongjun)
Date: Thu, 12 Jan 2017 15:03:21 +0000
Subject: [PATCH -next] crypto: mediatek - make symbol of_crypto_id static
Message-ID: <20170112150321.4187-1-weiyj.lk@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wei Yongjun <weiyongjun1@huawei.com>

Fixes the following sparse warning:

drivers/crypto/mediatek/mtk-platform.c:585:27: warning:
 symbol 'of_crypto_id' was not declared. Should it be static?

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/crypto/mediatek/mtk-platform.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/mediatek/mtk-platform.c b/drivers/crypto/mediatek/mtk-platform.c
index 286296f..a9c713d 100644
--- a/drivers/crypto/mediatek/mtk-platform.c
+++ b/drivers/crypto/mediatek/mtk-platform.c
@@ -582,7 +582,7 @@ static int mtk_crypto_remove(struct platform_device *pdev)
 	return 0;
 }
 
-const struct of_device_id of_crypto_id[] = {
+static const struct of_device_id of_crypto_id[] = {
 	{ .compatible = "mediatek,eip97-crypto" },
 	{},
 };
