From: clabbe.montjoie@gmail.com (Corentin Labbe)
Date: Fri, 19 May 2017 08:53:24 +0200
Subject: [PATCH v2 2/9] crypto: brcm - Use IPAD/OPAD constant
In-Reply-To: <20170519065331.27670-1-clabbe.montjoie@gmail.com>
References: <20170519065331.27670-1-clabbe.montjoie@gmail.com>
Message-ID: <20170519065331.27670-3-clabbe.montjoie@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch simply replace all occurrence of HMAC IPAD/OPAD value by their
define.

Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
---
 drivers/crypto/bcm/cipher.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/bcm/cipher.c b/drivers/crypto/bcm/cipher.c
index cc0d5b98006e..61393dc70b0b 100644
--- a/drivers/crypto/bcm/cipher.c
+++ b/drivers/crypto/bcm/cipher.c
@@ -36,6 +36,7 @@
 #include <crypto/internal/aead.h>
 #include <crypto/aes.h>
 #include <crypto/des.h>
+#include <crypto/hmac.h>
 #include <crypto/sha.h>
 #include <crypto/md5.h>
 #include <crypto/authenc.h>
@@ -2510,8 +2511,8 @@ static int ahash_hmac_setkey(struct crypto_ahash *ahash, const u8 *key,
 		memcpy(ctx->opad, ctx->ipad, blocksize);
 
 		for (index = 0; index < blocksize; index++) {
-			ctx->ipad[index] ^= 0x36;
-			ctx->opad[index] ^= 0x5c;
+			ctx->ipad[index] ^= HMAC_IPAD_VALUE;
+			ctx->opad[index] ^= HMAC_OPAD_VALUE;
 		}
 
 		flow_dump("  ipad: ", ctx->ipad, blocksize);
-- 
2.13.0
