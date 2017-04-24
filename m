From: clabbe.montjoie@gmail.com (Corentin Labbe)
Date: Mon, 24 Apr 2017 16:16:28 +0200
Subject: [PATCH 8/9] crypto: mediatek - Use IPAD/OPAD constant
In-Reply-To: <20170424141629.27155-1-clabbe.montjoie@gmail.com>
References: <20170424141629.27155-1-clabbe.montjoie@gmail.com>
Message-ID: <20170424141629.27155-8-clabbe.montjoie@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch simply replace all occurrence of HMAC IPAD/OPAD value by their
define.

Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
---
 drivers/crypto/mediatek/mtk-sha.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/mediatek/mtk-sha.c b/drivers/crypto/mediatek/mtk-sha.c
index 2226f12..cbcb522 100644
--- a/drivers/crypto/mediatek/mtk-sha.c
+++ b/drivers/crypto/mediatek/mtk-sha.c
@@ -825,8 +825,8 @@ static int mtk_sha_setkey(struct crypto_ahash *tfm, const u8 *key,
 	memcpy(bctx->opad, bctx->ipad, bs);
 
 	for (i = 0; i < bs; i++) {
-		bctx->ipad[i] ^= 0x36;
-		bctx->opad[i] ^= 0x5c;
+		bctx->ipad[i] ^= HMAC_IPAD_VALUE;
+		bctx->opad[i] ^= HMAC_OPAD_VALUE;
 	}
 
 	return 0;
-- 
2.10.2
