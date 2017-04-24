From: clabbe.montjoie@gmail.com (Corentin Labbe)
Date: Mon, 24 Apr 2017 16:16:22 +0200
Subject: [PATCH 2/9] crypto: brcm - Use IPAD/OPAD constant
In-Reply-To: <20170424141629.27155-1-clabbe.montjoie@gmail.com>
References: <20170424141629.27155-1-clabbe.montjoie@gmail.com>
Message-ID: <20170424141629.27155-2-clabbe.montjoie@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch simply replace all occurrence of HMAC IPAD/OPAD value by their
define.

Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
---
 drivers/crypto/bcm/cipher.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/bcm/cipher.c b/drivers/crypto/bcm/cipher.c
index cc0d5b9..304c7ed 100644
--- a/drivers/crypto/bcm/cipher.c
+++ b/drivers/crypto/bcm/cipher.c
@@ -2510,8 +2510,8 @@ static int ahash_hmac_setkey(struct crypto_ahash *ahash, const u8 *key,
 		memcpy(ctx->opad, ctx->ipad, blocksize);
 
 		for (index = 0; index < blocksize; index++) {
-			ctx->ipad[index] ^= 0x36;
-			ctx->opad[index] ^= 0x5c;
+			ctx->ipad[index] ^= HMAC_IPAD_VALUE;
+			ctx->opad[index] ^= HMAC_OPAD_VALUE;
 		}
 
 		flow_dump("  ipad: ", ctx->ipad, blocksize);
-- 
2.10.2
