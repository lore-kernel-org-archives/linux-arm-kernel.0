From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri,  5 Oct 2018 10:13:31 +0200
Subject: [RFC PATCH 7/9] crypto: crct10dif/generic - switch crypto API driver
 to core library
In-Reply-To: <20181005081333.15018-1-ard.biesheuvel@linaro.org>
References: <20181005081333.15018-1-ard.biesheuvel@linaro.org>
Message-ID: <20181005081333.15018-8-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 crypto/crct10dif_generic.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/crypto/crct10dif_generic.c b/crypto/crct10dif_generic.c
index 8e94e29dc6fc..9ea4242c4921 100644
--- a/crypto/crct10dif_generic.c
+++ b/crypto/crct10dif_generic.c
@@ -53,7 +53,7 @@ static int chksum_update(struct shash_desc *desc, const u8 *data,
 {
 	struct chksum_desc_ctx *ctx = shash_desc_ctx(desc);
 
-	ctx->crc = crc_t10dif_generic(ctx->crc, data, length);
+	ctx->crc = crc_t10dif_update(ctx->crc, data, length);
 	return 0;
 }
 
@@ -68,7 +68,7 @@ static int chksum_final(struct shash_desc *desc, u8 *out)
 static int __chksum_finup(__u16 *crcp, const u8 *data, unsigned int len,
 			u8 *out)
 {
-	*(__u16 *)out = crc_t10dif_generic(*crcp, data, len);
+	*(__u16 *)out = crc_t10dif_update(*crcp, data, len);
 	return 0;
 }
 
-- 
2.11.0
