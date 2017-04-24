From: clabbe.montjoie@gmail.com (Corentin Labbe)
Date: Mon, 24 Apr 2017 16:16:26 +0200
Subject: [PATCH 6/9] crypto: omap-sham - Use IPAD/OPAD constant
In-Reply-To: <20170424141629.27155-1-clabbe.montjoie@gmail.com>
References: <20170424141629.27155-1-clabbe.montjoie@gmail.com>
Message-ID: <20170424141629.27155-6-clabbe.montjoie@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch simply replace all occurrence of HMAC IPAD/OPAD value by their
define.

Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
---
 drivers/crypto/omap-sham.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/omap-sham.c b/drivers/crypto/omap-sham.c
index d0b16e5..11e11a6 100644
--- a/drivers/crypto/omap-sham.c
+++ b/drivers/crypto/omap-sham.c
@@ -1326,8 +1326,8 @@ static int omap_sham_setkey(struct crypto_ahash *tfm, const u8 *key,
 		memcpy(bctx->opad, bctx->ipad, bs);
 
 		for (i = 0; i < bs; i++) {
-			bctx->ipad[i] ^= 0x36;
-			bctx->opad[i] ^= 0x5c;
+			bctx->ipad[i] ^= HMAC_IPAD_VALUE;
+			bctx->opad[i] ^= HMAC_OPAD_VALUE;
 		}
 	}
 
-- 
2.10.2
