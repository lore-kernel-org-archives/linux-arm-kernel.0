From: clabbe.montjoie@gmail.com (Corentin Labbe)
Date: Mon, 24 Apr 2017 16:16:29 +0200
Subject: [PATCH 9/9] crypto: ccp - Use IPAD/OPAD constant
In-Reply-To: <20170424141629.27155-1-clabbe.montjoie@gmail.com>
References: <20170424141629.27155-1-clabbe.montjoie@gmail.com>
Message-ID: <20170424141629.27155-9-clabbe.montjoie@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch simply replace all occurrence of HMAC IPAD/OPAD value by their
define.

Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
---
 drivers/crypto/ccp/ccp-crypto-sha.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/ccp/ccp-crypto-sha.c b/drivers/crypto/ccp/ccp-crypto-sha.c
index 6b46eea..3834366 100644
--- a/drivers/crypto/ccp/ccp-crypto-sha.c
+++ b/drivers/crypto/ccp/ccp-crypto-sha.c
@@ -308,8 +308,8 @@ static int ccp_sha_setkey(struct crypto_ahash *tfm, const u8 *key,
 	}
 
 	for (i = 0; i < block_size; i++) {
-		ctx->u.sha.ipad[i] = ctx->u.sha.key[i] ^ 0x36;
-		ctx->u.sha.opad[i] = ctx->u.sha.key[i] ^ 0x5c;
+		ctx->u.sha.ipad[i] = ctx->u.sha.key[i] ^ HMAC_IPAD_VALUE;
+		ctx->u.sha.opad[i] = ctx->u.sha.key[i] ^ HMAC_OPAD_VALUE;
 	}
 
 	sg_init_one(&ctx->u.sha.opad_sg, ctx->u.sha.opad, block_size);
-- 
2.10.2
