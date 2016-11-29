From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 29 Nov 2016 13:05:33 +0000
Subject: [PATCH 4/4] crypto: arm64/aes-ce-ctr: fix skcipher conversion
In-Reply-To: <1480424733-10797-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1480424733-10797-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1480424733-10797-4-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix a missing statement that got lost in the skcipher conversion of
the CTR transform.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/crypto/aes-glue.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/crypto/aes-glue.c b/arch/arm64/crypto/aes-glue.c
index 5c43b92b3714..4e3f8adb1793 100644
--- a/arch/arm64/crypto/aes-glue.c
+++ b/arch/arm64/crypto/aes-glue.c
@@ -206,6 +206,7 @@ static int ctr_encrypt(struct skcipher_request *req)
 				(u8 *)ctx->key_enc, rounds, blocks, walk.iv,
 				first);
 		err = skcipher_walk_done(&walk, walk.nbytes % AES_BLOCK_SIZE);
+		first = 0;
 	}
 	if (walk.nbytes) {
 		u8 __aligned(8) tail[AES_BLOCK_SIZE];
-- 
2.7.4
