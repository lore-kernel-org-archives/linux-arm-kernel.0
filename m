From: clabbe.montjoie@gmail.com (Corentin Labbe)
Date: Mon, 24 Apr 2017 16:16:25 +0200
Subject: [PATCH 5/9] crypto: mv_cesa - Use IPAD/OPAD constant
In-Reply-To: <20170424141629.27155-1-clabbe.montjoie@gmail.com>
References: <20170424141629.27155-1-clabbe.montjoie@gmail.com>
Message-ID: <20170424141629.27155-5-clabbe.montjoie@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch simply replace all occurrence of HMAC IPAD/OPAD value by their
define.

Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
---
 drivers/crypto/mv_cesa.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/mv_cesa.c b/drivers/crypto/mv_cesa.c
index 451fa18..41ae190 100644
--- a/drivers/crypto/mv_cesa.c
+++ b/drivers/crypto/mv_cesa.c
@@ -822,8 +822,8 @@ static int mv_hash_setkey(struct crypto_ahash *tfm, const u8 * key,
 		memcpy(opad, ipad, bs);
 
 		for (i = 0; i < bs; i++) {
-			ipad[i] ^= 0x36;
-			opad[i] ^= 0x5c;
+			ipad[i] ^= HMAC_IPAD_VALUE;
+			opad[i] ^= HMAC_OPAD_VALUE;
 		}
 
 		rc = crypto_shash_init(shash) ? :
-- 
2.10.2
